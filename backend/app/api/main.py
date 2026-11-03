import logging
import os
from datetime import date
from pathlib import Path
from typing import Literal
from fastapi import FastAPI, Depends, Query, Response
from fastapi.exceptions import RequestValidationError
from fastapi.middleware.cors import CORSMiddleware
from fastapi.openapi.docs import get_swagger_ui_html
from fastapi.responses import JSONResponse
from fastapi.staticfiles import StaticFiles
from sqlalchemy.exc import SQLAlchemyError
from starlette.exceptions import HTTPException
from app.repositories.database import engine, Repository
from app.services import bookings, analytics, feedback, revenue_rows
from .schemas import (
    BookingWrite, BookingUpdate, Booking, BookingPage, DashboardReport,
    ErrorResponse, AnalyticsResponse, Summary, Group, BarReport, TopPerformers,
    Satisfaction, ReviewWrite, Review, SaleWrite, Sale, Availability, RoomType, BarProduct, Health, Room, RoomTypeSeasonRevenueRow, CountryRevenueRow, RevPARReport,
)

ERRORS = {code: dict(model=ErrorResponse, description=description) for code, description in {
    404:'Resource not found', 409:'Booking conflict or operation not eligible',
    422:'Invalid request', 503:'Database unavailable', 500:'Unexpected server error'}.items()}
app = FastAPI(title='Hotel Kong Arthur API', version='1.1.0', docs_url=None, redoc_url=None,
    responses=ERRORS, description=(
        'Three-layer REST API backed by MySQL. Dates use [from,to), checkout is exclusive. '
        'Money is DKK. Existing /api responses use decimal strings; flat /analytics/revenue exports use JSON numbers. Analytics default to calendar 2026. '
        'Hotel filters do not filter bar sales. Demo inventory is synthetic.'))
app.add_middleware(CORSMiddleware,
    allow_origins=os.getenv('CORS_ORIGINS','http://localhost:5500,http://127.0.0.1:5500').split(','),
    allow_methods=['GET','POST','PUT','DELETE'], allow_headers=['Content-Type'])
app.mount('/static', StaticFiles(directory=Path(__file__).parents[1]/'static'), name='static')


@app.get('/docs', include_in_schema=False)
def swagger():
    return get_swagger_ui_html(openapi_url='/openapi.json', title='Hotel Kong Arthur — Swagger UI',
        swagger_js_url='/static/swagger/swagger-ui-bundle.js',
        swagger_css_url='/static/swagger/swagger-ui.css',
        swagger_favicon_url='/static/swagger/favicon-32x32.png',
        swagger_ui_parameters={'persistAuthorization':True, 'displayRequestDuration':True, 'validatorUrl':None})


def repository():
    with engine.begin() as connection:
        yield Repository(connection)


def error(status, code, message, details=None):
    return JSONResponse(status_code=status, content=dict(error=code,message=message,details=details or []))


@app.exception_handler(bookings.DomainError)
def domain_error(request, exc):
    return error(exc.status, exc.code, exc.message)


@app.exception_handler(RequestValidationError)
def validation_error(request, exc):
    return error(422,'VALIDATION_ERROR','Invalid request',
        [dict(field='.'.join(str(v) for v in e['loc'][1:]),message=e['msg']) for e in exc.errors()])


@app.exception_handler(HTTPException)
def http_error(request, exc):
    return error(exc.status_code, 'NOT_FOUND' if exc.status_code==404 else 'HTTP_ERROR', str(exc.detail))


@app.exception_handler(SQLAlchemyError)
def database_error(request, exc):
    logging.getLogger(__name__).error('Database operation failed',exc_info=(type(exc),exc,exc.__traceback__))
    return error(503,'DATABASE_ERROR','Database operation failed')


@app.exception_handler(Exception)
def unexpected_error(request, exc):
    logging.getLogger(__name__).error('Unexpected request failure',exc_info=(type(exc),exc,exc.__traceback__))
    return error(500,'INTERNAL_ERROR','Unexpected server error')


@app.get('/health', response_model=Health, tags=['System'])
def health(repo=Depends(repository,scope='function')):
    repo.health()
    return dict(status='ok',database='ok')


@app.get('/api/rooms', response_model=list[Room], tags=['Inventory'])
def rooms(room_type_id: int | None=Query(None,gt=0), repo=Depends(repository,scope='function')):
    return [r for r in repo.rooms() if room_type_id is None or r['room_type_id']==room_type_id]


@app.get('/api/rooms/availability', response_model=list[Availability], tags=['Inventory'])
def availability(check_in: date, check_out: date, guests_count: int=Query(ge=1,le=4),repo=Depends(repository,scope='function')):
    return bookings.availability(repo,check_in,check_out,guests_count)


@app.get('/api/room-types', response_model=list[RoomType], tags=['Inventory'])
def room_types(repo=Depends(repository,scope='function')):
    return repo.room_types()


@app.get('/api/bookings', response_model=BookingPage, tags=['Bookings'])
def list_bookings(status: Literal['confirmed','cancelled']|None=None,
    page: int=Query(1,ge=1),page_size: int=Query(100,ge=1,le=100),
    room_id: int|None=Query(None,gt=0),guest_id: int|None=Query(None,gt=0),
    from_date: date|None=Query(None,alias='from'),to_date: date|None=Query(None,alias='to'),
    repo=Depends(repository,scope='function')):
    if from_date and to_date and to_date<=from_date:
        raise bookings.DomainError(422,'VALIDATION_ERROR','to must be after from')
    rows,total=repo.booking_page(status,page,page_size,room_id,guest_id,from_date,to_date)
    return dict(items=[bookings.present(b) for b in rows],total=total,page=page,page_size=page_size,
                applied_filters=dict(status=status,room_id=room_id,guest_id=guest_id,from_date=from_date,to_date=to_date))


@app.get('/api/bookings/{booking_id}',response_model=Booking,tags=['Bookings'])
def get_booking(booking_id: int,repo=Depends(repository,scope='function')):
    return bookings.detail(repo,booking_id)


@app.post('/api/bookings',status_code=201,response_model=Booking,tags=['Bookings'])
def create_booking(data: BookingWrite,response: Response,repo=Depends(repository,scope='function')):
    result=bookings.save(repo,data)
    response.headers['Location']=f"/api/bookings/{result['id']}"
    return result


@app.put('/api/bookings/{booking_id}',response_model=Booking,tags=['Bookings'])
def update_booking(booking_id: int,data: BookingUpdate,repo=Depends(repository,scope='function')):
    return bookings.save(repo,data,booking_id)


@app.delete('/api/bookings/{booking_id}',status_code=204,tags=['Bookings'])
def cancel_booking(booking_id: int,repo=Depends(repository,scope='function')):
    bookings.cancel(repo,booking_id)
    return Response(status_code=204)


@app.put('/api/bookings/{booking_id}/review',response_model=Review,tags=['Guest feedback'])
def save_review(booking_id: int,data: ReviewWrite,repo=Depends(repository,scope='function')):
    return feedback.save_review(repo,booking_id,data.rating)


@app.get('/api/bookings/{booking_id}/review',response_model=Review,tags=['Guest feedback'])
def get_review(booking_id: int,repo=Depends(repository,scope='function')):
    return feedback.read_review(repo,booking_id)


@app.get('/api/bar-products',response_model=list[BarProduct],tags=['Bar'])
def bar_products(repo=Depends(repository,scope='function')):
    return repo.bar_products()


@app.post('/api/bar-sales',status_code=201,response_model=Sale,tags=['Bar'])
def create_sale(data: SaleWrite,repo=Depends(repository,scope='function')):
    return feedback.save_sale(repo,data)


class ReportQuery:
    def __init__(self,from_date: date|None=Query(None,alias='from'),to_date: date|None=Query(None,alias='to'),
        year: int|None=Query(None,ge=1900,le=9998),
        country_code: str|None=Query(None,pattern='^[A-Z]{2}$'),room_type_id: int|None=Query(None,gt=0),
        season: Literal['low','mid','high']|None=None,
        employee_name: str=Query('Helene Christine',min_length=1,max_length=160)):
        self.start,self.end=analytics.period(from_date,to_date,year)
        if not employee_name.strip():
            raise bookings.DomainError(422,'VALIDATION_ERROR','employee_name must not be blank')
        self.employee,self.country,self.room_type,self.season=employee_name.strip(),country_code,room_type_id,season


def get_report(query=Depends(ReportQuery),repo=Depends(repository,scope='function')):
    return analytics.report(repo,query.start,query.end,query.employee,query.country,query.room_type,query.season)


@app.get('/api/analytics/dashboard',response_model=DashboardReport,tags=['Analytics'])
def dashboard(data=Depends(get_report)):
    return data


def register_metric(path,model,summary,description):
    def endpoint(data=Depends(get_report)):
        return analytics.metric_result(data,path)
    endpoint.__name__='analytics_'+path.replace('-','_')
    app.get('/api/analytics/'+path,response_model=AnalyticsResponse[model],tags=['Analytics'],
            summary=summary,description=description)(endpoint)


for path,model,summary,description in [
    ('revpar',RevPARReport,'Revenue per available room night (RevPAR)', 'Room revenue divided by available room nights in DKK. Includes monthly rows, with clipped period and season capacity. Country filters revenue only; room type/season also filter capacity. Zero denominator returns zero with warnings.'),
    ('occupancy',Summary,'Occupancy and average daily rate','Sold nights / active inventory nights × 100. Country filters only the numerator; season/type also filter inventory.'),
    ('revenue',Summary,'Hotel revenue for a year or period','Sum of nightly historical price snapshots for confirmed bookings. Checkout is exclusive.'),
    ('revenue-by-room',list[Group],'Revenue by physical room','Sorted by revenue descending. Room number identifies the physical room.'),
    ('revenue-by-room-type',list[Group],'Revenue by room type','Sorted by revenue descending.'),
    ('revenue-by-country',list[Group],'Revenue by country','Country is the booking guest country.'),
    ('revenue-by-season',list[Group],'Revenue by season','Season is determined per occupied night.'),
    ('revenue-by-room-type-season',list[Group],'Revenue by room type and season','Cross-season stays are split by nightly snapshots.'),
    ('guests-by-country',list[Group],'Guests by country','booking_guests counts party sizes once per matching booking; distinct_bookers counts booking guest snapshots, not identified repeat visitors. All party members are attributed to the booker country.'),
    ('top-performers',TopPerformers,'Most profitable room, type and country','Highest total revenue in the selected period. Empty groups return null.'),
    ('bar-sales',BarReport,'Bar revenue, drinks and category shares','Default employee is Helene Christine. Includes total_revenue, products and categories with percentage of total revenue. Hotel filters do not affect bar sales.'),
    ('customer-satisfaction',Satisfaction,'Guest ratings and response rate','Checkout cohort in [from,to). Only completed confirmed bookings qualify. Average is null without ratings; no synthetic scores.'),
]:
    register_metric(path,model,summary,description)


class RevenuePeriodQuery:
    def __init__(self, from_date: date|None=Query(None,alias='from'),
                 to_date: date|None=Query(None,alias='to'),
                 year: int|None=Query(None,ge=1900,le=9998)):
        self.start,self.end=analytics.period(from_date,to_date,year)


@app.get('/analytics/revenue/by-room-type-season',response_model=list[RoomTypeSeasonRevenueRow],
         tags=['Tableau revenue'], summary='Flat revenue rows: every room type × season',
         description='All 24 combinations, including zero revenue. Backend sums historical nightly price × quantity. Confirmed stays only; checkout and to are exclusive. DKK numbers, not strings. Default year 2026.')
def room_type_season_rows(query=Depends(RevenuePeriodQuery), repo=Depends(repository,scope='function')):
    return revenue_rows.room_type_season(repo,query.start,query.end)


@app.get('/analytics/revenue/by-country',response_model=list[CountryRevenueRow],
         tags=['Tableau revenue'], summary='Flat revenue rows by country',
         description='Backend sums historical nightly price × quantity by booking guest country. Danish country labels where mapped; database name/code otherwise. Confirmed stays only; default year 2026. DKK JSON numbers. Empty period returns [].')
def country_revenue_rows(query=Depends(RevenuePeriodQuery), repo=Depends(repository,scope='function')):
    return revenue_rows.by_country(repo,query.start,query.end)
