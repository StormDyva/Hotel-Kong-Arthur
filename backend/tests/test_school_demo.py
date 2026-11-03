"""The same bootstrap used by Compose works on fresh and existing school data."""
import sys
from pathlib import Path
import pytest
from test_api import repo, payload
from app.api.schemas import BookingWrite
from app.services import bookings, analytics

IMPORT = Path('/project/database/import')
if not IMPORT.is_dir(): IMPORT = Path(__file__).resolve().parents[2]/'database/import'
sys.path.insert(0,str(IMPORT))
import school_demo


def test_complete_demo_upgrade_and_repeat_preserve_existing_bookings(repo):
    p=payload();p.update(check_in='2026-01-23',check_out='2026-01-25')
    existing=bookings.save(repo,BookingWrite(**p))
    before=repo.bookings(existing['id'])[0]
    result=school_demo.prepare_demo(repo)
    assert result['newly_added_mocks']==100
    assert repo.one('SELECT count(*) n FROM bookings')['n']==1105  # four base + 1000 + 100 + this test booking
    assert repo.one("SELECT count(*) n FROM bookings WHERE data_origin='synthetic_import' AND check_in>='2026-01-01' AND check_out<='2027-01-01'")['n']==1100
    assert repo.bookings(existing['id'])[0]==before
    assert len(analytics.report(repo,year=2026)['by_country'])==21
    assert repo.one("""SELECT count(*) n FROM bookings b WHERE data_origin='synthetic_import'
        AND b.price_total IS DISTINCT FROM (SELECT sum(line_total) FROM booking_price_lines l WHERE l.booking_id=b.id)""")['n']==0
    assert repo.one("""SELECT count(*) n FROM bookings a JOIN bookings b ON a.id<b.id AND a.room_id=b.room_id
        AND a.check_in<b.check_out AND a.check_out>b.check_in WHERE a.status='confirmed' AND b.status='confirmed'""")['n']==0
    snapshots=repo.rows("SELECT id,guest_id,room_id,check_in,check_out,price_total FROM bookings ORDER BY id")
    assert school_demo.prepare_demo(repo)['status']=='already prepared'
    assert repo.rows("SELECT id,guest_id,room_id,check_in,check_out,price_total FROM bookings ORDER BY id")==snapshots
    # Simulate a volume already populated with 2026 CSV stays + the old 100 mocks,
    # but without the new automatic-bootstrap marker. No duplicate or moved stays.
    repo.execute('DELETE FROM import_batches WHERE file_name=:name',name=school_demo.DEMO_VERSION)
    assert school_demo.prepare_demo(repo)['newly_added_mocks']==0
    assert repo.rows("SELECT id,guest_id,room_id,check_in,check_out,price_total FROM bookings ORDER BY id")==snapshots


def test_failed_bootstrap_rolls_back_and_can_retry(repo,monkeypatch):
    before=repo.rows('SELECT id,check_in,check_out FROM bookings ORDER BY id')
    def fail(*args):raise ValueError('simulated mock generation failure')
    with monkeypatch.context() as patch:
        patch.setattr(school_demo,'add_mock_bookings',fail)
        with pytest.raises(ValueError,match='simulated'):
            with repo.db.begin_nested():school_demo.prepare_demo(repo)
    assert repo.rows('SELECT id,check_in,check_out FROM bookings ORDER BY id')==before
    assert repo.one('SELECT count(*) n FROM import_batches WHERE file_name=:name',name=school_demo.DEMO_VERSION)['n']==0
    assert school_demo.prepare_demo(repo)['status']=='prepared'
