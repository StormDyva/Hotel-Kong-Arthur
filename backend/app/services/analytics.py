from collections import defaultdict
from datetime import date, datetime, time, timedelta, timezone
from decimal import Decimal
from zoneinfo import ZoneInfo
from .bookings import DomainError

COPENHAGEN = ZoneInfo('Europe/Copenhagen')
ZERO = Decimal('0')


def period(start=None, end=None, year=None):
    if year is not None:
        if start is not None or end is not None or not 1900 <= year <= 9998:
            raise DomainError(422, 'VALIDATION_ERROR', 'year (1900–9998) cannot be combined with from/to')
        start, end = date(year, 1, 1), date(year+1, 1, 1)
    start, end = start or date(2026, 1, 1), end or date(2027, 1, 1)
    if end <= start or (end-start).days > 3660:
        raise DomainError(422, 'VALIDATION_ERROR', 'Report period must be 1–3660 days; to is exclusive')
    return start, end


def season_contains(day, periods):
    md = day.month, day.day
    for p in periods:
        lower, upper = (p['start_month'], p['start_day']), (p['end_month'], p['end_day'])
        if (lower <= md <= upper) if lower <= upper else (md >= lower or md <= upper):
            return True
    return False


def utc_midnight(day):
    return datetime.combine(day, time.min, COPENHAGEN).astimezone(timezone.utc).replace(tzinfo=None)


def grouped(nights, field):
    groups = {}
    for n in nights:
        key = str(n[field])
        g = groups.setdefault(key, dict(label=key, revenue=ZERO, room_nights=0,
            guest_nights=0, bookings=set(), distinct_bookers=set(), booking_guests={}))
        g['revenue'] += n['line_total']
        g['room_nights'] += 1
        g['guest_nights'] += n['guests_count']
        g['bookings'].add(n['booking_id'])
        g['distinct_bookers'].add(n['guest_id'])
        g['booking_guests'][n['booking_id']] = n['guests_count']
    for g in groups.values():
        g['bookings'] = len(g['bookings'])
        g['distinct_bookers'] = len(g['distinct_bookers'])
        g['booking_guests'] = sum(g['booking_guests'].values())
    return sorted(groups.values(), key=lambda g: (-g['revenue'], g['label']))


def report(repo, start=None, end=None, employee='Helene Christine', country=None, room_type=None, season=None, year=None):
    start, end = period(start, end, year)
    nights = repo.nights(start, end, country, room_type, season)
    rooms = [r for r in repo.rooms() if r['active'] and r['type_active']
             and (room_type is None or r['room_type_id'] == room_type)]
    days = (end-start).days
    if season:
        periods = repo.season_periods(season)
        days = sum(season_contains(start+timedelta(days=i), periods) for i in range(days))
    available = len(rooms)*days
    revenue = sum((n['line_total'] for n in nights), ZERO)
    for n in nights:
        n['room_type_season'] = n['room_type']+' / '+n['season']
    groups = {key: grouped(nights, field) for key, field in [
        ('by_room', 'room_number'), ('by_room_type','room_type'), ('by_country','country_code'),
        ('by_season','season'), ('by_room_type_season','room_type_season'), ('daily','night_date')]}
    groups['daily'].sort(key=lambda g: g['label'])
    products, categories = {}, defaultdict(Decimal)
    for s in repo.sales(utc_midnight(start), utc_midnight(end), employee):
        amount = s['quantity']*s['unit_price']
        g = products.setdefault(s['product'], dict(product=s['product'], category=s['category'], quantity=0, revenue=ZERO))
        g['quantity'] += s['quantity']
        g['revenue'] += amount
        categories[s['category']] += amount
    bar_total = sum(categories.values(), ZERO)
    warnings = []
    if not available:
        warnings.append('No active inventory/season nights: occupancy denominator is zero')
    if len(nights) > available:
        warnings.append('Occupancy exceeds 100%; inspect inventory and overlapping bookings')
    if not nights:
        warnings.append('No matching hotel stays in period')
    if not bar_total:
        warnings.append('No bar revenue: category percentages have zero denominator')
    today = datetime.now(COPENHAGEN).date()
    eligible = repo.satisfaction_rows(start, end, today, country, room_type, season)
    ratings = [x['rating'] for x in eligible if x['rating'] is not None]
    if not ratings:
        warnings.append('No guest ratings for completed bookings in this checkout cohort')
    satisfaction = dict(average_rating=round(Decimal(sum(ratings))/len(ratings), 2) if ratings else None,
        rated_bookings=len(ratings), eligible_bookings=len(eligible),
        response_percent=round(Decimal(100)*len(ratings)/len(eligible), 2) if eligible else ZERO,
        distribution=[dict(rating=i, count=ratings.count(i)) for i in range(1,6)], scale_min=1, scale_max=5)
    metadata = dict(period=dict(from_date=start, to_date=end, end_exclusive=True, timezone='Europe/Copenhagen'),
        applied_filters=dict(country_code=country, room_type_id=room_type, season=season, employee_name=employee),
        generated_at=repo.now(), hotel_filters_apply_to_bar=False)
    return dict(from_date=start, to_date=end, currency='DKK', employee_name=employee,
        refreshed_at=metadata['generated_at'], **metadata, warnings=warnings,
        summary=dict(revenue=revenue, room_nights=len(nights), available_room_nights=available,
            occupancy_percent=round(100*len(nights)/available, 2) if available else 0,
            adr=round(revenue/len(nights), 2) if nights else ZERO,
            bar_revenue=bar_total, inventory_rooms=len(rooms)), **groups,
        top_room=groups['by_room'][0] if groups['by_room'] else None,
        top_room_type=groups['by_room_type'][0] if groups['by_room_type'] else None,
        top_country=groups['by_country'][0] if groups['by_country'] else None,
        satisfaction=satisfaction,
        bar_products=sorted(products.values(), key=lambda p: (-p['revenue'],p['product'])),
        bar_categories=[dict(category=k, revenue=categories[k], percent=round(100*categories[k]/bar_total, 2) if bar_total else ZERO)
                        for k in sorted(set(categories)|{'cocktail','coffee'})])


def metric_result(data, metric):
    if metric == 'bar-sales':
        result = dict(total_revenue=data['summary']['bar_revenue'], employee_name=data['employee_name'],
                      products=data['bar_products'], categories=data['bar_categories'])
    elif metric == 'customer-satisfaction':
        result = data['satisfaction']
    elif metric == 'top-performers':
        result = {key:data[key] for key in ['top_room','top_room_type','top_country']}
    else:
        key = {'revenue-by-room':'by_room', 'revenue-by-room-type':'by_room_type',
               'revenue-by-country':'by_country', 'revenue-by-season':'by_season',
               'revenue-by-room-type-season':'by_room_type_season', 'guests-by-country':'by_country'}.get(metric,'summary')
        result = data[key]
    if metric == 'bar-sales':
        warnings = [w for w in data['warnings'] if w.startswith('No bar')]
    elif metric == 'customer-satisfaction':
        warnings = [w for w in data['warnings'] if w.startswith('No guest ratings')]
    else:
        warnings = [w for w in data['warnings'] if not w.startswith(('No bar','No guest ratings'))]
    return dict(period=data['period'], applied_filters=data['applied_filters'], generated_at=data['generated_at'],
                currency='DKK', warnings=warnings, data=result, hotel_filters_apply_to_bar=False)
