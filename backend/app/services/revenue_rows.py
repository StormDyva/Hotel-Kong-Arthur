"""Tableau-ready revenue: all multiplication and grouping happens in this layer."""
from decimal import Decimal
from .analytics import period

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
