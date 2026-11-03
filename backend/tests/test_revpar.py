from decimal import Decimal
from test_api import repo, client, payload

PATH='/api/analytics/revpar'


def test_revpar_seed_and_months(client):
    r=client.get(PATH+'?year=2026')
    assert r.status_code==200,r.text
    data=r.json()['data']
    assert Decimal(data['revpar'])==Decimal('0.16')
    assert data['available_room_nights']==214*365
    assert Decimal(data['revenue'])==12700
    assert len(data['monthly'])==12
    june=next(m for m in data['monthly'] if m['month']=='2026-06')
    assert Decimal(june['revpar'])==Decimal('0.56')
    assert sum(Decimal(m['revenue']) for m in data['monthly'])==Decimal(data['revenue'])
    assert sum(m['available_room_nights'] for m in data['monthly'])==data['available_room_nights']
    assert client.get('/api/analytics/dashboard?year=2026').json()['summary']['revpar']==data['revpar']


def test_revpar_filters_and_zero_capacity(client):
    body=client.get(PATH+'?year=2026&room_type_id=2&country_code=DK&season=high').json()
    assert Decimal(body['data']['revpar'])==Decimal('0.69')
    assert body['data']['available_room_nights']==50*104
    assert body['warnings']  # months outside the selected season have no capacity
    empty=client.get(PATH+'?year=2026&room_type_id=99999').json()
    assert Decimal(empty['data']['revpar'])==0 and empty['warnings']
    assert all(Decimal(m['revpar'])==0 for m in empty['data']['monthly'])
    no_sales=client.get(PATH+'?year=2090').json()['data']
    assert Decimal(no_sales['revpar'])==0 and no_sales['available_room_nights']>0


def test_revpar_partial_months_historical_prices_and_cancel(client):
    p=payload()
    b=client.post('/api/bookings',json=p).json()
    url=PATH+'?from=2028-03-31&to=2028-04-02&country_code=DK'
    data=client.get(url).json()['data']
    assert Decimal(data['revpar'])==Decimal('4.67')
    assert [m['available_room_nights'] for m in data['monthly']]==[214,214]
    assert [Decimal(m['revenue']) for m in data['monthly']]==[900,1100]
    client.delete('/api/bookings/'+str(b['id']))
    assert Decimal(client.get(url).json()['data']['revpar'])==0
    assert client.get(PATH+'?year=2026&from=2026-01-01').status_code==422
