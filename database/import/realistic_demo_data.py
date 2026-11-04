"""Deterministic 2026 bar transactions and booking reviews for the demo."""
import hashlib
import random
from bisect import bisect_left
from datetime import date, datetime, time, timedelta, timezone
from decimal import Decimal
from zoneinfo import ZoneInfo

from sqlalchemy import text

from app.services.analytics import season_contains

BAR_VERSION = 'realistic_bar_sales_2026_v1'
BAR_HASH = hashlib.sha256(b'realistic_bar_sales_2026_v1:seed=20261104').hexdigest()
BAR_IMPORTED_AT = datetime(2026, 11, 4, 0, 0)
REVIEW_VERSION = 'realistic_booking_reviews_2026_v1'
REVIEW_HASH = hashlib.sha256(b'realistic_booking_reviews_2026_v1:seed=20261104').hexdigest()
DEMO_AS_OF = date(2026, 11, 4)
LOCAL = ZoneInfo('Europe/Copenhagen')
UTC = timezone.utc

EMPLOYEE_SHARES = {
    'coffee': [('Helene Christine', 42), ('Demo Barista A', 38), ('Demo Service B', 20)],
    'cocktail': [('Helene Christine', 42), ('Demo Bartender A', 31), ('Demo Bartender B', 27)],
}
QUANTITIES = (1, 2, 3, 4, 5, 6)
QUANTITY_WEIGHTS = (58, 36, 4, 1.2, 0.6, 0.2)
COFFEE_HOURS = (7, 8, 9, 10, 14, 15, 16)
COFFEE_HOUR_WEIGHTS = (8, 22, 25, 14, 9, 14, 8)
COCKTAIL_HOURS = (17, 18, 19, 20, 21, 22, 23, 0, 1)
COCKTAIL_HOUR_WEIGHTS = (5, 9, 13, 16, 17, 15, 12, 8, 5)


def _marker(repo, file_name, digest):
    return repo.one("""SELECT id,row_count,accepted_count FROM import_batches
        WHERE source_system='school-project' AND file_name=:name AND file_sha256=:digest""",
        name=file_name, digest=digest)


def _insert_marker(repo, file_name, digest, count):
    repo.execute("""INSERT INTO import_batches
        (source_system,file_name,file_sha256,row_count,accepted_count,rejected_count,status)
        VALUES('school-project',:name,:digest,:count,:count,0,'completed')""",
        name=file_name, digest=digest, count=count)


def _period_code(day, periods):
    for row in periods:
        if season_contains(day, [row]):
            return row['code']
    raise ValueError(f'No configured season covers {day}')


def _daily_calendar(repo):
    occupancy = repo.rows("""SELECT l.night_date,SUM(b.guests_count) guest_nights
        FROM booking_price_lines l JOIN bookings b ON b.id=l.booking_id
        WHERE b.status='confirmed' AND l.night_date>=DATE '2026-01-01'
          AND l.night_date<DATE '2027-01-01'
        GROUP BY l.night_date""")
    guests_by_day = {row['night_date']: int(row['guest_nights']) for row in occupancy}
    average = sum(guests_by_day.values()) / 365
    periods = repo.season_periods()
    days, weights = [], []
    for offset in range(365):
        day = date(2026, 1, 1) + timedelta(days=offset)
        season = _period_code(day, periods)
        season_weight = {'low': 1.0, 'mid': 1.12, 'high': 1.38}[season]
        weekend_weight = 1.32 if day.weekday() >= 5 else 1.0
        guest_weight = 0.20 + guests_by_day.get(day, 0) / max(average, 1)
        days.append(day)
        weights.append(guest_weight * season_weight * weekend_weight)
    cumulative = []
    total = 0.0
    for weight in weights:
        total += weight
        cumulative.append(total)
    return days, cumulative, total


def _weighted_day(rng, days, cumulative, total):
    return days[bisect_left(cumulative, rng.random() * total)]


def _employee(rng, category):
    staff = EMPLOYEE_SHARES.get(category, EMPLOYEE_SHARES['cocktail'])
    return rng.choices([name for name, _ in staff], weights=[weight for _, weight in staff], k=1)[0]


def _clock(rng, category, day):
    if category == 'coffee':
        hour = rng.choices(COFFEE_HOURS, weights=COFFEE_HOUR_WEIGHTS, k=1)[0]
    else:
        hour = rng.choices(COCKTAIL_HOURS, weights=COCKTAIL_HOUR_WEIGHTS, k=1)[0]
    local = datetime.combine(day, time(hour, rng.randrange(60)), LOCAL)
    return local.astimezone(UTC).replace(tzinfo=None)


def _insert_sales(repo):
    marker = _marker(repo, BAR_VERSION, BAR_HASH)
    if marker:
        expected = int(marker['row_count'])
        actual = int(repo.one("SELECT COUNT(*) n FROM bar_sales WHERE created_at=:created_at",
                              created_at=BAR_IMPORTED_AT)['n'])
        if actual != expected:
            raise ValueError(f'Bar demo marker expects {expected} rows, found {actual}')
        return expected, False

    collision = repo.one('SELECT id FROM bar_sales WHERE created_at=:created_at LIMIT 1',
                         created_at=BAR_IMPORTED_AT)
    if collision:
        raise ValueError('Bar demo import timestamp already contains unmarked rows')

    products = repo.rows("""SELECT a.product_id,a.units_sold,a.currency,a.unit_price,
          p.name,p.category,p.price
        FROM customer_bar_sales_aggregates a JOIN bar_products p ON p.id=a.product_id
        WHERE a.row_status='accepted' ORDER BY a.product_id""")
    if not products or any(row['units_sold'] is None or row['currency'] != 'DKK'
                           or row['unit_price'] != row['price'] for row in products):
        raise ValueError('Accepted drink aggregates need products, DKK and matching catalogue prices')

    days, cumulative, total_weight = _daily_calendar(repo)
    rng = random.Random(20261104)
    inserted = 0
    batch_rows = []
    insert_sql = text("""INSERT INTO bar_sales
        (product_id,sold_at,quantity,unit_price,currency,employee_name,created_at)
        VALUES(:product_id,:sold_at,:quantity,:unit_price,'DKK',:employee_name,:created_at)""")

    def flush():
        nonlocal batch_rows
        if batch_rows:
            repo.db.execute(insert_sql, batch_rows)
            batch_rows = []

    for product in products:
        remaining = int(product['units_sold'])
        while remaining:
            quantity = min(rng.choices(QUANTITIES, weights=QUANTITY_WEIGHTS, k=1)[0], remaining)
            day = _weighted_day(rng, days, cumulative, total_weight)
            batch_rows.append(dict(
                product_id=product['product_id'],
                sold_at=_clock(rng, product['category'], day),
                quantity=quantity,
                unit_price=product['price'],
                employee_name=_employee(rng, product['category']),
                created_at=BAR_IMPORTED_AT,
            ))
            inserted += 1
            remaining -= quantity
            if len(batch_rows) >= 5000:
                flush()
    flush()

    _insert_marker(repo, BAR_VERSION, BAR_HASH, inserted)
    return inserted, True


def _review_candidates(repo):
    return repo.rows("""SELECT b.id booking_id,b.check_out,r.room_type_id,
          (SELECT s.code FROM booking_price_lines l JOIN seasons s ON s.id=l.season_id
           WHERE l.booking_id=b.id ORDER BY l.night_date DESC LIMIT 1) season
        FROM bookings b JOIN rooms r ON r.id=b.room_id
        WHERE b.status='confirmed' AND b.check_out<:as_of
        ORDER BY b.id""", as_of=DEMO_AS_OF)


def _rating(candidate, key):
    # Ratings lean positive; suites/high season get a small lift, low season a small dip.
    weights = [2, 4, 14, 45, 35]
    if candidate['room_type_id'] >= 6 or candidate['season'] == 'high':
        weights[2] -= 2
        weights[4] += 2
    elif candidate['season'] == 'low':
        weights[2] += 2
        weights[4] -= 2
    roll = key[4] % sum(weights)
    for rating, weight in enumerate(weights, 1):
        if roll < weight:
            return rating
        roll -= weight
    raise AssertionError('Rating weights did not cover roll')


def _insert_reviews(repo):
    marker = _marker(repo, REVIEW_VERSION, REVIEW_HASH)
    if marker:
        count = int(repo.one("""SELECT COUNT(*) n FROM booking_reviews v
            JOIN bookings b ON b.id=v.booking_id
            WHERE b.status='confirmed' AND b.check_out<:as_of""", as_of=DEMO_AS_OF)['n'])
        if count < int(marker['accepted_count']):
            raise ValueError('Booking review demo marker is present but expected reviews are missing')
        return int(marker['row_count']), False

    candidates = _review_candidates(repo)
    target = round(len(candidates) * 0.40)
    selected = sorted(candidates, key=lambda row: hashlib.sha256(
        f'{REVIEW_VERSION}:{row["booking_id"]}'.encode()).digest())[:target]
    rows = []
    for row in selected:
        digest = hashlib.sha256(f'{REVIEW_VERSION}:rating:{row["booking_id"]}'.encode()).digest()
        after_days = 1 + digest[5] % 4
        available_days = (DEMO_AS_OF - row['check_out']).days
        created_local = datetime.combine(row['check_out'] + timedelta(days=min(after_days, available_days)),
                                         time(12 + digest[6] % 5), LOCAL)
        rows.append(dict(booking_id=row['booking_id'], rating=_rating(row, digest),
                         created_at=created_local.astimezone(UTC).replace(tzinfo=None)))
    if rows:
        repo.db.execute(text("""INSERT INTO booking_reviews(booking_id,rating,created_at,updated_at)
            VALUES(:booking_id,:rating,:created_at,:created_at)
            ON CONFLICT (booking_id) DO NOTHING"""), rows)
    _insert_marker(repo, REVIEW_VERSION, REVIEW_HASH, len(rows))
    return len(rows), True


def prepare_realistic_data(repo):
    sales_count, sales_created = _insert_sales(repo)
    reviews_count, reviews_created = _insert_reviews(repo)
    return dict(bar_sales_rows=sales_count, bar_sales_created=sales_created,
                booking_reviews=reviews_count, booking_reviews_created=reviews_created)
