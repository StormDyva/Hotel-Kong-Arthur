#!/usr/bin/env python3
"""Load exact local CSV rows, link existing demo stays, add 100 extra mock bookings."""
import argparse
import hashlib
import json
import sys
from datetime import date, timedelta
from decimal import Decimal
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'backend'))
from sqlalchemy import text
from app.repositories.database import engine, Repository
from app.api.schemas import BookingWrite
from app.services import bookings
from app.services.analytics import season_contains
from build_synthetic_bookings_seed import ROOM_TYPES
from import_customer_data import read_csv, validate_guest_row, file_sha256


def batch(db, name, digest, count):
    db.execute(text("""INSERT INTO import_batches(source_system,file_name,file_sha256,row_count,accepted_count,rejected_count,status)
        VALUES('school-project',:name,:digest,:count,:count,0,'completed')
        ON DUPLICATE KEY UPDATE id=LAST_INSERT_ID(id)"""),dict(name=name,digest=digest,count=count))
    return db.execute(text("SELECT id FROM import_batches WHERE source_system='school-project' AND file_name=:name AND file_sha256=:digest"),dict(name=name,digest=digest)).scalar_one()


def load(path):
    rows=read_csv(path)
    if len(rows)!=1000:
        raise ValueError(f'Expected 1000 CSV rows, found {len(rows)}')
    validated=[]
    for i,row in enumerate(rows,2):
        value,error=validate_guest_row(row)
        if error: raise ValueError(f'CSV line {i}: {error}')
        validated.append(value)
    with engine.begin() as db:
        # Lock the inventory while constructing this school-project demo batch.
        db.execute(text('SELECT id FROM room_types ORDER BY id FOR UPDATE')).all()
        repo=Repository(db)
        bid=batch(db,path.name,file_sha256(path),len(rows))
        inventory=[r for r in repo.rooms() if r['active'] and r['type_active'] and r['status']=='available']
        calendars={code:repo.season_periods(code) for code in ['low','mid','high']}
        season_ids={s['code']:s['season_id'] for s in repo.season_periods()}
        for i,(row,value) in enumerate(zip(rows,validated),2):
            matches=repo.rows("""SELECT b.id FROM customer_stay_records c
                JOIN bookings b ON b.import_batch_id=c.import_batch_id AND b.source_record_id=c.source_record_id
                WHERE b.data_origin='synthetic_import' AND c.source_record_id=:source
                AND c.source_room_type=:room AND c.days_rented=:days AND c.season_code=:season
                AND c.price_total=:price AND c.country_code=:country""",
                source=f'Sheet1:{i}',room=value['room_type'],days=value['days_rented'],
                season=value['season'],price=value['price_total'],country=value['country_code'])
            if len(matches)!=1:
                raise ValueError(f'CSV row {i}: expected one matching seeded demo booking, found {len(matches)}')
            # Only generated source stays are moved. Operational bookings are never changed.
            booking_id=matches[0]['id']
            source_booking=repo.bookings(booking_id)[0]
            if repo.one('SELECT COUNT(*) n FROM bookings WHERE guest_id=:guest AND id<>:id',guest=source_booking['guest_id'],id=booking_id)['n']:
                raise ValueError(f'Source line {i} has a shared guest; refusing to overwrite another booking')
            repo.execute('UPDATE guests SET first_name=:first,last_name=:last,country_name=:country WHERE id=:id',
                first=row['First Name'],last=row['Family Name'],country=row['Country'],id=source_booking['guest_id'])
            repo.execute("""UPDATE customer_stay_records c JOIN bookings b
                ON b.import_batch_id=c.import_batch_id AND b.source_record_id=c.source_record_id
                SET c.first_name=:first,c.family_name=:last WHERE b.id=:id""",
                first=row['First Name'],last=row['Family Name'],id=booking_id)
            already_recorded=repo.one('SELECT booking_id FROM csv_source_rows WHERE import_batch_id=:batch AND source_row_number=:row',batch=bid,row=i)
            if not already_recorded or source_booking['check_in'].year != 2026 or source_booking['check_out']>date(2027,1,1):
                candidates=[r for r in inventory if r['room_type_id']==ROOM_TYPES[value['room_type']]]
                chosen=None
                for offset in range(365):
                    start=date(2026,1,1)+timedelta(days=(i*11+offset)%365)
                    end=start+timedelta(days=value['days_rented'])
                    if end>date(2027,1,1):continue
                    if not all(season_contains(start+timedelta(days=n),calendars[value['season']]) for n in range(value['days_rented'])):continue
                    for room in candidates:
                        if not repo.overlaps(room['id'],start,end,booking_id):
                            chosen=(room,start,end);break
                    if chosen:break
                if chosen is None:raise ValueError(f'No 2026 slot for source line {i}')
                room,start,end=chosen
                repo.execute('UPDATE bookings SET room_id=:room,check_in=:start,check_out=:end WHERE id=:id',room=room['id'],start=start,end=end,id=booking_id)
                repo.execute('DELETE FROM booking_price_lines WHERE booking_id=:id',id=booking_id)
                cents=int(value['price_total']*100)
                base,remainder=divmod(cents,value['days_rented'])
                for n in range(value['days_rented']):
                    amount=Decimal(base+(1 if n<remainder else 0))/100
                    repo.add_price_line(booking_id,dict(night_date=start+timedelta(days=n),season_id=season_ids[value['season']],price_per_night=amount,line_total=amount))
            repo.execute("""INSERT INTO csv_source_rows(import_batch_id,source_row_number,raw_record,booking_id)
                VALUES(:batch,:row,:raw,:booking) ON DUPLICATE KEY UPDATE source_row_number=VALUES(source_row_number)""",
                batch=bid,row=i,raw=json.dumps(row,ensure_ascii=False),booking=matches[0]['id'])
        mock_batch=batch(db,'extra_mock_bookings_v1',hashlib.sha256(b'extra_mock_bookings_v1:100:2026').hexdigest(),100)
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
                if check_in+timedelta(days=nights)>date(2027,1,1): break
                for room in rooms[i%len(rooms):]+rooms[:i%len(rooms)]:
                    if not repo.overlaps(room['id'],check_in,check_in+timedelta(days=nights)):
                        selected=(room,check_in);break
                if selected:break
            if selected is None:raise ValueError('No available mock room/date; transaction rolled back')
            room,check_in=selected
            p=BookingWrite(room_id=room['id'],check_in=check_in,check_out=check_in+timedelta(days=nights),
                guests_count=1+i%room['capacity'],guest=dict(name=f'Mock Guest {i+1:03}',
                    email=f'mock-{i+1:03}@example.test',phone=f'+45{70000000+i}',country_code=validated[i%len(validated)]['country_code']))
            result=bookings.save(repo,p)
            repo.execute("""UPDATE bookings SET data_origin='synthetic_import',import_batch_id=:batch,
                source_record_id=:key WHERE id=:id""",batch=mock_batch,key=key,id=result['id'])
            added+=1
        saved=repo.rows('SELECT source_row_number,raw_record FROM csv_source_rows WHERE import_batch_id=:id ORDER BY source_row_number',id=bid)
        assert [json.loads(r['raw_record']) if isinstance(r['raw_record'],str) else r['raw_record'] for r in saved]==rows
        # Verify that synthetic nightly snapshots still sum exactly to source prices.
        mismatches=repo.one("""SELECT COUNT(*) n FROM csv_source_rows x JOIN bookings b ON b.id=x.booking_id
            WHERE x.import_batch_id=:id AND (b.price_total<>CAST(JSON_UNQUOTE(JSON_EXTRACT(x.raw_record,'$.Price')) AS DECIMAL(12,2))
              OR b.price_total<>(SELECT SUM(l.line_total) FROM booking_price_lines l WHERE l.booking_id=b.id))""",id=bid)['n']
        assert mismatches==0
        mock_count=repo.one('SELECT COUNT(*) n FROM bookings WHERE import_batch_id=:id',id=mock_batch)['n']
        print(json.dumps(dict(csv_rows=len(saved),linked_source_bookings=len(saved),extra_mock_bookings=mock_count,
                             newly_added_mocks=added,encoding_replacement_characters=sum(str(v).count('\ufffd') for r in rows for v in r.values()))))


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--csv',type=Path,required=True)
    load(p.parse_args().csv)
