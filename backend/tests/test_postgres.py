"""PostgreSQL-specific regression coverage: dialect, constraints and seed integrity."""
from decimal import Decimal
import pytest
from sqlalchemy.exc import IntegrityError
from test_api import repo, client, payload


def test_postgres_seed_integrity(repo):
    assert repo.one('SELECT version() v')['v'].startswith('PostgreSQL 17.')
    assert repo.one("SHOW TIME ZONE")['TimeZone'] == 'UTC'
    assert repo.one("SELECT count(*) n FROM bookings WHERE data_origin='synthetic_import'")['n'] == 1000
    assert repo.one("""SELECT count(*) n FROM bookings b WHERE data_origin='synthetic_import'
        AND b.price_total<>(SELECT sum(line_total) FROM booking_price_lines l WHERE l.booking_id=b.id)""")['n'] == 0


def test_employee_filter_ignores_case_and_surrounding_whitespace(client):
    result = client.get('/api/analytics/bar-sales?year=2026&employee_name=%20hELENE%20cHRISTINE%20')
    assert result.status_code == 200, result.text
    assert Decimal(result.json()['data']['total_revenue']) == Decimal('575')


def test_database_rejects_invalid_capacity_and_rating(repo):
    for sql in [
        'UPDATE room_types SET capacity=0 WHERE id=1',
        "UPDATE rooms SET status='broken-value' WHERE id=101",
        'INSERT INTO booking_reviews(booking_id,rating) VALUES(1001,6)',
        "INSERT INTO bookings(guest_id,room_id,check_in,check_out,guests_count,price_total) VALUES(1,101,'2090-01-01','2090-01-02',2,900)",
    ]:
        with pytest.raises(IntegrityError):
            with repo.db.begin_nested():
                repo.execute(sql)


def test_returning_ids_and_updated_at(client, repo):
    booking = client.post('/api/bookings', json=payload())
    assert booking.status_code == 201, booking.text
    bid = booking.json()['id']
    assert bid > 1004  # explicit fixture IDs must not collide with identity counters
    repo.execute("UPDATE bookings SET updated_at='2000-01-01' WHERE id=:id", id=bid)
    repo.execute("UPDATE bookings SET price_total=price_total WHERE id=:id", id=bid)
    assert repo.bookings(bid)[0]['updated_at'].year > 2000
