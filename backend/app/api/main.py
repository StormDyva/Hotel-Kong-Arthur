import os
from datetime import date
from typing import Literal
from fastapi import FastAPI, Depends, Query, Response
from fastapi.exceptions import RequestValidationError
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from sqlalchemy.exc import SQLAlchemyError
from app.repositories.database import engine, Repository
from app.services import bookings, analytics
from .schemas import BookingWrite, Booking, BookingPage, Dashboard

app = FastAPI(responses={404: {'description':'Resource not found'}, 409: {'description':'Booking conflict or unavailable price/room'}, 422: {'description':'Invalid request'}, 503: {'description':'Database unavailable'}}, title='Hotel Kong Arthur API', version='1.0.0', description='Three-layer booking and analytics API. Report end dates are exclusive. Demo data, not actual hotel results.')
app.add_middleware(CORSMiddleware, allow_origins=os.getenv('CORS_ORIGINS', 'http://localhost:5500,http://127.0.0.1:5500').split(','), allow_methods=['GET','POST','PUT','DELETE'], allow_headers=['Content-Type'])


def repository():
    with engine.begin() as connection:
        yield Repository(connection)


@app.exception_handler(bookings.DomainError)
def domain_error(request, exc):
    return JSONResponse(status_code=exc.status, content=dict(error=exc.code, message=exc.message, details=[]))


@app.exception_handler(RequestValidationError)
def validation_error(request, exc):
    return JSONResponse(status_code=422, content=dict(error='VALIDATION_ERROR', message='Invalid request',
        details=[dict(field='.'.join(str(v) for v in e['loc'][1:]), message=e['msg']) for e in exc.errors()]))


@app.exception_handler(SQLAlchemyError)
def database_error(request, exc):
    import logging
    logging.getLogger(__name__).error('Database operation failed', exc_info=(type(exc), exc, exc.__traceback__))
    return JSONResponse(status_code=503, content=dict(error='DATABASE_ERROR', message='Database operation failed', details=[]))


@app.get('/health')
def health(repo=Depends(repository, scope='function')):
    repo.health()
    return dict(status='ok', database='ok')


@app.get('/api/rooms/availability')
def availability(check_in: date, check_out: date, guests_count: int = Query(ge=1, le=4), repo=Depends(repository, scope='function')):
    return bookings.availability(repo, check_in, check_out, guests_count)


@app.get('/api/room-types')
def room_types(repo=Depends(repository, scope='function')):
    return repo.room_types()


@app.get('/api/bookings', response_model=BookingPage)
def list_bookings(status: Literal['confirmed','cancelled'] | None = None,
                  page: int = Query(1, ge=1), page_size: int = Query(100, ge=1, le=100), repo=Depends(repository, scope='function')):
    rows, total = repo.booking_page(status, page, page_size)
    return dict(items=[bookings.present(b) for b in rows], total=total, page=page, page_size=page_size)


@app.get('/api/bookings/{booking_id}', response_model=Booking)
def get_booking(booking_id: int, repo=Depends(repository, scope='function')):
    return bookings.detail(repo, booking_id)


@app.post('/api/bookings', status_code=201, response_model=Booking)
def create_booking(data: BookingWrite, repo=Depends(repository, scope='function')):
    return bookings.save(repo, data)


@app.put('/api/bookings/{booking_id}', response_model=Booking)
def update_booking(booking_id: int, data: BookingWrite, repo=Depends(repository, scope='function')):
    return bookings.save(repo, data, booking_id)


@app.delete('/api/bookings/{booking_id}', status_code=204)
def cancel_booking(booking_id: int, repo=Depends(repository, scope='function')):
    bookings.cancel(repo, booking_id)
    return Response(status_code=204)


@app.get('/api/analytics/dashboard', response_model=Dashboard)
def dashboard(from_date: date = Query(date(2026,1,1), alias='from'),
              to_date: date = Query(date(2027,1,1), alias='to'), employee_name: str = 'Helene Christine', repo=Depends(repository, scope='function')):
    return analytics.report(repo, from_date, to_date, employee_name)


@app.get('/api/analytics/{metric}')
def metric(metric: Literal['occupancy','revenue','revenue-by-room-type','revenue-by-country','revenue-by-season','bar-sales'],
           from_date: date = Query(date(2026,1,1), alias='from'), to_date: date = Query(date(2027,1,1), alias='to'),
           employee_name: str = 'Helene Christine', repo=Depends(repository, scope='function')):
    data = analytics.report(repo, from_date, to_date, employee_name)
    key = {'revenue-by-room-type':'by_room_type','revenue-by-country':'by_country','revenue-by-season':'by_season',
           'bar-sales':'bar_products'}.get(metric, 'summary')
    return dict(from_date=from_date, to_date=to_date, currency='DKK', warnings=data['warnings'], data=data[key])
