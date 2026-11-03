from datetime import date, datetime, timezone
from decimal import Decimal
import pytest
from test_api import repo, client, payload
from app.services import analytics


def test_reference_inventory(client):
    rooms = client.get('/api/rooms').json()
    assert len(rooms) == 214
    assert sum(r['capacity'] for r in rooms) == 428
    types = client.get('/api/room-types').json()
    assert {r['name'] for r in types} == {'Standard enkeltværelse','Grand lit værelse',
        'Standard dobbeltværelse','Superior dobbeltværelse','Junior suite','Spa executive','Suite','LOFT suite'}
    products = client.get('/api/bar-products').json()
    assert sum(p['category']=='cocktail' for p in products) >= 20
    assert sum(p['category']=='coffee' for p in products) >= 10


def test_booking_filters_and_room_change(client):
    first = client.get('/api/bookings/1001').json()
    for query in ['room_id=102','guest_id='+str(first['guest_id']), 'from=2026-06-10&to=2026-06-12&status=confirmed']:
        r = client.get('/api/bookings?'+query).json()
        assert any(b['id']==1001 for b in r['items'])
        assert r['applied_filters']
    assert client.get('/api/bookings?from=2026-06-12&to=2026-06-13&room_id=102').json()['items'] == []
    assert client.get('/api/bookings?from=2026-06-12&to=2026-06-12').status_code == 422
    b = client.post('/api/bookings',json=payload()).json()
    p = payload(); p['room_id'] = 401
    moved = client.put(f"/api/bookings/{b['id']}",json=p)
    assert moved.status_code == 200, moved.text
    assert moved.json()['room_id'] == 401
    assert client.post('/api/bookings',json=payload()).status_code == 201


def test_analytics_filters_and_denominators(client):
    base = '/api/analytics/occupancy?year=2026'
    summary = client.get(base+'&country_code=DK&room_type_id=2&season=high').json()
    assert summary['data']['room_nights'] == 2
    assert Decimal(summary['data']['revenue']) == 3600
    assert summary['data']['available_room_nights'] == 50*(92+12)
    assert summary['applied_filters']['country_code'] == 'DK'
    assert client.get(base+'&from=2026-01-01').status_code == 422
    assert client.get(base+'&season=invalid').status_code == 422
    assert client.get(base+'&country_code=Denmark').status_code == 422
    empty = client.get(base+'&room_type_id=99999').json()
    assert empty['data']['occupancy_percent'] == 0
    assert empty['data']['revenue'] == '0'
    assert empty['warnings']


def test_revenue_rankings_and_country_guests(client):
    rows = client.get('/api/analytics/revenue-by-room-type-season?year=2026').json()['data']
    assert sum(Decimal(g['revenue']) for g in rows) == 12700
    top = client.get('/api/analytics/top-performers?year=2026').json()['data']
    assert top['top_room']['label'] == '302'
    assert top['top_country']['label'] == 'DE'
    countries = client.get('/api/analytics/guests-by-country?year=2026').json()['data']
    dk = next(g for g in countries if g['label']=='DK')
    assert dk['booking_guests'] == 2 and dk['distinct_bookers'] == 1
    assert dk['guest_nights'] == 4


def test_bars_total_category_shares_and_live_input(client):
    url = '/api/analytics/bar-sales?year=2026'
    baseline = client.get(url).json()['data']
    assert Decimal(baseline['total_revenue']) == 575
    assert sum(Decimal(c['percent']) for c in baseline['categories']) == 100
    p = dict(product_id=1,sold_at='2026-10-28T17:30:00+01:00',quantity=2,employee_name='Helene Christine')
    sale = client.post('/api/bar-sales',json=p)
    assert sale.status_code == 201, sale.text
    assert Decimal(sale.json()['unit_price']) == 125
    assert sale.json()['sold_at'].startswith('2026-10-28T16:30:00')
    assert Decimal(client.get(url).json()['data']['total_revenue']) == 825
    other = client.get(url+'&employee_name=Mads%20Hansen').json()['data']
    assert Decimal(other['total_revenue']) == 135
    # Hotel geography must not silently filter sales with no booking relation.
    assert client.get(url+'&country_code=XX').json()['data']['total_revenue'] == '825.00'
    p['sold_at'] = '2026-10-28T17:30:00'
    assert client.post('/api/bar-sales',json=p).status_code == 422
    p['sold_at'] += '+01:00'; p['quantity'] = 0
    assert client.post('/api/bar-sales',json=p).status_code == 422


def test_bar_calendar_boundaries_use_copenhagen(client):
    product_price=next(p['price'] for p in client.get('/api/bar-products').json() if p['id']==2)
    p = dict(product_id=2,sold_at='2025-12-31T23:30:00Z',quantity=1,employee_name='Boundary Test')
    assert client.post('/api/bar-sales',json=p).status_code == 201
    assert Decimal(client.get('/api/analytics/bar-sales?year=2026&employee_name=Boundary%20Test').json()['data']['total_revenue']) == Decimal(product_price)
    assert client.get('/api/analytics/bar-sales?year=2025&employee_name=Boundary%20Test').json()['data']['total_revenue'] == '0'


def test_guest_feedback_and_response_rate(client):
    path = '/api/bookings/1001/review'
    assert client.get(path).status_code == 404
    assert client.put(path,json={'rating':5}).status_code == 200
    assert client.put(path,json={'rating':4}).json()['rating'] == 4
    assert client.get(path).json()['rating'] == 4
    report = client.get('/api/analytics/customer-satisfaction?year=2026').json()['data']
    assert report['rated_bookings'] == 1 and report['eligible_bookings'] == 3
    assert Decimal(report['average_rating']) == 4
    assert Decimal(report['response_percent']) == Decimal('33.33')
    assert sum(r['count'] for r in report['distribution']) == 1
    for rating in [0,6,1.5,True]:
        assert client.put(path,json={'rating':rating}).status_code == 422
    assert client.put('/api/bookings/1003/review',json={'rating':5}).status_code == 409
    future = client.post('/api/bookings',json=payload()).json()['id']
    assert client.put(f'/api/bookings/{future}/review',json={'rating':5}).status_code == 409
    client.delete('/api/bookings/1001')
    assert client.get('/api/analytics/customer-satisfaction?year=2026').json()['data']['average_rating'] is None


def test_swagger_local_assets_and_errors(client):
    html = client.get('/docs').text
    assert 'cdn.jsdelivr.net' not in html
    for asset in ['swagger-ui.css','swagger-ui-bundle.js','favicon-32x32.png']:
        assert client.get('/static/swagger/'+asset).status_code == 200
    assert client.get('/does-not-exist').json()['error'] == 'NOT_FOUND'
    for path in ['/api/analytics/bar-sales','/api/analytics/guests-by-country','/api/analytics/customer-satisfaction']:
        assert path in client.get('/openapi.json').json()['paths']


def test_request_validation_and_error_schema(client):
    p = payload(); p['guest']['email'] = 'a@a..com'
    assert client.post('/api/bookings',json=p).status_code == 422
    p = payload(); p['guest']['phone'] = 'abcdef'
    assert client.post('/api/bookings',json=p).status_code == 422
    p = payload(); p['guests_count'] = True
    assert client.post('/api/bookings',json=p).status_code == 422
    p = payload(); del p['status']
    assert client.put('/api/bookings/1001',json=p).status_code == 422
    assert client.post('/api/bar-sales',json=dict(product_id=1, sold_at='2040-01-01T12:00:00Z',
        quantity=1,employee_name='Helene Christine')).status_code == 422
    missing = client.get('/api/bookings/999999').json()
    assert set(missing)=={'error','message','details'}


def test_openapi_31_validation():
    from openapi_spec_validator import validate
    from app.api.main import app
    validate(app.openapi())


def test_christmas_season_boundary(client):
    rows = client.get('/api/rooms/availability?check_in=2027-12-19&check_out=2027-12-21&guests_count=1').json()
    room = next(r for r in rows if r['room_id']==101)
    assert Decimal(room['total_price']) == 2100  # low 900 + Christmas high 1200
    summary = client.get('/api/analytics/occupancy?year=2026&season=high').json()['data']
    assert summary['available_room_nights'] == 214*(92+12)
