"""ALOS (C-013): gennemsnitlig opholdslængde pr. bekræftet booking efter check-in-kohorte."""
from test_api import repo, client, payload

ALOS = '/analytics/bookings/average-stay-length'


def book(client, check_in, check_out, country='DK'):
    body = payload()
    body.update(check_in=check_in, check_out=check_out)
    body['guest'] = {**body['guest'], 'country_code': country}
    response = client.post('/api/bookings', json=body)
    assert response.status_code == 201, response.text
    return response.json()['id']


def test_alos_counts_whole_stay_by_check_in_and_excludes_cancelled(client):
    book(client, '2083-03-01', '2083-03-04')              # 3 nætter
    book(client, '2083-03-10', '2083-03-15', 'SE')        # 5 nætter
    book(client, '2083-12-30', '2084-01-02')              # 3 nætter; checkout efter perioden
    cancelled = book(client, '2083-06-01', '2083-06-08')  # annulleres og tæller ikke
    assert client.delete(f'/api/bookings/{cancelled}').status_code == 204

    response = client.get(ALOS + '?year=2083')
    assert response.status_code == 200, response.text
    data = response.json()
    assert data['end_exclusive'] is True
    assert data['summary'] == {'bookings': 3, 'room_nights': 11, 'average_stay_nights': 3.67}

    months = {row['month']: row for row in data['monthly']}
    assert len(months) == 12
    assert months['2083-03'] == {'month': '2083-03', 'bookings': 2, 'room_nights': 8, 'average_stay_nights': 4.0}
    assert months['2083-12']['room_nights'] == 3
    assert months['2083-06']['bookings'] == 0 and months['2083-06']['average_stay_nights'] is None

    countries = {row['country_code']: row['average_stay_nights'] for row in data['by_country']}
    assert countries == {'DK': 3.0, 'SE': 5.0}
    assert sum(row['bookings'] for row in data['by_room_type']) == 3


def test_alos_empty_period_returns_null_average_not_error(client):
    data = client.get(ALOS + '?year=2090').json()
    assert data['summary'] == {'bookings': 0, 'room_nights': 0, 'average_stay_nights': None}
    assert len(data['monthly']) == 12 and data['by_country'] == [] and data['by_room_type'] == []


def test_alos_rejects_invalid_period(client):
    assert client.get(ALOS + '?from=2083-02-01&to=2083-01-01').status_code == 422
