import assert from 'node:assert/strict';
import { describe, test } from 'node:test';

import { addDays, nightsBetween, parseIsoDate } from '../js/lib/dates.js';
import { validateGuest, validateStay } from '../js/lib/validation.js';

const stay = (overrides = {}) => ({
  check_in: '2026-11-10',
  check_out: '2026-11-13',
  guests_count: 2,
  ...overrides,
});

const guest = (overrides = {}) => ({
  name: 'Mette Holm',
  email: 'mette@example.com',
  phone: '+45 20 30 40 50',
  country_code: 'DK',
  ...overrides,
});

describe('validateStay – datoer', () => {
  test('gyldigt ophold accepteres', () => {
    assert.deepEqual(validateStay(stay()), { valid: true, errors: {} });
  });

  test('check-out samme dag som check-in afvises', () => {
    const { valid, errors } = validateStay(stay({ check_out: '2026-11-10' }));
    assert.equal(valid, false);
    assert.equal(errors.check_out, 'Check-out skal være efter check-in.');
  });

  test('check-out før check-in afvises', () => {
    const { valid, errors } = validateStay(stay({ check_out: '2026-11-09' }));
    assert.equal(valid, false);
    assert.equal(errors.check_out, 'Check-out skal være efter check-in.');
  });

  test('manglende datoer afvises', () => {
    const { errors } = validateStay(stay({ check_in: '', check_out: '' }));
    assert.ok(errors.check_in);
    assert.ok(errors.check_out);
  });

  test('ugyldige kalenderdatoer afvises', () => {
    const { errors } = validateStay(stay({ check_in: '2026-02-30', check_out: '13-11-2026' }));
    assert.match(errors.check_in, /gyldig dato/);
    assert.match(errors.check_out, /gyldig dato/);
  });

  test('check-in før i dag afvises, når today er angivet', () => {
    const { errors } = validateStay(stay({ check_in: '2026-10-26' }), { today: '2026-10-27' });
    assert.match(errors.check_in, /før i dag/);
    assert.equal(validateStay(stay({ check_in: '2026-10-27' }), { today: '2026-10-27' }).valid, true);
  });
});

describe('validateStay – antal gæster', () => {
  for (const value of [0, -1, '0', 1.5, 'to']) {
    test(`antal gæster ${JSON.stringify(value)} afvises`, () => {
      const { valid, errors } = validateStay(stay({ guests_count: value }));
      assert.equal(valid, false);
      assert.match(errors.guests_count, /større end nul/);
    });
  }

  test('tomt antal gæster afvises', () => {
    assert.equal(validateStay(stay({ guests_count: '' })).errors.guests_count, 'Angiv antal gæster.');
  });

  test('1 gæst accepteres, også som tekst fra formularen', () => {
    assert.equal(validateStay(stay({ guests_count: '1' })).valid, true);
  });

  test('flere gæster end kapaciteten afvises', () => {
    assert.equal(validateStay(stay({ guests_count: 5 })).valid, false);
    const { errors } = validateStay(stay({ guests_count: 3 }), { maxGuests: 2 });
    assert.match(errors.guests_count, /højst 2 gæster/);
  });
});

describe('validateGuest – bookingformularens nødvendige felter', () => {
  test('gyldige gæsteoplysninger accepteres', () => {
    assert.deepEqual(validateGuest(guest()), { valid: true, errors: {} });
  });

  test('alle nødvendige felter kræves', () => {
    const { valid, errors } = validateGuest({ name: ' ', email: '', phone: '', country_code: '' });
    assert.equal(valid, false);
    assert.deepEqual(Object.keys(errors).sort(), ['country_code', 'email', 'name', 'phone']);
  });

  test('manglende gæsteobjekt giver fejl på alle felter', () => {
    assert.equal(Object.keys(validateGuest(undefined).errors).length, 4);
  });

  test('ugyldig e-mail afvises', () => {
    for (const email of ['mette', 'mette@', 'mette@example', 'me tte@example.com']) {
      assert.ok(validateGuest(guest({ email })).errors.email, email);
    }
  });

  test('ugyldigt telefonnummer afvises', () => {
    for (const phone of ['12345', 'abc12345678', '+45 20-30-40-50-60-70-80-90']) {
      assert.ok(validateGuest(guest({ phone })).errors.phone, phone);
    }
    assert.equal(validateGuest(guest({ phone: '20304050' })).valid, true);
  });

  test('land skal være en landekode på to bogstaver', () => {
    assert.ok(validateGuest(guest({ country_code: 'DNK' })).errors.country_code);
    assert.ok(validateGuest(guest({ country_code: '1' })).errors.country_code);
  });
});

describe('datohjælpere', () => {
  test('antal nætter tæller ikke check-out-dagen og påvirkes ikke af sommertid', () => {
    assert.equal(nightsBetween('2026-11-10', '2026-11-13'), 3);
    assert.equal(nightsBetween('2026-10-24', '2026-10-26'), 2);
    assert.equal(nightsBetween('2026-11-10', 'ugyldig'), 0);
  });

  test('addDays og parseIsoDate', () => {
    assert.equal(addDays('2026-12-31', 1), '2027-01-01');
    assert.equal(parseIsoDate('2026-02-29'), null);
  });
});
