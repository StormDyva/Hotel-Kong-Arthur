// Receptionistens bookingoversigt med redigering og annullering.
import { countryName, countryOptionsHtml } from '../lib/countries.js';
import { nightsBetween } from '../lib/dates.js';
import { escapeHtml, formatDate, formatDKK, pluralize } from '../lib/format.js';
import { validateGuest, validateStay } from '../lib/validation.js';
import { notify, setBusy, showFieldErrors } from './dom.js';

const STATUS_LABELS = { confirmed: 'Bekræftet', cancelled: 'Annulleret' };

export function filterBookings(bookings, { query = '' } = {}) {
  const needle = query.trim().toLowerCase();
  if (!needle) return bookings;
  return bookings.filter((b) =>
    [b.id, b.room_number, b.room_type, b.guest?.name, b.guest?.email, b.guest?.phone]
      .some((value) => String(value ?? '').toLowerCase().includes(needle)),
  );
}

export function pricePerNight(booking) {
  if (booking.price_per_night) return booking.price_per_night;
  const nights = nightsBetween(booking.check_in, booking.check_out);
  return nights ? booking.price_total / nights : 0;
}

// Fuld resource til PUT /api/bookings/{id}. Prisen genberegnes ud fra
// værelsets pris pr. nat, når datoerne ændres.
export function buildUpdatePayload(booking, values) {
  return {
    room_id: booking.room_id,
    check_in: values.check_in,
    check_out: values.check_out,
    guests_count: Number(values.guests_count),
    price_total: pricePerNight(booking) * nightsBetween(values.check_in, values.check_out),
    currency: 'DKK',
    status: booking.status,
    guest: {
      name: values.name.trim(),
      email: values.email.trim(),
      phone: values.phone.trim(),
      country_code: values.country_code,
    },
  };
}

export function bookingRowHtml(b) {
  const guest = b.guest ?? {};
  const isActive = b.status === 'confirmed';
  const nights = nightsBetween(b.check_in, b.check_out);
  return `
    <tr data-booking-id="${escapeHtml(b.id)}" class="${isActive ? '' : 'is-cancelled'}">
      <td data-label="Booking">#${escapeHtml(b.id)}</td>
      <td data-label="Gæst">
        <strong>${escapeHtml(guest.name)}</strong>
        <span class="cell-sub">${escapeHtml(guest.email)} · ${escapeHtml(guest.phone)}</span>
        <span class="cell-sub">${escapeHtml(countryName(guest.country_code))}</span>
      </td>
      <td data-label="Værelse">${escapeHtml(b.room_number)}<span class="cell-sub">${escapeHtml(b.room_type)}</span></td>
      <td data-label="Ophold">
        ${formatDate(b.check_in)} – ${formatDate(b.check_out)}
        <span class="cell-sub">${escapeHtml(pluralize(nights, 'nat', 'nætter'))} · ${escapeHtml(pluralize(b.guests_count, 'gæst', 'gæster'))}</span>
      </td>
      <td data-label="Pris" class="num">${formatDKK(b.price_total)}</td>
      <td data-label="Status"><span class="badge badge-${escapeHtml(b.status)}">${escapeHtml(STATUS_LABELS[b.status] ?? b.status)}</span></td>
      <td data-label="Handlinger" class="actions">
        ${isActive
          ? `<button type="button" class="btn btn-secondary btn-small" data-action="edit" data-id="${escapeHtml(b.id)}">Redigér</button>
        <button type="button" class="btn btn-danger btn-small" data-action="cancel" data-id="${escapeHtml(b.id)}">Annullér</button>`
          : '<span class="cell-sub">Ingen handlinger</span>'}
      </td>
    </tr>`;
}

export function bookingRowsHtml(bookings) {
  if (!bookings.length) {
    return '<tr><td colspan="7" class="empty-row">Ingen bookinger matcher filteret.</td></tr>';
  }
  return bookings.map(bookingRowHtml).join('');
}

function readEditForm(form) {
  const data = new FormData(form);
  const get = (name) => String(data.get(name) ?? '');
  return {
    check_in: get('check_in'),
    check_out: get('check_out'),
    guests_count: get('guests_count'),
    name: get('name'),
    email: get('email'),
    phone: get('phone'),
    country_code: get('country_code'),
  };
}

export function initReception(root, { service }) {
  const filterForm = root.querySelector('[data-filters]');
  const tbody = root.querySelector('[data-bookings-body]');
  const count = root.querySelector('[data-bookings-count]');
  const listAlert = root.querySelector('[data-list-alert]');

  const editDialog = document.getElementById('edit-dialog');
  const editForm = editDialog.querySelector('form');
  const editAlert = editDialog.querySelector('[data-form-alert]');
  const editPrice = editDialog.querySelector('[data-edit-price]');
  const editSubmit = editForm.querySelector('[type="submit"]');

  const cancelDialog = document.getElementById('cancel-dialog');
  const cancelSummary = cancelDialog.querySelector('[data-cancel-summary]');
  const cancelAlert = cancelDialog.querySelector('[data-form-alert]');
  const cancelConfirm = cancelDialog.querySelector('[data-confirm-cancel]');

  let bookings = [];
  let editing = null;
  let cancelling = null;

  editForm.elements.country_code.innerHTML = countryOptionsHtml();

  function render() {
    const visible = filterBookings(bookings, { query: filterForm.elements.query.value });
    tbody.innerHTML = bookingRowsHtml(visible);
    count.textContent = pluralize(visible.length, 'booking', 'bookinger');
  }

  async function refresh() {
    listAlert.hidden = true;
    tbody.setAttribute('aria-busy', 'true');
    tbody.innerHTML = '<tr><td colspan="7" class="empty-row">Henter bookinger…</td></tr>';
    try {
      bookings = await service.listBookings({ status: filterForm.elements.status.value || undefined });
      render();
    } catch (error) {
      bookings = [];
      tbody.innerHTML = '';
      count.textContent = '';
      listAlert.textContent = error.message;
      listAlert.hidden = false;
    } finally {
      tbody.removeAttribute('aria-busy');
    }
  }

  function updatePricePreview() {
    if (!editing) return;
    const { check_in: checkIn, check_out: checkOut } = editForm.elements;
    const nights = nightsBetween(checkIn.value, checkOut.value);
    editPrice.textContent = nights
      ? `${pluralize(nights, 'nat', 'nætter')} × ${formatDKK(pricePerNight(editing))} = ${formatDKK(pricePerNight(editing) * nights)}`
      : 'Vælg gyldige datoer for at beregne prisen.';
  }

  function openEdit(booking) {
    editing = booking;
    const { elements } = editForm;
    elements.check_in.value = booking.check_in;
    elements.check_out.value = booking.check_out;
    elements.guests_count.value = booking.guests_count;
    elements.guests_count.max = booking.capacity ?? '';
    elements.name.value = booking.guest?.name ?? '';
    elements.email.value = booking.guest?.email ?? '';
    elements.phone.value = booking.guest?.phone ?? '';
    elements.country_code.value = booking.guest?.country_code ?? '';
    editDialog.querySelector('[data-edit-title]').textContent =
      `Redigér booking #${booking.id} · værelse ${booking.room_number}`;
    editAlert.hidden = true;
    showFieldErrors(editForm, {});
    updatePricePreview();
    editDialog.showModal();
  }

  function openCancel(booking) {
    cancelling = booking;
    cancelSummary.textContent =
      `#${booking.id} · ${booking.guest?.name ?? ''} · værelse ${booking.room_number} · ` +
      `${formatDate(booking.check_in)} – ${formatDate(booking.check_out)}`;
    cancelAlert.hidden = true;
    cancelDialog.showModal();
  }

  filterForm.addEventListener('submit', (event) => event.preventDefault());
  filterForm.elements.query.addEventListener('input', render);
  filterForm.elements.status.addEventListener('change', refresh);
  root.querySelector('[data-refresh]').addEventListener('click', refresh);

  tbody.addEventListener('click', (event) => {
    const button = event.target.closest('[data-action]');
    if (!button) return;
    const booking = bookings.find((b) => String(b.id) === button.dataset.id);
    if (!booking) return;
    if (button.dataset.action === 'edit') openEdit(booking);
    if (button.dataset.action === 'cancel') openCancel(booking);
  });

  editForm.addEventListener('input', updatePricePreview);
  editDialog.querySelectorAll('[data-close]').forEach((btn) =>
    btn.addEventListener('click', () => btn.closest('dialog').close()),
  );
  cancelDialog.querySelectorAll('[data-close]').forEach((btn) =>
    btn.addEventListener('click', () => btn.closest('dialog').close()),
  );

  editForm.addEventListener('submit', async (event) => {
    event.preventDefault();
    if (!editing) return;
    editAlert.hidden = true;

    const values = readEditForm(editForm);
    const stay = validateStay(values, { maxGuests: editing.capacity ?? undefined });
    const guest = validateGuest(values);
    const errors = { ...stay.errors, ...guest.errors };
    showFieldErrors(editForm, errors);
    if (!stay.valid || !guest.valid) return;

    setBusy(editSubmit, true, 'Gemmer…');
    try {
      const updated = await service.updateBooking(editing.id, buildUpdatePayload(editing, values));
      editDialog.close();
      notify(`Booking #${updated?.id ?? editing.id} er opdateret.`, 'success');
      await refresh();
    } catch (error) {
      showFieldErrors(editForm, error.fieldErrors ?? {});
      editAlert.textContent = error.message;
      editAlert.hidden = false;
    } finally {
      setBusy(editSubmit, false);
    }
  });

  cancelConfirm.addEventListener('click', async () => {
    if (!cancelling) return;
    setBusy(cancelConfirm, true, 'Annullerer…');
    try {
      await service.cancelBooking(cancelling.id);
      cancelDialog.close();
      notify(`Booking #${cancelling.id} er annulleret. Værelset er frigivet.`, 'success');
      await refresh();
    } catch (error) {
      cancelAlert.textContent = error.message;
      cancelAlert.hidden = false;
    } finally {
      setBusy(cancelConfirm, false);
    }
  });

  return { refresh };
}
