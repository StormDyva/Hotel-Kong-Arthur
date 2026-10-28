// Trin 3 og 4: gæsteoplysninger og bookingbekræftelse.
import { countryName, countryOptionsHtml } from '../lib/countries.js';
import { nightsBetween } from '../lib/dates.js';
import { escapeHtml, formatDate, formatDKK, pluralize } from '../lib/format.js';
import { validateGuest } from '../lib/validation.js';
import { notify, setBusy, showFieldErrors } from './dom.js';

export function readGuestForm(form) {
  const data = new FormData(form);
  return {
    name: String(data.get('name') ?? '').trim(),
    email: String(data.get('email') ?? '').trim(),
    phone: String(data.get('phone') ?? '').trim(),
    country_code: String(data.get('country_code') ?? ''),
  };
}

// Backend beregner og gemmer prisen; klienten sender kun bookingoplysninger.
export function buildBookingPayload(criteria, room, guest) {
  return {
    room_id: room.room_id,
    check_in: criteria.check_in,
    check_out: criteria.check_out,
    guests_count: Number(criteria.guests_count),
    currency: 'DKK',
    guest,
  };
}

export function stayDetailsHtml(stay) {
  const nights = nightsBetween(stay.check_in, stay.check_out);
  const total = stay.price_total ?? stay.total_price ?? stay.price_per_night * nights;
  return `
    <dl class="summary-list">
      <div><dt>Værelse</dt><dd>${escapeHtml(stay.room_number)} · ${escapeHtml(stay.room_type)}</dd></div>
      <div><dt>Check-in</dt><dd>${formatDate(stay.check_in)}</dd></div>
      <div><dt>Check-out</dt><dd>${formatDate(stay.check_out)}</dd></div>
      <div><dt>Gæster</dt><dd>${escapeHtml(pluralize(Number(stay.guests_count), 'gæst', 'gæster'))}</dd></div>
      <div><dt>Gennemsnit pr. nat</dt><dd>${formatDKK(stay.price_per_night)}</dd></div>
      <div class="summary-total"><dt>I alt (${escapeHtml(pluralize(nights, 'nat', 'nætter'))})</dt><dd>${formatDKK(total)}</dd></div>
    </dl>`;
}

export function confirmationHtml(booking) {
  const guest = booking.guest ?? {};
  return `
    <p class="alert alert-success">Bookingen er bekræftet. Bookingnummer <strong>#${escapeHtml(booking.id)}</strong>.</p>
    ${stayDetailsHtml(booking)}
    <dl class="summary-list">
      <div><dt>Gæst</dt><dd>${escapeHtml(guest.name)}</dd></div>
      <div><dt>E-mail</dt><dd>${escapeHtml(guest.email)}</dd></div>
      <div><dt>Telefon</dt><dd>${escapeHtml(guest.phone)}</dd></div>
      <div><dt>Land</dt><dd>${escapeHtml(countryName(guest.country_code))}</dd></div>
    </dl>`;
}

export function initBookingForm({ section, confirmation, service, onBack, onCreated }) {
  const form = section.querySelector('form');
  const details = section.querySelector('[data-stay-details]');
  const formAlert = section.querySelector('[data-form-alert]');
  const submit = form.querySelector('[type="submit"]');
  let current = null;
  let submitting = false;

  form.elements.country_code.innerHTML = countryOptionsHtml();

  section.querySelector('[data-back]').addEventListener('click', () => {
    section.hidden = true;
    onBack();
  });

  form.addEventListener('submit', async (event) => {
    event.preventDefault();
    if (!current || submitting) return;
    formAlert.hidden = true;

    const guest = readGuestForm(form);
    const { valid, errors } = validateGuest(guest);
    showFieldErrors(form, errors);
    if (!valid) return;

    submitting = true;
    setBusy(submit, true, 'Opretter booking…');
    try {
      const booking = await service.createBooking(buildBookingPayload(current.criteria, current.room, guest));
      section.hidden = true;
      confirmation.querySelector('[data-confirmation]').innerHTML = confirmationHtml(booking);
      confirmation.hidden = false;
      confirmation.scrollIntoView({ behavior: 'smooth', block: 'start' });
      notify(`Booking #${booking.id} er oprettet.`, 'success');
      onCreated(booking);
    } catch (error) {
      showFieldErrors(form, error.fieldErrors ?? {});
      formAlert.textContent = error.message;
      formAlert.hidden = false;
    } finally {
      submitting = false;
      setBusy(submit, false);
    }
  });

  return {
    open(criteria, room) {
      current = { criteria, room };
      details.innerHTML = stayDetailsHtml({ ...room, ...criteria, price_total: undefined });
      formAlert.hidden = true;
      confirmation.hidden = true;
      section.hidden = false;
      section.scrollIntoView({ behavior: 'smooth', block: 'start' });
      form.elements.name.focus({ preventScroll: true });
    },
    reset() {
      current = null;
      form.reset();
      showFieldErrors(form, {});
      section.hidden = true;
      confirmation.hidden = true;
    },
  };
}
