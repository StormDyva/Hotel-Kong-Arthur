#!/usr/bin/env python3
"""Load exact local CSV rows, link existing demo stays, add 100 extra mock bookings."""
import argparse
import json
import sys
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT/'backend'))
from sqlalchemy import text
from app.repositories.database import engine, Repository
from school_demo import batch, place_source_stay, add_mock_bookings
from import_customer_data import read_csv, validate_guest_row, file_sha256


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
            repo.execute("""UPDATE customer_stay_records c SET first_name=:first,family_name=:last
                FROM bookings b WHERE b.import_batch_id=c.import_batch_id
                AND b.source_record_id=c.source_record_id AND b.id=:id""",
                first=row['First Name'],last=row['Family Name'],id=booking_id)
            already_recorded=repo.one('SELECT booking_id FROM csv_source_rows WHERE import_batch_id=:batch AND source_row_number=:row',batch=bid,row=i)
            if not already_recorded or source_booking['check_in'].year != 2026 or source_booking['check_out']>date(2027,1,1):
                place_source_stay(repo,booking_id,i,value,inventory,calendars,season_ids)
            repo.execute("""INSERT INTO csv_source_rows(import_batch_id,source_row_number,raw_record,booking_id)
                VALUES(:batch,:row,CAST(:raw AS JSON),:booking) ON CONFLICT(import_batch_id,source_row_number) DO NOTHING""",
                batch=bid,row=i,raw=json.dumps(row,ensure_ascii=False),booking=matches[0]['id'])
        mock_batch,added=add_mock_bookings(repo,[v['country_code'] for v in validated])
        saved=repo.rows('SELECT source_row_number,raw_record FROM csv_source_rows WHERE import_batch_id=:id ORDER BY source_row_number',id=bid)
        assert [json.loads(r['raw_record']) if isinstance(r['raw_record'],str) else r['raw_record'] for r in saved]==rows
        # Verify that synthetic nightly snapshots still sum exactly to source prices.
        mismatches=repo.one("""SELECT COUNT(*) n FROM csv_source_rows x JOIN bookings b ON b.id=x.booking_id
            WHERE x.import_batch_id=:id AND (b.price_total<>CAST((x.raw_record->>'Price') AS DECIMAL(12,2))
              OR b.price_total<>(SELECT SUM(l.line_total) FROM booking_price_lines l WHERE l.booking_id=b.id))""",id=bid)['n']
        assert mismatches==0
        mock_count=repo.one('SELECT COUNT(*) n FROM bookings WHERE import_batch_id=:id',id=mock_batch)['n']
        print(json.dumps(dict(csv_rows=len(saved),linked_source_bookings=len(saved),extra_mock_bookings=mock_count,
                             newly_added_mocks=added,encoding_replacement_characters=sum(str(v).count('\ufffd') for r in rows for v in r.values()))))


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--csv',type=Path,required=True)
    load(p.parse_args().csv)
