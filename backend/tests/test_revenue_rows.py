from decimal import Decimal
from test_api import repo, client, payload

MATRIX = '/analytics/revenue/by-room-type-season'
COUNTRIES = '/analytics/revenue/by-country'


def test_full_matrix_numeric_revenue_and_golden_total(client):
    response = client.get(MATRIX+'?year=2026')
    assert response.status_code == 200, response.text
    rows = response.json()
    assert len(rows) == 24
    assert len({(r['roomType'],r['season']) for r in rows}) == 24
    assert len({r['roomType'] for r in rows}) == 8
    assert {r['season'] for r in rows} == {'Lav','Mellem','Høj'}
    assert all(set(r)=={'roomType','season','revenue'} for r in rows)
    assert all(isinstance(r['revenue'],(int,float)) for r in rows)
    assert sum(Decimal(str(r['revenue'])) for r in rows) == 12700
    assert any(r['revenue']==0 for r in rows)


def test_empty_period_keeps_all_combinations_even_for_inactive_type(client,repo):
    repo.execute('UPDATE room_types SET active=FALSE WHERE id=8')
    rows = client.get(MATRIX+'?year=2040').json()
    assert len(rows)==24 and all(r['revenue']==0 for r in rows)
    assert client.get(COUNTRIES+'?year=2040').json()==[]


def test_country_rows_are_flat_grouped_and_exclude_cancelled(client):
    rows = client.get(COUNTRIES+'?year=2026').json()
    assert {r['country']:r['revenue'] for r in rows} == {'Danmark':3600,'Storbritannien':2300,'Tyskland':6800}
    assert all(set(r)=={'country','revenue'} for r in rows)
    assert sum(r['revenue'] for r in rows)==12700


def test_nightly_calculation_cross_season_clipping_and_cancellation(client,repo):
    repo.execute("UPDATE room_type_prices p JOIN seasons s ON s.id=p.season_id SET p.price_per_night=900.15 WHERE p.room_type_id=1 AND s.code='low'")
    repo.execute("UPDATE room_type_prices p JOIN seasons s ON s.id=p.season_id SET p.price_per_night=1100.27 WHERE p.room_type_id=1 AND s.code='mid'")
    p = payload(); p['guest']['country_code']='SE'
    booking = client.post('/api/bookings',json=p)
    assert booking.status_code==201, booking.text
    assert Decimal(booking.json()['price_total'])==Decimal('2000.42')
    # Sum of nightly rates equals rate × number of nights within each season.
    rows = client.get(MATRIX+'?year=2028').json()
    single = {r['season']:r['revenue'] for r in rows if r['roomType']=='Standard enkeltværelse'}
    assert single == {'Lav':900.15,'Mellem':1100.27,'Høj':0}
    assert client.get(COUNTRIES+'?year=2028').json()==[{'country':'Sverige','revenue':2000.42}]
    assert client.get(COUNTRIES+'?from=2028-04-01&to=2028-04-02').json()==[{'country':'Sverige','revenue':1100.27}]
    assert client.get(COUNTRIES+'?from=2028-04-02&to=2028-04-03').json()==[]
    client.delete('/api/bookings/'+str(booking.json()['id']))
    assert all(r['revenue']==0 for r in client.get(MATRIX+'?year=2028').json())
    assert client.get(COUNTRIES+'?year=2028').json()==[]


def test_invalid_period_is_consistent_on_both_exports(client):
    for path in [MATRIX,COUNTRIES]:
        assert client.get(path+'?year=2026&from=2026-01-01').status_code==422
        assert client.get(path+'?from=2026-02-01&to=2026-01-01').status_code==422
