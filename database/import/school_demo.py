"""Build the shared 2026 school demo from committed, anonymized source facts."""
import hashlib
from datetime import date, timedelta
from decimal import Decimal

from sqlalchemy import text
from app.api.schemas import BookingWrite
from app.services import bookings
from app.services.analytics import season_contains
from build_synthetic_bookings_seed import ROOM_TYPES, batch_hash

DEMO_VERSION = 'demo_calendar_2026_v1'
MOCK_VERSION = 'extra_mock_bookings_v1'
MOCK_HASH = hashlib.sha256(b'extra_mock_bookings_v1:100:2026').hexdigest()


def batch(db, name, digest, count):
    db.execute(text("""INSERT INTO import_batches(source_system,file_name,file_sha256,row_count,accepted_count,rejected_count,status)
        VALUES('school-project',:name,:digest,:count,:count,0,'completed')
        ON CONFLICT(source_system,file_name,file_sha256) DO NOTHING"""),dict(name=name,digest=digest,count=count))
    return db.execute(text("SELECT id FROM import_batches WHERE source_system='school-project' AND file_name=:name AND file_sha256=:digest"),dict(name=name,digest=digest)).scalar_one()


def place_source_stay(repo, booking_id, row_number, value, inventory, calendars, season_ids):
    """Assign a non-overlapping 2026 stay, keeping source season/nights/total."""
    candidates=[r for r in inventory if r['room_type_id']==ROOM_TYPES[value['room_type']]]
    chosen=None
    for offset in range(365):
        start=date(2026,1,1)+timedelta(days=(row_number*11+offset)%365)
        end=start+timedelta(days=value['days_rented'])
        if end>date(2027,1,1):continue
        if not all(season_contains(start+timedelta(days=n),calendars[value['season']]) for n in range(value['days_rented'])):continue
        for room in candidates:
            if not repo.overlaps(room['id'],start,end,booking_id):
                chosen=(room,start,end);break
        if chosen:break
    if chosen is None:raise ValueError(f'No 2026 slot for source line {row_number}; transaction rolled back')
    room,start,end=chosen
    repo.execute('UPDATE bookings SET room_id=:room,check_in=:start,check_out=:end WHERE id=:id',room=room['id'],start=start,end=end,id=booking_id)
    repo.execute('DELETE FROM booking_price_lines WHERE booking_id=:id',id=booking_id)
    base,remainder=divmod(int(value['price_total']*100),value['days_rented'])
    for n in range(value['days_rented']):
        amount=Decimal(base+(1 if n<remainder else 0))/100
        repo.add_price_line(booking_id,dict(night_date=start+timedelta(days=n),season_id=season_ids[value['season']],price_per_night=amount,line_total=amount))


def add_mock_bookings(repo, country_codes):
    """Use the booking service for prices/validation; stable keys avoid duplicates."""
    mock_batch=batch(repo.db,MOCK_VERSION,MOCK_HASH,100)
    rooms=[r for r in repo.rooms() if r['active'] and r['type_active'] and r['status']=='available']
    added=0
    for i in range(100):
        key=f'Mock:{i+1:03}'
        if repo.one('SELECT id FROM bookings WHERE import_batch_id=:batch AND source_record_id=:key',batch=mock_batch,key=key):continue
        start=date(2026,1,1)+timedelta(days=(i*17)%360)
        nights=1+i%5
        selected=None
        for offset in range(366):
            check_in=start+timedelta(days=offset)
            if check_in+timedelta(days=nights)>date(2027,1,1):break
            for room in rooms[i%len(rooms):]+rooms[:i%len(rooms)]:
                if not repo.overlaps(room['id'],check_in,check_in+timedelta(days=nights)):
                    selected=(room,check_in);break
            if selected:break
        if selected is None:raise ValueError('No available mock room/date; transaction rolled back')
        room,check_in=selected
        payload=BookingWrite(room_id=room['id'],check_in=check_in,check_out=check_in+timedelta(days=nights),
            guests_count=1+i%room['capacity'],guest=dict(name=f'Mock Guest {i+1:03}',
                email=f'mock-{i+1:03}@example.test',phone=f'+45{70000000+i}',country_code=country_codes[i%len(country_codes)]))
        result=bookings.save(repo,payload)
        repo.execute("""UPDATE bookings SET data_origin='synthetic_import',import_batch_id=:batch,
            source_record_id=:key WHERE id=:id""",batch=mock_batch,key=key,id=result['id'])
        added+=1
    return mock_batch,added


def prepare_demo(repo):
    # Serialize bootstrap attempts. Lock order agrees with booking room/type locks.
    repo.rows('SELECT id FROM room_types ORDER BY id FOR UPDATE')
    digest=hashlib.sha256(DEMO_VERSION.encode()).hexdigest()
    if repo.one("SELECT id FROM import_batches WHERE source_system='school-project' AND file_name=:name AND file_sha256=:digest",name=DEMO_VERSION,digest=digest):
        return dict(status='already prepared',source_bookings=1000,extra_mock_bookings=100)
    rows=repo.rows("""SELECT b.id booking_id,b.check_in,b.check_out,c.source_record_id,
        c.source_room_type room_type,c.days_rented,c.season_code season,c.price_total,c.country_code
        FROM customer_stay_records c JOIN import_batches ib ON ib.id=c.import_batch_id
        JOIN bookings b ON b.import_batch_id=c.import_batch_id AND b.source_record_id=c.source_record_id
        WHERE ib.source_system='ITAKEA/hoteldata' AND ib.file_name='international_names_with_rooms_1000.xlsx'
        AND ib.file_sha256=:digest AND c.row_status='accepted' AND b.data_origin='synthetic_import'""",digest=batch_hash())
    if len(rows)!=1000:raise ValueError(f'Expected 1000 committed source stays, found {len(rows)}')
    rows.sort(key=lambda r:int(r['source_record_id'].split(':')[1]))
    inventory=[r for r in repo.rooms() if r['active'] and r['type_active'] and r['status']=='available']
    calendars={code:repo.season_periods(code) for code in ['low','mid','high']}
    season_ids={s['code']:s['season_id'] for s in repo.season_periods()}
    for row in rows:
        # Keep existing 2026 CSV/demo stays and all operational bookings unchanged.
        if row['check_in']>=date(2026,1,1) and row['check_out']<=date(2027,1,1):continue
        place_source_stay(repo,row['booking_id'],int(row['source_record_id'].split(':')[1]),row,inventory,calendars,season_ids)
    mock_batch,added=add_mock_bookings(repo,[r['country_code'] for r in rows])
    if repo.one('SELECT count(*) n FROM bookings WHERE import_batch_id=:id',id=mock_batch)['n']!=100:
        raise ValueError('Expected exactly 100 extra mock bookings')
    # Marker is written last, in the same transaction as all generated rows.
    batch(repo.db,DEMO_VERSION,digest,1000)
    return dict(status='prepared',source_bookings=1000,extra_mock_bookings=100,newly_added_mocks=added)
