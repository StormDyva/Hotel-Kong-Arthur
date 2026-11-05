"""Tableau-ready revenue: all multiplication and grouping happens in this layer."""
from datetime import timedelta, timezone
from decimal import Decimal
from math import sqrt
from zoneinfo import ZoneInfo
from .analytics import period, utc_midnight

LOCAL = ZoneInfo('Europe/Copenhagen')

SEASON_NAMES = {'low': 'Lav', 'mid': 'Mellem', 'high': 'Høj'}
COUNTRY_NAMES = {
    'DK': 'Danmark', 'SE': 'Sverige', 'NO': 'Norge', 'FI': 'Finland', 'IS': 'Island',
    'DE': 'Tyskland', 'NL': 'Holland', 'BE': 'Belgien', 'FR': 'Frankrig', 'ES': 'Spanien',
    'IT': 'Italien', 'PL': 'Polen', 'AT': 'Østrig', 'CH': 'Schweiz', 'GB': 'Storbritannien',
    'IE': 'Irland', 'US': 'USA', 'CA': 'Canada', 'AU': 'Australien', 'CN': 'Kina',
    'JP': 'Japan', 'IN': 'Indien', 'BR': 'Brasilien', 'EG': 'Egypten', 'MX': 'Mexico',
    'NG': 'Nigeria', 'PK': 'Pakistan', 'RU': 'Rusland', 'KR': 'Sydkorea', 'VN': 'Vietnam',
}


def room_type_season(repo, start=None, end=None, year=None):
    start, end = period(start, end, year)
    types, seasons = repo.revenue_dimensions()
    # Initialize the complete Cartesian product, including inactive historical types.
    totals = {(t['id'], s['code']): Decimal('0') for t in types for s in seasons}
    for night in repo.nights(start, end):
        totals[night['room_type_id'], night['season']] += night['price_per_night'] * night['quantity']
    return [dict(roomType=t['name'], season=SEASON_NAMES.get(s['code'], s['name']),
                 revenue=totals[t['id'], s['code']]) for t in types for s in seasons]


def by_country(repo, start=None, end=None, year=None):
    start, end = period(start, end, year)
    totals, names = {}, {}
    for night in repo.nights(start, end):
        code = night['country_code']
        names[code] = COUNTRY_NAMES.get(code, night['country_name'] or code)
        totals[code] = totals.get(code, Decimal('0')) + night['price_per_night'] * night['quantity']
    return [dict(country=names[code], revenue=totals[code])
            for code in sorted(totals, key=lambda c: (names[c], c))]


def combined_revenue(repo, start, end):
    """Return hotel and all dated bar revenue for one shared period."""
    hotel = sum((row['line_total'] for row in repo.nights(start, end)), Decimal('0'))
    bar = sum((row['quantity'] * row['unit_price'] for row in
               repo.sales(utc_midnight(start), utc_midnight(end), None)), Decimal('0'))
    return [dict(hotelRevenue=hotel, barRevenue=bar, totalRevenue=hotel + bar)]


def _pearson(left, right):
    if len(left) != len(right) or len(left) < 2:
        return None
    x_mean = sum(left) / len(left)
    y_mean = sum(right) / len(right)
    x_centered = [value - x_mean for value in left]
    y_centered = [value - y_mean for value in right]
    x_variance = sum(value * value for value in x_centered)
    y_variance = sum(value * value for value in y_centered)
    if not x_variance or not y_variance:
        return None
    return round(sum(x * y for x, y in zip(x_centered, y_centered)) /
                 sqrt(x_variance * y_variance), 4)


def daily_combined(repo, start, end):
    """Daily hotel/bar values and backend-calculated Pearson correlations."""
    start, end = period(start, end)
    dates = [start + timedelta(days=offset) for offset in range((end - start).days)]
    daily = {day: dict(date=day, hotelRevenue=Decimal('0'), barRevenue=Decimal('0'),
                       guestNights=0, roomNights=0) for day in dates}

    for night in repo.nights(start, end):
        point = daily[night['night_date']]
        point['hotelRevenue'] += night['line_total']
        point['guestNights'] += night['guests_count']
        point['roomNights'] += 1

    for sale in repo.sales(utc_midnight(start), utc_midnight(end), None):
        local_date = sale['sold_at'].replace(tzinfo=timezone.utc).astimezone(LOCAL).date()
        if local_date in daily:
            daily[local_date]['barRevenue'] += sale['quantity'] * sale['unit_price']

    active_rooms = sum(1 for room in repo.rooms() if room['active'] and room['type_active'])
    rows = []
    for day in dates:
        point = daily[day]
        point['occupancyPercent'] = round(100 * point['roomNights'] / active_rooms, 2) if active_rooms else 0.0
        rows.append(point)

    bar_values = [float(row['barRevenue']) for row in rows]
    guest_values = [row['guestNights'] for row in rows]
    hotel_values = [float(row['hotelRevenue']) for row in rows]
    return dict(from_date=start, to_date=end, end_exclusive=True, timezone='Europe/Copenhagen',
                currency='DKK',
                correlations=dict(barRevenueGuestNights=_pearson(bar_values, guest_values),
                                  barRevenueHotelRevenue=_pearson(bar_values, hotel_values)),
                data=[{**row, 'hotelRevenue': float(row['hotelRevenue']),
                       'barRevenue': float(row['barRevenue'])} for row in rows])
