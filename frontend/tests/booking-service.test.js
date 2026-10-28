import assert from 'node:assert/strict';
import { describe, test } from 'node:test';

import { ApiError } from '../js/services/api-error.js';
import { createBookingService, ENDPOINTS } from '../js/services/booking-service.js';

function fakeFetch(responses = []) {
  const calls = [];
  const fetchImpl = async (url, init) => {
    calls.push({ url, method: init.method, body: init.body ? JSON.parse(init.body) : undefined });
    const next = responses.shift() ?? { status: 200, body: [] };
    if (next.throws) throw new TypeError('Failed to fetch');
    return {
      ok: next.status >= 200 && next.status < 300,
      status: next.status,
      json: async () => {
        if (next.body === undefined) throw new SyntaxError('no body');
        return next.body;
      },
    };
  };
  return { calls, fetchImpl };
}

const apiService = (responses) => {
  const fake = fakeFetch(responses);
  const service = createBookingService({ useMock: false, apiBaseUrl: 'http://api.test', fetchImpl: fake.fetchImpl });
  return { service, calls: fake.calls };
};

describe('service-lag mod REST-API', () => {
  test('kalder de aftalte endpoints med korrekt metode', async () => {
    const { service, calls } = apiService([
      { status: 200, body: [] },
      { status: 201, body: { id: 1 } },
      { status: 200, body: [] },
      { status: 200, body: { id: 1 } },
      { status: 204 },
    ]);

    await service.searchAvailability({ check_in: '2026-11-01', check_out: '2026-11-03', guests_count: 2 });
    await service.createBooking({ room_id: 12 });
    await service.listBookings({ status: 'confirmed' });
    await service.updateBooking(1, { room_id: 12 });
    const deleted = await service.cancelBooking(1);

    assert.deepEqual(
      calls.map((c) => `${c.method} ${c.url}`),
      [
        'GET http://api.test/api/rooms/availability?check_in=2026-11-01&check_out=2026-11-03&guests_count=2',
        'POST http://api.test/api/bookings',
        'GET http://api.test/api/bookings?status=confirmed&page=1&page_size=100',
        'PUT http://api.test/api/bookings/1',
        'DELETE http://api.test/api/bookings/1',
      ],
    );
    assert.deepEqual(calls[1].body, { room_id: 12 });
    assert.equal(deleted, null);
  });

  test('tomme filtre sendes ikke som query-parametre', async () => {
    const { service, calls } = apiService();
    await service.listBookings({ status: undefined });
    assert.equal(calls[0].url, 'http://api.test/api/bookings?page=1&page_size=100');
  });

  test('paginerede lister normaliseres til arrays', async () => {
    const { service } = apiService([{ status: 200, body: { items: [{ id: 7 }], page: 1 } }]);
    assert.deepEqual(await service.listBookings(), [{ id: 7 }]);
  });

  test('API-fejl omsættes til ApiError med feltfejl', async () => {
    const { service } = apiService([
      {
        status: 422,
        body: {
          error: 'VALIDATION_ERROR',
          message: 'check_out must be after check_in',
          details: [{ field: 'check_out', message: 'check_out must be after check_in' }],
        },
      },
    ]);
    await assert.rejects(service.createBooking({}), (error) => {
      assert.ok(error instanceof ApiError);
      assert.equal(error.status, 422);
      assert.equal(error.message, 'check_out must be after check_in');
      assert.deepEqual(error.fieldErrors, { check_out: 'check_out must be after check_in' });
      return true;
    });
  });

  test('netværksfejl giver en forståelig besked', async () => {
    const { service } = apiService([{ throws: true }]);
    await assert.rejects(service.listBookings(), { code: 'NETWORK_ERROR', status: 0 });
  });

  test('fejl uden JSON-body håndteres', async () => {
    const { service } = apiService([{ status: 500 }]);
    await assert.rejects(service.listBookings(), { code: 'HTTP_ERROR', status: 500 });
  });

  test('endpoint-stier matcher kontrakten', () => {
    assert.equal(ENDPOINTS.availability, '/api/rooms/availability');
    assert.equal(ENDPOINTS.bookings, '/api/bookings');
    assert.equal(ENDPOINTS.booking(42), '/api/bookings/42');
  });
});

describe('service-lag i mock-tilstand', () => {
  test('søger, opretter og annullerer uden netværk', async () => {
    const service = createBookingService({ useMock: true });
    assert.equal(service.mode, 'mock');
    const rooms = await service.searchAvailability({ check_in: '2026-11-20', check_out: '2026-11-22', guests_count: 2 });
    const room = rooms[0];
    const booking = await service.createBooking({
      room_id: room.room_id,
      check_in: '2026-11-20',
      check_out: '2026-11-22',
      guests_count: 2,
      price_total: room.total_price,
      guest: { name: 'Test Gæst', email: 'test@example.com', phone: '12345678', country_code: 'NO' },
    });
    assert.equal(booking.price_total, room.total_price);
    assert.equal((await service.cancelBooking(booking.id)).status, 'cancelled');
  });
});

test('henter alle sider til receptionens søgning', async () => {
  const { service, calls } = apiService([
    { status: 200, body: { items: [{ id: 1 }], total: 2 } },
    { status: 200, body: { items: [{ id: 2 }], total: 2 } },
  ]);
  assert.deepEqual(await service.listBookings(), [{ id: 1 }, { id: 2 }]);
  assert.match(calls[1].url, /page=2/);
});
