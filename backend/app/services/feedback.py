from datetime import datetime, timezone
from .analytics import COPENHAGEN
from .bookings import DomainError


def save_review(repo, booking_id, rating):
    # Same lock order as booking updates and cancellation.
    rows = repo.bookings(booking_id)
    if not rows:
        raise DomainError(404, 'NOT_FOUND', 'Booking not found')
    repo.rooms(rows[0]['room_id'], lock=True)
    booking = repo.bookings(booking_id, lock=True)[0]
    if booking['room_id'] != rows[0]['room_id']:
        raise DomainError(409, 'BOOKING_CHANGED', 'Booking room changed concurrently; reload and retry')
    if booking['status'] != 'confirmed' or booking['check_out'] > datetime.now(COPENHAGEN).date():
        raise DomainError(409, 'REVIEW_NOT_ELIGIBLE', 'Only completed, non-cancelled bookings can be rated')
    return repo.save_review(booking_id, rating)


def read_review(repo, booking_id):
    if not repo.bookings(booking_id):
        raise DomainError(404, 'NOT_FOUND', 'Booking not found')
    review = repo.review(booking_id)
    if not review:
        raise DomainError(404, 'NOT_FOUND', 'Booking has no review')
    return review


def save_sale(repo, data):
    product = repo.bar_product(data.product_id)
    if not product:
        raise DomainError(404, 'NOT_FOUND', 'Active bar product not found')
    values = data.model_dump()
    values['unit_price'] = product['price'] if data.unit_price is None else data.unit_price
    values['sold_at'] = data.sold_at.astimezone(timezone.utc).replace(tzinfo=None)
    return repo.save_sale(values)
