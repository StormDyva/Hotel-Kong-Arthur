"""Integration checks against a real MySQL database; transaction rolled back per test."""
from concurrent.futures import ThreadPoolExecutor
from datetime import date
from decimal import Decimal
import pytest
from fastapi.testclient import TestClient
from app.api.main import app, repository
from app.repositories.database import engine, Repository
from app.services import bookings, analytics

@pytest.fixture
def repo():
    with engine.connect() as connection:
        tx = connection.begin()
        yield Repository(connection)
        tx.rollback()

@pytest.fixture
def client(repo):
    app.dependency_overrides[repository] = lambda: repo
    with TestClient(app) as client:
        yield client
    app.dependency_overrides.clear()


def payload(**kw):
    return dict(room_id=101, check_in='2028-03-31', check_out='2028-04-02', guests_count=1,
                guest=dict(name='Integration Guest', email='test@example.com', phone='+4512345678', country_code='DK'),
                price_total=1, status='confirmed', **kw)


def test_live_crud_and_prices(client, repo):
    response = client.post('/api/bookings', json=payload())
    assert response.status_code == 201, response.text
    b = response.json()
    assert Decimal(b['price_total']) == 2000  # 900 low + 1100 mid, ignores submitted price
    assert repo.one('SELECT price_total FROM bookings WHERE id=:id', id=b['id'])['price_total'] == 2000
    assert client.get(f"/api/bookings/{b['id']}").json()['guest']['name'] == 'Integration Guest'
    assert client.post('/api/bookings', json=payload()).status_code == 409
    before = repo.one('SELECT COUNT(*) n FROM guests')['n']
    assert client.put(f"/api/bookings/{b['id']}", json=payload()).status_code == 200
    assert repo.one('SELECT COUNT(*) n FROM guests')['n'] == before
    for _ in range(2):
        assert client.delete(f"/api/bookings/{b['id']}").status_code == 204
    assert repo.one('SELECT status FROM bookings WHERE id=:id', id=b['id'])['status'] == 'cancelled'
    assert client.post('/api/bookings', json=payload()).status_code == 201


def test_validation(client):
    p = payload(); p['check_out'] = p['check_in']
    assert client.post('/api/bookings', json=p).status_code == 422
    p = payload(); p['guests_count'] = 2
    assert client.post('/api/bookings', json=p).status_code == 422
    p = payload(); p['price_total'] = -1
    assert client.post('/api/bookings', json=p).status_code == 422
    p = payload(); p['guest']['email'] = 'invalid'
    assert client.post('/api/bookings', json=p).status_code == 422
    assert client.get('/api/bookings/9999999').status_code == 404
    assert client.get('/api/bookings?page_size=101').status_code == 422
    assert client.get('/api/analytics/dashboard?from=2026-02-01&to=2026-01-01').status_code == 422


def test_golden_analytics(repo):
    r = analytics.report(repo)
    assert r['summary']['revenue'] == 12700
    assert r['summary']['room_nights'] == 6
    assert r['summary']['available_room_nights'] == 214*365
    assert r['summary']['occupancy_percent'] == 0.01
    assert r['summary']['bar_revenue'] == 575
    assert next(x for x in r['bar_categories'] if x['category']=='cocktail')['percent'] == Decimal('43.48')
    r = analytics.report(repo, date(2026,6,11), date(2026,6,12))
    assert r['summary']['revenue'] == 1800
    assert r['summary']['room_nights'] == 1
    assert analytics.report(repo, date(2040,1,1), date(2041,1,1))['summary']['revenue'] == 0


def test_cancellation_after_maintenance(client, repo):
    b = client.post('/api/bookings', json=payload()).json()
    repo.execute("UPDATE rooms SET status='maintenance' WHERE id=101")
    assert client.delete(f"/api/bookings/{b['id']}").status_code == 204


def test_openapi_contract():
    import yaml
    from pathlib import Path
    spec = yaml.safe_load((Path(__file__).parents[2]/'openapi/openapi.yaml').read_text())
    assert spec == app.openapi()


def test_concurrent_booking():
    # Dedicated far-future dates; delete ONLY the records created by this test.
    from app.api.schemas import BookingWrite
    from sqlalchemy import text
    p = payload(); p.update(check_in='2045-01-01', check_out='2045-01-03')
    ids = []
    def create(_):
        try:
            with engine.begin() as c:
                b = bookings.save(Repository(c), BookingWrite(**p))
                ids.append((b['id'], b['guest_id']))
            return 201
        except bookings.DomainError as e:
            return e.status
    try:
        with ThreadPoolExecutor(max_workers=2) as pool:
            assert sorted(pool.map(create, range(2))) == [201,409]
    finally:
        with engine.begin() as c:
            for bid, gid in ids:
                c.execute(text('DELETE FROM booking_price_lines WHERE booking_id=:id'),dict(id=bid))
                c.execute(text('DELETE FROM bookings WHERE id=:id'),dict(id=bid))
                c.execute(text('DELETE FROM guests WHERE id=:id'),dict(id=gid))


def test_health_pagination_and_dashboard_contract(client):
    assert client.get('/health').json() == dict(status='ok', database='ok')
    first = client.get('/api/bookings?page_size=1').json()
    second = client.get('/api/bookings?page_size=1&page=2').json()
    assert len(first['items']) == len(second['items']) == 1
    assert first['items'][0]['id'] != second['items'][0]['id']
    r = client.get('/api/analytics/dashboard')
    assert r.status_code == 200, r.text
    assert Decimal(r.json()['summary']['revenue']) == 12700
    assert r.json()['by_room_type_season']
