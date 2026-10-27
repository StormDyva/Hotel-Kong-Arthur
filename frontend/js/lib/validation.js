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

const EMAIL = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;
const PHONE_CHARS = /^\+?[\d\s()-]+$/;
const COUNTRY_CODE = /^[A-Z]{2}$/;

/**
 * Validerer gæstens navn, e-mail, telefon og land (ISO 3166-1 alpha-2).
 * @param {{name: string, email: string, phone: string, country_code: string}} guest
 */
export function validateGuest(guest) {
  const { name, email, phone, country_code: countryCode } = guest ?? {};
  const errors = {};

  const trimmedName = String(name ?? '').trim();
  if (!trimmedName) {
    errors.name = 'Angiv gæstens fulde navn.';
  } else if (trimmedName.length < 2 || trimmedName.length > 120) {
    errors.name = 'Navnet skal være mellem 2 og 120 tegn.';
  }

  const trimmedEmail = String(email ?? '').trim();
  if (!trimmedEmail) {
    errors.email = 'Angiv gæstens e-mail.';
  } else if (!EMAIL.test(trimmedEmail)) {
    errors.email = 'E-mailen er ikke gyldig (fx navn@example.com).';
  }

  const trimmedPhone = String(phone ?? '').trim();
  const digits = trimmedPhone.replace(/\D/g, '').length;
  if (!trimmedPhone) {
    errors.phone = 'Angiv gæstens telefonnummer.';
  } else if (!PHONE_CHARS.test(trimmedPhone) || digits < 6 || digits > 15) {
    errors.phone = 'Telefonnummeret skal have 6-15 cifre og må starte med +.';
  }

  if (isBlank(countryCode)) {
    errors.country_code = 'Vælg gæstens land.';
  } else if (!COUNTRY_CODE.test(String(countryCode).trim().toUpperCase())) {
    errors.country_code = 'Landet skal angives som en landekode på to bogstaver.';
  }

  return result(errors);
}
