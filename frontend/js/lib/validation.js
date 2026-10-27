// Klientsidevalidering. Backend validerer altid igen; reglerne her giver
// receptionisten hurtig og forståelig feedback (C-010, C-011).
import { parseIsoDate } from './dates.js';

// Største værelsestype har plads til 4 gæster (room_types.capacity 1-4).
export const MAX_GUESTS_PER_ROOM = 4;

function result(errors) {
  return { valid: Object.keys(errors).length === 0, errors };
}

function isBlank(value) {
  return value === undefined || value === null || String(value).trim() === '';
}

/**
 * Validerer check-in, check-out og antal gæster.
 * @param {{check_in: string, check_out: string, guests_count: string|number}} stay
 * @param {{today?: string, maxGuests?: number}} [options]
 *   today: ISO-dato; check-in før denne dato afvises (bruges ved nye bookinger).
 *   maxGuests: øvre grænse for antal gæster, fx værelsets kapacitet.
 */
export function validateStay(stay, { today, maxGuests = MAX_GUESTS_PER_ROOM } = {}) {
  const { check_in: checkIn, check_out: checkOut, guests_count: guestsCount } = stay ?? {};
  const errors = {};

  const checkInDate = parseIsoDate(checkIn);
  const checkOutDate = parseIsoDate(checkOut);

  if (isBlank(checkIn)) {
    errors.check_in = 'Vælg en check-in-dato.';
  } else if (!checkInDate) {
    errors.check_in = 'Check-in skal være en gyldig dato (ÅÅÅÅ-MM-DD).';
  } else if (today && checkIn < today) {
    errors.check_in = 'Check-in kan ikke ligge før i dag.';
  }

  if (isBlank(checkOut)) {
    errors.check_out = 'Vælg en check-out-dato.';
  } else if (!checkOutDate) {
    errors.check_out = 'Check-out skal være en gyldig dato (ÅÅÅÅ-MM-DD).';
  } else if (checkInDate && checkOutDate <= checkInDate) {
    errors.check_out = 'Check-out skal være efter check-in.';
  }

  const guests = Number(guestsCount);
  if (isBlank(guestsCount)) {
    errors.guests_count = 'Angiv antal gæster.';
  } else if (!Number.isInteger(guests) || guests <= 0) {
    errors.guests_count = 'Antal gæster skal være et helt tal større end nul.';
  } else if (guests > maxGuests) {
    errors.guests_count = `Værelset har plads til højst ${maxGuests} gæster.`;
  }

  return result(errors);
}
