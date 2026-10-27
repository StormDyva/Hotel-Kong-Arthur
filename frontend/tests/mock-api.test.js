import assert from 'node:assert/strict';
import { beforeEach, describe, test } from 'node:test';

import { ApiError } from '../js/services/api-error.js';
import { createMockApi } from '../js/services/mock-api.js';

const guest = {
  name: 'Ole Jensen',
  email: 'ole@example.com',
  phone: '+45 11 22 33 44',
  country_code: 'dk',
};

const newBooking = (overrides = {}) => ({
  room_id: 7,
  check_in: '2026-11-20',
  check_out: '2026-11-23',
  guests_count: 2,
  price_total: 4800,
  currency: 'DKK',
  guest,
  ...overrides,
});

let api;
beforeEach(() => {
  api = createMockApi({ now: () => new Date('2026-10-27T10:00:00Z') });
});

describe('searchAvailability – mock-ledige værelser', () => {
  test('returnerer værelser i det aftalte format med samlet pris', async () => {
    const rooms = await api.searchAvailability({
      check_in: '2026-11-20',
      check_out: '2026-11-23',
      guests_count: 2,
    });
    assert.ok(rooms.length > 0);
    for (const room of rooms) {
      assert.deepEqual(Object.keys(room), [
        'room_id', 'room_number', 'room_type', 'capacity', 'price_per_night', 'total_price',
      ]);
      assert.equal(room.total_price, room.price_per_night * 3);
      assert.ok(room.capacity >= 2);
    }
    assert.deepEqual(rooms.find((r) => r.room_id === 12), {
      room_id: 12,
      room_number: '204',
      room_type: 'Standard dobbeltværelse',
      capacity: 2,
      price_per_night: 1600,
      total_price: 4800,
    });
  });

  test('værelser med for lille kapacitet udelades', async () => {
    const rooms = await api.searchAvailability({ check_in: '2026-11-20', check_out: '2026-11-21', guests_count: 4 });
    assert.ok(rooms.every((r) => r.capacity >= 4));
    assert.ok(!rooms.some((r) => r.room_number === '101'));
  });

  test('værelser med overlappende bekræftet booking udelades', async () => {
    // Mock-booking 1001: værelse 204, 2026-11-05 til 2026-11-08.
    const overlapping = await api.searchAvailability({ check_in: '2026-11-07', check_out: '2026-11-09', guests_count: 1 });
    assert.ok(!overlapping.some((r) => r.room_id === 12));
    // Check-out-dagen er fri.
    const sameDay = await api.searchAvailability({ check_in: '2026-11-08', check_out: '2026-11-09', guests_count: 1 });
    assert.ok(sameDay.some((r) => r.room_id === 12));
  });

  test('annullerede bookinger blokerer ikke', async () => {
    // Mock-booking 1003 på værelse 501 er annulleret.
    const rooms = await api.searchAvailability({ check_in: '2026-12-01', check_out: '2026-12-03', guests_count: 2 });
    assert.ok(rooms.some((r) => r.room_id === 31));
  });

  test('ugyldig søgning afvises med VALIDATION_ERROR', async () => {
    await assert.rejects(
      api.searchAvailability({ check_in: '2026-11-20', check_out: '2026-11-20', guests_count: 0 }),
      (error) => {
        assert.ok(error instanceof ApiError);
        assert.equal(error.status, 422);
        assert.equal(error.code, 'VALIDATION_ERROR');
        assert.deepEqual(Object.keys(error.fieldErrors).sort(), ['check_out', 'guests_count']);
        return true;
      },
    );
  });
});

describe('createBooking – mock-booking', () => {
  test('opretter en bekræftet booking med pris og gæst', async () => {
    const booking = await api.createBooking(newBooking());
    assert.equal(booking.status, 'confirmed');
    assert.equal(booking.room_number, '115');
    assert.equal(booking.price_total, 4800);
    assert.equal(booking.currency, 'DKK');
    assert.equal(booking.guest.country_code, 'DK');
    assert.equal(booking.created_at, '2026-10-27T10:00:00.000Z');

    const all = await api.listBookings();
    assert.ok(all.some((b) => b.id === booking.id));
  });

  test('det bookede værelse er ikke længere ledigt i perioden', async () => {
    await api.createBooking(newBooking());
    const rooms = await api.searchAvailability({ check_in: '2026-11-21', check_out: '2026-11-22', guests_count: 1 });
    assert.ok(!rooms.some((r) => r.room_id === 7));
  });

  test('dobbeltbooking afvises med 409', async () => {
    await api.createBooking(newBooking());
    await assert.rejects(api.createBooking(newBooking({ check_in: '2026-11-22', check_out: '2026-11-24' })), {
      status: 409,
      code: 'BOOKING_CONFLICT',
    });
  });

  test('manglende gæstefelter afvises', async () => {
    await assert.rejects(
      api.createBooking(newBooking({ guest: { ...guest, email: '', phone: '' } })),
      (error) => error.status === 422 && 'email' in error.fieldErrors && 'phone' in error.fieldErrors,
    );
  });

  test('ugyldige datoer og for mange gæster afvises', async () => {
    await assert.rejects(api.createBooking(newBooking({ check_out: '2026-11-19' })), { status: 422 });
    await assert.rejects(api.createBooking(newBooking({ guests_count: 3 })), { status: 422 });
    await assert.rejects(api.createBooking(newBooking({ room_id: 999 })), { status: 422 });
  });
});

describe('cancelBooking – annullering', () => {
  test('booking annulleres, bevares og værelset frigives', async () => {
    const booking = await api.createBooking(newBooking());
    const cancelled = await api.cancelBooking(booking.id);
    assert.equal(cancelled.status, 'cancelled');

    const stored = (await api.listBookings()).find((b) => b.id === booking.id);
    assert.equal(stored.status, 'cancelled');

    const rooms = await api.searchAvailability({ check_in: '2026-11-20', check_out: '2026-11-23', guests_count: 2 });
    assert.ok(rooms.some((r) => r.room_id === 7));
    await api.createBooking(newBooking());
  });

  test('gentaget annullering er idempotent', async () => {
    const first = await api.cancelBooking(1001);
    const second = await api.cancelBooking(1001);
    assert.equal(second.status, 'cancelled');
    assert.equal(second.updated_at, first.updated_at);
  });

  test('ukendt booking giver 404', async () => {
    await assert.rejects(api.cancelBooking(424242), { status: 404, code: 'NOT_FOUND' });
  });

  test('listBookings kan filtrere på status', async () => {
    await api.cancelBooking(1001);
    const cancelled = await api.listBookings({ status: 'cancelled' });
    assert.deepEqual(cancelled.map((b) => b.id), [1001, 1003]);
  });
});

describe('updateBooking – redigering', () => {
  test('datoer ændres og prisen genberegnes', async () => {
    const updated = await api.updateBooking(1001, {
      room_id: 12,
      check_in: '2026-11-05',
      check_out: '2026-11-10',
      guests_count: 1,
      guest: { name: 'Mette Holm', email: 'mette@example.com', phone: '20304050', country_code: 'DK' },
    });
    assert.equal(updated.check_out, '2026-11-10');
    assert.equal(updated.price_total, 1600 * 5);
    assert.equal(updated.guests_count, 1);
  });

  test('bookingen må gerne overlappe sig selv, men ikke andre', async () => {
    const other = await api.createBooking(newBooking({ room_id: 12, check_in: '2026-11-10', check_out: '2026-11-12' }));
    await assert.rejects(
      api.updateBooking(1001, { room_id: 12, check_in: '2026-11-06', check_out: '2026-11-11', guests_count: 2, guest }),
      { status: 409 },
    );
    await api.cancelBooking(other.id);
    await api.updateBooking(1001, { room_id: 12, check_in: '2026-11-06', check_out: '2026-11-11', guests_count: 2, guest });
  });

  test('ugyldige datoer og annullerede bookinger afvises', async () => {
    await assert.rejects(
      api.updateBooking(1001, { room_id: 12, check_in: '2026-11-08', check_out: '2026-11-05', guests_count: 2, guest }),
      { status: 422 },
    );
    await assert.rejects(
      api.updateBooking(1003, { room_id: 31, check_in: '2026-12-01', check_out: '2026-12-03', guests_count: 2, guest }),
      { status: 409, code: 'BOOKING_CANCELLED' },
    );
  });
});

test('mock-instanser deler ikke data', async () => {
  await api.cancelBooking(1001);
  const fresh = createMockApi();
  const booking = (await fresh.listBookings()).find((b) => b.id === 1001);
  assert.equal(booking.status, 'confirmed');
});
