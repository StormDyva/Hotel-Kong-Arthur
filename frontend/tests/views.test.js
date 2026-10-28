// Tester HTML-skabelonerne, som UI'et bruger til at vise data.
import assert from 'node:assert/strict';
import { describe, test } from 'node:test';

import { buildBookingPayload, confirmationHtml } from '../js/ui/booking-form.js';
import { bookingRowHtml, bookingRowsHtml, buildUpdatePayload, filterBookings } from '../js/ui/reception.js';
import { roomsListHtml } from '../js/ui/rooms-view.js';
import { createMockApi } from '../js/services/mock-api.js';
import { MOCK_BOOKINGS } from '../js/services/mock-data.js';

// Intl bruger hårde mellemrum i beløb; normalisér for læsbare asserts.
const text = (html) => html.replace(/ | /g, ' ');

describe('visning af ledige værelser', () => {
  test('mock-ledige værelser vises med type, kapacitet og priser', async () => {
    const rooms = await createMockApi().searchAvailability({
      check_in: '2026-11-20',
      check_out: '2026-11-23',
      guests_count: 2,
    });
    const html = text(roomsListHtml(rooms, 3));

    for (const room of rooms) {
      assert.match(html, new RegExp(`Værelse ${room.room_number}`));
      assert.ok(html.includes(room.room_type));
      assert.ok(html.includes(`data-select-room="${room.room_id}"`));
    }
    assert.match(html, /Standard dobbeltværelse/);
    assert.match(html, /2 gæster/);
    assert.match(html, /1\.600 kr\./);
    assert.match(html, /I alt for 3 nætter<\/dt><dd>4\.800 kr\./);
  });

  test('tom søgning viser en forklarende tom-tilstand', () => {
    assert.match(roomsListHtml([], 2), /Ingen ledige værelser/);
  });

  test('værdier escapes, så data ikke kan indsætte HTML', () => {
    const html = roomsListHtml([{ room_id: 1, room_number: '<b>1</b>', room_type: '<script>x</script>', capacity: 1, price_per_night: 1 }], 1);
    assert.ok(!html.includes('<script>'));
    assert.ok(html.includes('&lt;script&gt;'));
  });
});

describe('bookingformular og bekræftelse', () => {
  const criteria = { check_in: '2026-11-20', check_out: '2026-11-23', guests_count: 2 };
  const room = { room_id: 12, room_number: '204', room_type: 'Standard dobbeltværelse', capacity: 2, price_per_night: 1600, total_price: 4800 };
  const guest = { name: 'Ole Jensen', email: 'ole@example.com', phone: '+45 11 22 33 44', country_code: 'DK' };

  test('payload til POST /api/bookings overlader prisen til backend', () => {
    assert.deepEqual(buildBookingPayload(criteria, room, guest), {
      room_id: 12,
      check_in: '2026-11-20',
      check_out: '2026-11-23',
      guests_count: 2,
      currency: 'DKK',
      guest,
    });
  });

  test('bekræftelsen viser bookingnummer, ophold og gæst', async () => {
    const booking = await createMockApi().createBooking(buildBookingPayload(criteria, room, guest));
    const html = text(confirmationHtml(booking));
    assert.match(html, new RegExp(`#${booking.id}`));
    assert.match(html, /Ole Jensen/);
    assert.match(html, /Danmark/);
    assert.match(html, /4\.800 kr\./);
  });
});

describe('receptionistens bookingoversigt', () => {
  test('bekræftede bookinger kan redigeres og annulleres', () => {
    const html = bookingRowHtml(MOCK_BOOKINGS[0]);
    assert.match(html, /data-action="edit"/);
    assert.match(html, /data-action="cancel"/);
    assert.match(html, /Bekræftet/);
  });

  test('annullerede bookinger har ingen handlinger', () => {
    const html = bookingRowHtml(MOCK_BOOKINGS[2]);
    assert.doesNotMatch(html, /data-action=/);
    assert.match(html, /Annulleret/);
  });

  test('tom liste viser en besked', () => {
    assert.match(bookingRowsHtml([]), /Ingen bookinger/);
  });

  test('søgning filtrerer på navn, e-mail, bookingnummer og værelse', () => {
    assert.deepEqual(filterBookings(MOCK_BOOKINGS, { query: 'lars' }).map((b) => b.id), [1002]);
    assert.deepEqual(filterBookings(MOCK_BOOKINGS, { query: 'example.de' }).map((b) => b.id), [1003]);
    assert.deepEqual(filterBookings(MOCK_BOOKINGS, { query: '1001' }).map((b) => b.id), [1001]);
    assert.deepEqual(filterBookings(MOCK_BOOKINGS, { query: '402' }).map((b) => b.id), [1002]);
    assert.equal(filterBookings(MOCK_BOOKINGS, { query: '' }).length, MOCK_BOOKINGS.length);
  });

  test('PUT-payload genberegner prisen ud fra nye datoer', () => {
    const payload = buildUpdatePayload(MOCK_BOOKINGS[0], {
      check_in: '2026-11-05',
      check_out: '2026-11-07',
      guests_count: '1',
      name: ' Mette Holm ',
      email: 'mette@example.com',
      phone: '20304050',
      country_code: 'DK',
    });
    assert.equal(payload.price_total, 3200);
    assert.equal(payload.guests_count, 1);
    assert.equal(payload.guest.name, 'Mette Holm');
    assert.equal(payload.status, 'confirmed');
  });
});
