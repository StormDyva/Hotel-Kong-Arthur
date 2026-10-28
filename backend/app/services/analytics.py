from collections import defaultdict
from datetime import date
from decimal import Decimal
from .bookings import DomainError


def report(repo, start=date(2026, 1, 1), end=date(2027, 1, 1), employee='Helene Christine'):
    if end <= start or (end-start).days > 3660:
        raise DomainError(422, 'VALIDATION_ERROR', 'Report period must be 1–3660 days; to is exclusive')
    nights = repo.nights(start, end)
    rooms = [r for r in repo.rooms() if r['active'] and r['type_active']]
    available = len(rooms) * (end-start).days
    revenue = sum((n['line_total'] for n in nights), Decimal(0))
    room_groups, country_groups, season_groups, daily, combined = {}, {}, {}, {}, {}
    for n in nights:
        n["room_type_season"] = n["room_type"] + " / " + n["season"]
    for field, groups in [('room_type', room_groups), ('country_code', country_groups), ('season', season_groups), ('night_date', daily), ('room_type_season', combined)]:
        for n in nights:
            key = str(n[field])
            g = groups.setdefault(key, dict(label=key, revenue=Decimal(0), room_nights=0, guest_nights=0, bookings=set()))
            g['revenue'] += n['line_total']
            g['room_nights'] += 1
            g['guest_nights'] += n['guests_count']
            g['bookings'].add(n['booking_id'])
        for g in groups.values():
            g['bookings'] = len(g['bookings'])
    products, categories = {}, defaultdict(Decimal)
    for s in repo.sales(start, end, employee):
        amount = s['quantity'] * s['unit_price']
        g = products.setdefault(s['product'], dict(product=s['product'], category=s['category'], quantity=0, revenue=Decimal(0)))
        g['quantity'] += s['quantity']
        g['revenue'] += amount
        categories[s['category']] += amount
    bar_total = sum(categories.values(), Decimal(0))
    warnings = []
    if not available:
        warnings.append('No active inventory: occupancy denominator is zero')
    if len(nights) > available:
        warnings.append('Occupancy exceeds 100%; inspect inventory and overlapping bookings')
    if not bar_total:
        warnings.append('No bar revenue: category percentages have zero denominator')
    return dict(from_date=start, to_date=end, currency='DKK', employee_name=employee,
                refreshed_at=repo.now(), warnings=warnings,
                summary=dict(revenue=revenue, room_nights=len(nights), available_room_nights=available,
                             occupancy_percent=round(100*len(nights)/available, 2) if available else 0,
                             adr=round(revenue/len(nights), 2) if nights else Decimal(0),
                             bar_revenue=bar_total, inventory_rooms=len(rooms)),
                by_room_type=list(room_groups.values()), by_country=list(country_groups.values()),
                by_season=list(season_groups.values()), by_room_type_season=list(combined.values()), daily=list(daily.values()),
                bar_products=list(products.values()),
                bar_categories=[dict(category=k, revenue=categories[k], percent=round(100*categories[k]/bar_total, 2) if bar_total else 0)
                                for k in sorted(set(categories) | {'cocktail', 'coffee'})])
