// Mock-implementering af booking-API'et. Har samme metoder som HTTP-klienten
// i booking-service.js og efterligner de godkendte forretningsregler:
// - check-out efter check-in, gæster > 0 og <= kapacitet (C-011)
// - overlap: new.check_in < existing.check_out && new.check_out > existing.check_in
// - DELETE er idempotent soft-cancel; annullerede bookinger blokerer ikke (C-006)
// Data ligger kun i hukommelsen og nulstilles ved genindlæsning.
import { nightsBetween } from '../lib/dates.js';
import { validateGuest, validateStay } from '../lib/validation.js';
import { ApiError, validationError } from './api-error.js';
import { MOCK_BOOKINGS, MOCK_ROOMS } from './mock-data.js';

export function createMockApi({
  rooms = MOCK_ROOMS,
  bookings = MOCK_BOOKINGS,
  latencyMs = 0,
  now = () => new Date(),
} = {}) {
  const roomList = structuredClone(rooms);
  const store = structuredClone(bookings);
  let nextId = Math.max(1000, ...store.map((b) => b.id)) + 1;

  const delay = () =>
    latencyMs > 0 ? new Promise((resolve) => setTimeout(resolve, latencyMs)) : Promise.resolve();

  const findRoom = (roomId) => roomList.find((r) => r.room_id === Number(roomId));

  const findBooking = (id) => {
    const booking = store.find((b) => b.id === Number(id));
    if (!booking) throw new ApiError(404, 'NOT_FOUND', `Booking ${id} findes ikke.`);
    return booking;
  };

  const overlaps = (roomId, checkIn, checkOut, ignoreId) =>
    store.some(
      (b) =>
        b.status === 'confirmed' &&
        b.room_id === roomId &&
        b.id !== ignoreId &&
        checkIn < b.check_out &&
        checkOut > b.check_in,
    );

  function assertValidStay(stay, maxGuests) {
    const { valid, errors } = validateStay(stay, maxGuests ? { maxGuests } : undefined);
    if (!valid) throw validationError(errors);
  }

  function assertValidGuest(guest) {
    const { valid, errors } = validateGuest(guest);
    if (!valid) throw validationError(errors, 'Gæstens oplysninger er ufuldstændige.');
  }

  function assertBookable(room, { check_in, check_out, guests_count }, ignoreId) {
    if (Number(guests_count) > room.capacity) {
      throw validationError(
        { guests_count: `Værelse ${room.room_number} har plads til højst ${room.capacity} gæster.` },
        'Antal gæster overstiger værelsets kapacitet.',
      );
    }
    if (overlaps(room.room_id, check_in, check_out, ignoreId)) {
      throw new ApiError(
        409,
        'BOOKING_CONFLICT',
        `Værelse ${room.room_number} er allerede booket i den valgte periode.`,
      );
    }
  }

  const cleanGuest = (guest) => ({
    name: guest.name.trim(),
    email: guest.email.trim(),
    phone: guest.phone.trim(),
    country_code: guest.country_code.trim().toUpperCase(),
  });

  return {
    // GET /api/rooms/availability?check_in&check_out&guests_count
    async searchAvailability({ check_in, check_out, guests_count }) {
      await delay();
      assertValidStay({ check_in, check_out, guests_count });
      const nights = nightsBetween(check_in, check_out);
      return roomList
        .filter((room) => room.capacity >= Number(guests_count))
        .filter((room) => !overlaps(room.room_id, check_in, check_out))
        .map((room) => ({
          room_id: room.room_id,
          room_number: room.room_number,
          room_type: room.room_type,
          capacity: room.capacity,
          price_per_night: room.price_per_night,
          total_price: room.price_per_night * nights,
        }));
    },

    // GET /api/bookings?status=confirmed|cancelled
    async listBookings({ status } = {}) {
      await delay();
      return structuredClone(
        store
          .filter((b) => !status || b.status === status)
          .sort((a, b) => a.check_in.localeCompare(b.check_in) || a.id - b.id),
      );
    },

    // POST /api/bookings
    async createBooking(payload) {
      await delay();
      const room = findRoom(payload?.room_id);
      if (!room) throw validationError({ room_id: 'Vælg et gyldigt værelse.' });
      assertValidStay(payload, room.capacity);
      assertValidGuest(payload.guest);
      assertBookable(room, payload);

      const timestamp = now().toISOString();
      const booking = {
        id: nextId++,
        room_id: room.room_id,
        room_number: room.room_number,
        room_type: room.room_type,
        capacity: room.capacity,
        check_in: payload.check_in,
        check_out: payload.check_out,
        guests_count: Number(payload.guests_count),
        price_per_night: room.price_per_night,
        price_total: room.price_per_night * nightsBetween(payload.check_in, payload.check_out),
        currency: 'DKK',
        status: 'confirmed',
        guest: cleanGuest(payload.guest),
        created_at: timestamp,
        updated_at: timestamp,
      };
      store.push(booking);
      return structuredClone(booking);
    },

    // PUT /api/bookings/{id} – fuld opdatering, valideres igen.
    async updateBooking(id, payload) {
      await delay();
      const booking = findBooking(id);
      if (booking.status === 'cancelled') {
        throw new ApiError(409, 'BOOKING_CANCELLED', 'Annullerede bookinger kan ikke redigeres.');
      }
      const room = findRoom(payload?.room_id ?? booking.room_id);
      if (!room) throw validationError({ room_id: 'Vælg et gyldigt værelse.' });
      assertValidStay(payload, room.capacity);
      assertValidGuest(payload.guest);
      assertBookable(room, payload, booking.id);

      Object.assign(booking, {
        room_id: room.room_id,
        room_number: room.room_number,
        room_type: room.room_type,
        capacity: room.capacity,
        check_in: payload.check_in,
        check_out: payload.check_out,
        guests_count: Number(payload.guests_count),
        price_per_night: room.price_per_night,
        price_total: room.price_per_night * nightsBetween(payload.check_in, payload.check_out),
        guest: cleanGuest(payload.guest),
        updated_at: now().toISOString(),
      });
      return structuredClone(booking);
    },

    // DELETE /api/bookings/{id} – idempotent soft-cancel.
    async cancelBooking(id) {
      await delay();
      const booking = findBooking(id);
      if (booking.status !== 'cancelled') {
        booking.status = 'cancelled';
        booking.updated_at = now().toISOString();
      }
      return structuredClone(booking);
    },
  };
}
