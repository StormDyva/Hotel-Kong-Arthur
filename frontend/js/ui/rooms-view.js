// Trin 2: visning af ledige værelser med type, kapacitet og priser.
import { formatDate, formatDKK, escapeHtml, pluralize } from '../lib/format.js';
import { nightsBetween } from '../lib/dates.js';

export function roomCardHtml(room, nights) {
  const total = room.total_price ?? room.price_per_night * nights;
  return `
    <article class="room-card" data-room-id="${escapeHtml(room.room_id)}">
      <header class="room-card-head">
        <h3>${escapeHtml(room.room_type)}</h3>
        <p class="room-number">Værelse ${escapeHtml(room.room_number)}</p>
      </header>
      <dl class="room-facts">
        <div><dt>Kapacitet</dt><dd>${escapeHtml(pluralize(room.capacity, 'gæst', 'gæster'))}</dd></div>
        <div><dt>Pris pr. nat</dt><dd>${formatDKK(room.price_per_night)}</dd></div>
        <div class="room-total"><dt>I alt for ${escapeHtml(pluralize(nights, 'nat', 'nætter'))}</dt><dd>${formatDKK(total)}</dd></div>
      </dl>
      <button type="button" class="btn btn-primary" data-select-room="${escapeHtml(room.room_id)}">
        Vælg værelse ${escapeHtml(room.room_number)}
      </button>
    </article>`;
}

export function roomsListHtml(rooms, nights) {
  if (!rooms.length) {
    return `<p class="empty-state">Ingen ledige værelser matcher søgningen. Prøv andre datoer eller færre gæster.</p>`;
  }
  return rooms.map((room) => roomCardHtml(room, nights)).join('');
}

export function initRoomsView(section, { service, onSelect }) {
  const list = section.querySelector('[data-rooms-list]');
  const summary = section.querySelector('[data-rooms-summary]');
  let rooms = [];

  list.addEventListener('click', (event) => {
    const button = event.target.closest('[data-select-room]');
    if (!button) return;
    const room = rooms.find((r) => String(r.room_id) === button.dataset.selectRoom);
    if (room) onSelect(room);
  });

  return {
    async load(criteria) {
      section.hidden = false;
      rooms = [];
      const nights = nightsBetween(criteria.check_in, criteria.check_out);
      summary.textContent =
        `${formatDate(criteria.check_in)} – ${formatDate(criteria.check_out)} · ` +
        `${pluralize(nights, 'nat', 'nætter')} · ${pluralize(criteria.guests_count, 'gæst', 'gæster')}`;
      list.setAttribute('aria-busy', 'true');
      list.innerHTML = '<p class="loading">Søger efter ledige værelser…</p>';
      try {
        rooms = await service.searchAvailability(criteria);
        list.innerHTML = roomsListHtml(rooms, nights);
      } catch (error) {
        list.innerHTML = `<p class="alert alert-error">${escapeHtml(error.message)}</p>`;
      } finally {
        list.removeAttribute('aria-busy');
      }
    },
    hide() {
      section.hidden = true;
    },
  };
}
