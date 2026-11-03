from datetime import date, datetime, timezone
from decimal import Decimal
from typing import Literal, Annotated, Generic, TypeVar
from pydantic import BaseModel, Field, field_validator, ConfigDict, AfterValidator, AwareDatetime

def as_utc(value):
    return value.replace(tzinfo=timezone.utc) if value.tzinfo is None else value.astimezone(timezone.utc)

UTCDatetime = Annotated[datetime, AfterValidator(as_utc)]

class Guest(BaseModel):
    model_config = ConfigDict(extra="forbid")
    name: str = Field(min_length=1, max_length=241)
    email: str = Field(max_length=254, pattern=r'^[^\s@]+@[^\s@]+\.[^\s@]+$')
    phone: str = Field(min_length=5, max_length=40, pattern=r'^\+?[0-9 ()-]+$')
    country_code: str = Field(pattern=r'^[A-Z]{2}$')

    @field_validator('email')
    @classmethod
    def email_valid(cls, value):
        from email_validator import validate_email
        return validate_email(value, check_deliverability=False, test_environment=True).normalized

    @field_validator('phone')
    @classmethod
    def phone_valid(cls, value):
        if sum(c.isdigit() for c in value) < 5:
            raise ValueError('Phone must contain at least five digits')
        return value.strip()

    @field_validator('name')
    @classmethod
    def nonblank(cls, value):
        if not value.strip():
            raise ValueError('Must not be blank')
        value = value.strip()
        if any(len(part) > 120 for part in value.partition(' ')[::2]):
            raise ValueError('Name parts must not exceed 120 characters')
        return value

class BookingWrite(BaseModel):
    model_config = ConfigDict(extra="forbid", json_schema_extra={"example": {
        "room_id": 101, "check_in": "2026-11-20", "check_out": "2026-11-23",
        "guests_count": 1, "guest": {"name": "Test Gæst", "email": "test@example.com",
            "phone": "+45 12345678", "country_code": "DK"},
        "currency": "DKK", "status": "confirmed"}})
    room_id: int = Field(gt=0, strict=True)
    check_in: date
    check_out: date
    guests_count: int = Field(ge=1, le=4, strict=True)
    guest: Guest
    currency: Literal['DKK'] = 'DKK'
    # Accepted for compatibility; never authoritative. Server computes prices.
    price_total: Decimal | None = Field(default=None, ge=0)
    status: Literal['confirmed'] = 'confirmed'

class GuestView(BaseModel):
    name: str
    email: str | None
    phone: str | None
    country_code: str

class Booking(BaseModel):
    id: int
    room_id: int
    room_number: str
    room_type: str
    capacity: int
    check_in: date
    check_out: date
    guests_count: int
    guest: GuestView
    guest_id: int
    created_at: UTCDatetime
    updated_at: UTCDatetime
    price_total: Decimal
    price_per_night: Decimal
    currency: str
    status: str
    data_origin: Literal['operational', 'synthetic_import'] = Field(description='synthetic_import rows have generated dates, rooms, and party sizes; read-only.')

class BookingPage(BaseModel):
    items: list[Booking]
    total: int
    page: int
    page_size: int
    applied_filters: dict = {}

class Group(BaseModel):
    label: str
    revenue: Decimal
    room_nights: int
    guest_nights: int
    bookings: int
    distinct_bookers: int
    booking_guests: int

class Summary(BaseModel):
    revenue: Decimal
    room_nights: int
    available_room_nights: int
    occupancy_percent: float
    adr: Decimal
    revpar: Decimal = Field(description='Room revenue / available room nights, in DKK. Zero for zero capacity.')
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
    refreshed_at: UTCDatetime
    warnings: list[str]
    summary: Summary
    by_room_type: list[Group]
    by_country: list[Group]
    by_season: list[Group]
    by_room_type_season: list[Group]
    daily: list[Group]
    bar_products: list[Product]
    bar_categories: list[Category]


class ErrorDetail(BaseModel):
    field: str
    message: str

class ErrorResponse(BaseModel):
    error: str
    message: str
    details: list[ErrorDetail] = []

class Period(BaseModel):
    from_date: date
    to_date: date
    end_exclusive: bool
    timezone: str

class AppliedFilters(BaseModel):
    country_code: str | None
    room_type_id: int | None
    season: str | None
    employee_name: str

class Distribution(BaseModel):
    rating: int
    count: int

class Satisfaction(BaseModel):
    average_rating: Decimal | None
    rated_bookings: int
    eligible_bookings: int
    response_percent: Decimal
    distribution: list[Distribution]
    scale_min: int
    scale_max: int

class TopPerformers(BaseModel):
    top_room: Group | None
    top_room_type: Group | None
    top_country: Group | None

class BarReport(BaseModel):
    total_revenue: Decimal
    employee_name: str
    products: list[Product]
    categories: list[Category]

T = TypeVar('T')

class AnalyticsResponse(BaseModel, Generic[T]):
    period: Period
    applied_filters: AppliedFilters
    generated_at: UTCDatetime
    currency: str
    warnings: list[str]
    data: T
    hotel_filters_apply_to_bar: bool

class ReviewWrite(BaseModel):
    model_config = ConfigDict(extra='forbid')
    rating: int = Field(ge=1, le=5, strict=True, examples=[4])

class Review(BaseModel):
    booking_id: int
    rating: int
    created_at: UTCDatetime
    updated_at: UTCDatetime

class SaleWrite(BaseModel):
    model_config = ConfigDict(extra='forbid')
    product_id: int = Field(gt=0, examples=[1])
    sold_at: AwareDatetime = Field(examples=['2026-10-28T17:30:00+01:00'], description='Timezone required. UTC instant must fit MySQL TIMESTAMP: 1970-01-01T00:00:01Z through 2038-01-19T03:14:07Z.')
    quantity: int = Field(gt=0, le=10000, strict=True, examples=[2])
    unit_price: Decimal | None = Field(None, ge=0, max_digits=10, decimal_places=2,
                                     description='Optional actual unit price in DKK; defaults to the product price')
    employee_name: str = Field(min_length=1, max_length=160, examples=['Helene Christine'])

    @field_validator('sold_at')
    @classmethod
    def timestamp_supported(cls, value):
        instant = value.astimezone(timezone.utc)
        if not datetime(1970,1,1,0,0,1,tzinfo=timezone.utc) <= instant <= datetime(2038,1,19,3,14,7,tzinfo=timezone.utc):
            raise ValueError('sold_at is outside the supported MySQL TIMESTAMP range')
        return value

    @field_validator('employee_name')
    @classmethod
    def employee_nonblank(cls, value):
        if not value.strip():
            raise ValueError('Employee must not be blank')
        return value.strip()

class Sale(BaseModel):
    id: int
    product_id: int
    sold_at: UTCDatetime
    quantity: int
    unit_price: Decimal
    employee_name: str
    currency: str

class Availability(BaseModel):
    room_id: int
    room_number: str
    room_type: str
    capacity: int
    total_price: Decimal
    price_per_night: Decimal
    currency: str

class RoomType(BaseModel):
    id: int
    name: str
    capacity: int

class BarProduct(BaseModel):
    id: int
    name: str
    category: str
    price: Decimal
    currency: str

class Health(BaseModel):
    status: str
    database: str

class BookingUpdate(BookingWrite):
    status: Literal['confirmed']


class DashboardReport(Dashboard):
    period: Period
    applied_filters: AppliedFilters
    generated_at: UTCDatetime
    hotel_filters_apply_to_bar: bool
    by_room: list[Group]
    top_room: Group | None
    top_room_type: Group | None
    top_country: Group | None
    satisfaction: Satisfaction


class Room(BaseModel):
    id: int
    room_number: str
    room_type_id: int
    room_type: str
    capacity: int
    active: bool
    type_active: bool
    status: Literal['available','maintenance','inactive']
    created_at: UTCDatetime
    updated_at: UTCDatetime


class RoomTypeSeasonRevenueRow(BaseModel):
    roomType: str
    season: str
    revenue: float = Field(ge=0, description='Backend-calculated revenue in DKK, returned as a JSON number')


class CountryRevenueRow(BaseModel):
    country: str
    revenue: float = Field(ge=0, description='Backend-calculated revenue in DKK, returned as a JSON number')


class MonthlyRevPAR(BaseModel):
    month: str
    revenue: Decimal
    available_room_nights: int
    revpar: Decimal


class RevPARReport(BaseModel):
    revpar: Decimal
    revenue: Decimal
    available_room_nights: int
    monthly: list[MonthlyRevPAR]
