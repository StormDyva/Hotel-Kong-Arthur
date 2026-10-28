from datetime import date, datetime
from decimal import Decimal
from typing import Literal
from pydantic import BaseModel, Field, field_validator

class Guest(BaseModel):
    name: str = Field(min_length=1, max_length=241)
    email: str = Field(max_length=254, pattern=r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
    phone: str = Field(min_length=5, max_length=40)
    country_code: str = Field(pattern=r'^[A-Z]{2}$')

    @field_validator('name', 'phone')
    @classmethod
    def nonblank(cls, value):
        if not value.strip():
            raise ValueError('Must not be blank')
        value = value.strip()
        if any(len(part) > 120 for part in value.partition(' ')[::2]):
            raise ValueError('Name parts must not exceed 120 characters')
        return value

class BookingWrite(BaseModel):
    room_id: int = Field(gt=0)
    check_in: date
    check_out: date
    guests_count: int = Field(ge=1, le=4)
    guest: Guest
    currency: Literal['DKK'] = 'DKK'
    # Accepted for compatibility; never authoritative. Server computes prices.
    price_total: Decimal | None = Field(default=None, ge=0)
    status: Literal['confirmed'] = 'confirmed'

class Booking(BaseModel):
    id: int
    room_id: int
    room_number: str
    room_type: str
    capacity: int
    check_in: date
    check_out: date
    guests_count: int
    guest: Guest
    price_total: Decimal
    price_per_night: Decimal
    currency: str
    status: str

class BookingPage(BaseModel):
    items: list[Booking]
    total: int
    page: int
    page_size: int

class Group(BaseModel):
    label: str
    revenue: Decimal
    room_nights: int
    guest_nights: int
    bookings: int

class Summary(BaseModel):
    revenue: Decimal
    room_nights: int
    available_room_nights: int
    occupancy_percent: float
    adr: Decimal
    bar_revenue: Decimal
    inventory_rooms: int

class Product(BaseModel):
    product: str
    category: str
    quantity: int
    revenue: Decimal

class Category(BaseModel):
    category: str
    revenue: Decimal
    percent: Decimal

class Dashboard(BaseModel):
    from_date: date
    to_date: date
    currency: str
    employee_name: str
    refreshed_at: datetime
    warnings: list[str]
    summary: Summary
    by_room_type: list[Group]
    by_country: list[Group]
    by_season: list[Group]
    by_room_type_season: list[Group]
    daily: list[Group]
    bar_products: list[Product]
    bar_categories: list[Category]
