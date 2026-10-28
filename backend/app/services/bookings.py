from datetime import timedelta
from decimal import Decimal

class DomainError(Exception):
    def __init__(self, status, code, message):
        self.status, self.code, self.message = status, code, message


def stay(start, end, guests=1):
    if end <= start or (end-start).days > 366:
        raise DomainError(422, 'VALIDATION_ERROR', 'Stay must be 1–366 nights; check_out is exclusive')
    if not 1 <= guests <= 4:
        raise DomainError(422, 'VALIDATION_ERROR', 'guests_count must be 1–4')


def quote(repo, room, start, end):
    prices = repo.prices(room['room_type_id'])
    lines = []
    day = start
    while day < end:
        md = (day.month, day.day)
        matches = [p for p in prices if
                   (p['start_month'], p['start_day']) <= md <= (p['end_month'], p['end_day'])]
        if len(matches) != 1:
            raise DomainError(409, 'PRICE_UNAVAILABLE', f'Expected one seasonal price for {day}')
        p = matches[0]
        lines.append(dict(night_date=day, season_id=p['season_id'],
                          price_per_night=p['price_per_night'], line_total=p['price_per_night']))
        day += timedelta(days=1)
    return lines


def present(row):
    row = dict(row)
    row['guest'] = dict(name=' '.join(filter(None, [row.pop('first_name'), row.pop('last_name')])),
                        email=row.pop('email'), phone=row.pop('phone'), country_code=row.pop('country_code'))
    row['price_per_night'] = row['price_total'] / (row['check_out']-row['check_in']).days
    return row


def detail(repo, booking_id):
    rows = repo.bookings(booking_id)
    if not rows:
        raise DomainError(404, 'NOT_FOUND', 'Booking not found')
    return present(rows[0])


def availability(repo, start, end, guests):
    stay(start, end, guests)
    result = []
    for room in repo.rooms():
        if not room['active'] or not room['type_active'] or room['status'] != 'available' or room['capacity'] < guests:
            continue
        if repo.overlaps(room['id'], start, end):
            continue
        lines = quote(repo, room, start, end)
        total = sum((l['line_total'] for l in lines), Decimal(0))
        result.append(dict(room_id=room['id'], room_number=room['room_number'],
                           room_type=room['room_type'], capacity=room['capacity'],
                           total_price=total, price_per_night=total/len(lines), currency='DKK'))
    return result


def save(repo, data, booking_id=None):
    stay(data.check_in, data.check_out, data.guests_count)
    # Always room first, booking second: all writes use the same lock order.
    rooms = repo.rooms(data.room_id, lock=True)
    if not rooms:
        raise DomainError(404, 'NOT_FOUND', 'Room not found')
    room = rooms[0]
    old = None
    if booking_id is not None:
        rows = repo.bookings(booking_id, lock=True)
        if not rows:
            raise DomainError(404, 'NOT_FOUND', 'Booking not found')
        old = rows[0]
        if old['room_id'] != data.room_id:
            raise DomainError(422, 'VALIDATION_ERROR', 'Room changes require cancellation and a new booking')
        if old['status'] == 'cancelled':
            raise DomainError(409, 'CANCELLED', 'Cancelled bookings cannot be edited')
    if not room['active'] or not room['type_active'] or room['status'] != 'available':
        raise DomainError(409, 'ROOM_UNAVAILABLE', 'Room is not available')
    if data.guests_count > room['capacity']:
        raise DomainError(422, 'VALIDATION_ERROR', 'guests_count exceeds room capacity')
    if repo.overlaps(data.room_id, data.check_in, data.check_out, booking_id or 0):
        raise DomainError(409, 'BOOKING_CONFLICT', 'Room already booked for these dates')
    # Preserve historical prices for an unchanged stay (idempotent PUT).
    same_stay = old and old['check_in'] == data.check_in and old['check_out'] == data.check_out
    lines = None if same_stay else quote(repo, room, data.check_in, data.check_out)
    total = old['price_total'] if same_stay else sum((l['line_total'] for l in lines), Decimal(0))
    first, _, last = data.guest.name.strip().partition(' ')
    guest = dict(first=first, last=last, email=str(data.guest.email), phone=data.guest.phone,
                 country=data.guest.country_code)
    same_guest = old and all([
        (old['first_name'] or '') == first, (old['last_name'] or '') == last,
        old['email'] == str(data.guest.email), old['phone'] == data.guest.phone,
        old['country_code'] == data.guest.country_code])
    guest_id = old['guest_id'] if same_guest else repo.save_guest(guest)
    values = dict(guest=guest_id, room=data.room_id, start=data.check_in, end=data.check_out,
                  count=data.guests_count, total=total)
    booking_id = repo.save_booking(values, booking_id, replace_lines=lines is not None)
    for line in lines or []:
        repo.add_price_line(booking_id, line)
    return detail(repo, booking_id)


def cancel(repo, booking_id):
    rows = repo.bookings(booking_id)
    if not rows:
        raise DomainError(404, 'NOT_FOUND', 'Booking not found')
    repo.rooms(rows[0]['room_id'], lock=True)
    current = repo.bookings(booking_id, lock=True)[0]
    if current['status'] != 'cancelled':
        repo.cancel_booking(booking_id)
