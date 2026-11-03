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
    if row.get('data_origin') == 'synthetic_import':
        source_row = int(row['source_record_id'].split(':')[-1]) - 1
        name = f"Syntetisk gæst {source_row:04d}"
        email = phone = None
    else:
        name = ' '.join(filter(None, [row['first_name'], row['last_name']]))
        email, phone = row['email'], row['phone']
    row['guest'] = dict(name=name, email=email, phone=phone,
                        country_code=row.pop('country_code'))
    row.pop('first_name', None)
    row.pop('last_name', None)
    row.pop('email', None)
    row.pop('phone', None)
    row.pop('source_record_id', None)
    row.pop('import_batch_id', None)
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
    old = None
    initial = None
    if booking_id is not None:
        rows = repo.bookings(booking_id)
        if not rows:
            raise DomainError(404, 'NOT_FOUND', 'Booking not found')
        initial = rows[0]
        if initial['data_origin'] == 'synthetic_import':
            raise DomainError(409, 'SYNTHETIC_BOOKING_READ_ONLY', 'Synthetic imported bookings cannot be edited')
    # Lock all involved rooms in ascending order, then the booking itself.
    room_ids = sorted({data.room_id} | ({initial['room_id']} if initial else set()))
    locked = {room['id']: room for rid in room_ids for room in repo.rooms(rid, lock=True)}
    if data.room_id not in locked:
        raise DomainError(404, 'NOT_FOUND', 'Room not found')
    room = locked[data.room_id]
    if booking_id is not None:
        old = repo.bookings(booking_id, lock=True)[0]
        if old['room_id'] != initial['room_id']:
            raise DomainError(409, 'BOOKING_CHANGED', 'Booking room changed concurrently; reload and retry')
        if repo.review(booking_id):
            old_name = ' '.join(filter(None, [old['first_name'], old['last_name']]))
            changed = (old_name != data.guest.name.strip()
                or old['country_code'] != data.guest.country_code
                or old['room_id'] != data.room_id
                or old['check_in'] != data.check_in or old['check_out'] != data.check_out
                or old['guests_count'] != data.guests_count)
            if changed:
                raise DomainError(409, 'REVIEWED_BOOKING_IMMUTABLE',
                    'Reviewed bookings only permit email and phone corrections')
        if old['status'] == 'cancelled':
            raise DomainError(409, 'CANCELLED', 'Cancelled bookings cannot be edited')
    if not room['active'] or not room['type_active'] or room['status'] != 'available':
        raise DomainError(409, 'ROOM_UNAVAILABLE', 'Room is not available')
    if data.guests_count > room['capacity']:
        raise DomainError(422, 'VALIDATION_ERROR', 'guests_count exceeds room capacity')
    if repo.overlaps(data.room_id, data.check_in, data.check_out, booking_id or 0):
        raise DomainError(409, 'BOOKING_CONFLICT', 'Room already booked for these dates')
    # Preserve historical prices for an unchanged stay (idempotent PUT).
    same_stay = old and old['room_id'] == data.room_id and old['check_in'] == data.check_in and old['check_out'] == data.check_out
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
    if rows[0]['data_origin'] == 'synthetic_import':
        raise DomainError(409, 'SYNTHETIC_BOOKING_READ_ONLY', 'Synthetic imported bookings cannot be cancelled')
    repo.rooms(rows[0]['room_id'], lock=True)
    current = repo.bookings(booking_id, lock=True)[0]
    if current['room_id'] != rows[0]['room_id']:
        raise DomainError(409, 'BOOKING_CHANGED', 'Booking room changed concurrently; reload and retry')
    if current['status'] != 'cancelled':
        repo.cancel_booking(booking_id)
