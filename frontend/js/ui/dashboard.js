import { createAnalyticsService } from '../services/analytics-service.js';
import { config } from '../config.js';
import {
  categoryDonut, countryName, emptyState, escapeHtml, formatCount, formatDKK,
  horizontalBars, roomTypeSeasonChart, seasonLabel,
} from './dashboard-charts.js';

const roomLabel = (row) => `Værelse ${row.label}`;
const countryLabel = (row) => countryName(row.label);

function renderKpi(root, key, value, meta) {
  const card = root.querySelector(`[data-kpi="${key}"]`);
  if (!card) return;
  card.querySelector('.kpi-value').textContent = value;
  card.querySelector('.kpi-meta').textContent = meta;
}

function updateFilterChips(root, filters, roomTypes) {
  const chips = root.querySelector('[data-active-filters]');
  const labels = { country_code: 'Land', room_type_id: 'Værelsestype', season: 'Sæson', year: 'År' };
  const display = {
    country_code: countryName,
    season: seasonLabel,
    room_type_id: (id) => roomTypes.find((type) => String(type.id) === String(id))?.name ?? id,
  };
  const active = Object.entries(filters).filter(([, value]) => value)
    .map(([key, value]) => `<span class="filter-chip">${escapeHtml(labels[key] ?? key)}: ${escapeHtml((display[key] ?? String)(value))}</span>`).join('');
  chips.innerHTML = active || '<span class="filter-chip muted-chip">Alle data</span>';
}

/** Skriver API-resultatet ind i analysefanens paneler. */
export function renderDashboard(root, data) {
  const summary = data?.summary ?? {};
  const year = String(data?.from_date ?? '').slice(0, 4);
  const employee = data?.employee_name ?? 'Helene Christine';

  renderKpi(root, 'revenue', formatDKK(summary.revenue), `Hotellets værelsesindtjening ${year}`.trim());
  renderKpi(root, 'top-room', data?.top_room ? roomLabel(data.top_room) : '—',
    data?.top_room ? `${formatDKK(data.top_room.revenue)} · ${formatCount(data.top_room.room_nights)} nætter` : 'Ingen ophold');
  renderKpi(root, 'top-country', data?.top_country ? countryLabel(data.top_country) : '—',
    data?.top_country ? `${formatDKK(data.top_country.revenue)} · ${formatCount(data.top_country.bookings)} bookinger` : 'Ingen ophold');
  renderKpi(root, 'adr', formatDKK(summary.adr), `Gns. pris pr. solgt nat · ${formatCount(summary.room_nights)} nætter`);
  renderKpi(root, 'bar', formatDKK(summary.bar_revenue), `${employee} · ${year}`.trim());
  root.querySelectorAll('[data-employee-name]').forEach((node) => { node.textContent = employee; });

  root.querySelector('[data-guest-country-chart]').innerHTML = horizontalBars(data.by_country, {
    valueKey: 'booking_guests', label: countryLabel, formatter: (value) => `${formatCount(value)} gæster`,
    color: 'dark', limit: Infinity, compact: true,
  });
  root.querySelector('[data-country-chart]').innerHTML = horizontalBars(data.by_country, {
    valueKey: 'revenue', label: countryLabel, color: 'gold', limit: Infinity, compact: true,
    filterKey: 'label', filterParam: 'country_code', rank: true,
  });
  root.querySelector('[data-room-type-chart]').innerHTML = horizontalBars(data.by_room_type, {
    valueKey: 'revenue', color: 'gold', limit: Infinity, rank: true,
  });
  root.querySelector('[data-room-type-season-chart]').innerHTML = roomTypeSeasonChart(data.by_room_type_season, data.by_room_type);
  root.querySelector('[data-top-rooms-chart]').innerHTML = horizontalBars(data.by_room, {
    valueKey: 'revenue', label: roomLabel, color: 'gold', limit: 10, rank: true,
  });
  root.querySelector('[data-bar-category-chart]').innerHTML = categoryDonut(data.bar_categories, summary.bar_revenue);
  root.querySelector('[data-drink-chart]').innerHTML = horizontalBars(data.bar_products, {
    valueKey: 'revenue', labelKey: 'product', limit: Infinity, compact: true, rank: true,
    colorFor: (row) => (row.category === 'coffee' ? 'coffee' : 'cocktail'),
  });
}

export function initDashboard(root) {
  const service = createAnalyticsService({ baseUrl: config.apiBaseUrl });
  const form = root.querySelector('[data-dashboard-filters]');
  const error = root.querySelector('[data-dashboard-error]');
  let roomTypes = [];
  let countriesLoaded = false;

  const readFilters = () => Object.fromEntries([...new FormData(form).entries()].filter(([, value]) => value));

  function render(data) {
    renderDashboard(root, data);
    if (!countriesLoaded) {
      const select = form.elements.country_code;
      [...(data.by_country ?? [])].map((row) => [row.label, countryName(row.label)])
        .sort(([, a], [, b]) => a.localeCompare(b, 'da'))
        .forEach(([code, name]) => select.add(new Option(name, code)));
      countriesLoaded = true;
    }
    root.querySelector('[data-last-updated]').textContent = `Senest opdateret ${new Intl.DateTimeFormat('da-DK', { hour: '2-digit', minute: '2-digit' }).format(new Date(data.refreshed_at ?? data.generated_at))}`;
    root.querySelector('[data-dashboard-status]').classList.remove('is-error');
    error.hidden = true;
  }

  async function refresh() {
    const filters = readFilters();
    updateFilterChips(root, filters, roomTypes);
    root.classList.add('is-loading');
    error.hidden = true;
    try {
      render(await service.getDashboard(filters));
    } catch (requestError) {
      root.querySelector('[data-last-updated]').textContent = 'Kunne ikke hente data';
      root.querySelector('[data-dashboard-status]').classList.add('is-error');
      error.textContent = requestError.message;
      error.hidden = false;
      root.querySelectorAll('.chart-stage').forEach((stage) => { stage.innerHTML = emptyState('Data kunne ikke hentes'); });
      root.querySelectorAll('.kpi-value').forEach((value) => { value.textContent = '—'; });
    } finally {
      root.classList.remove('is-loading');
    }
  }

  form.addEventListener('change', refresh);
  root.querySelector('[data-refresh-dashboard]').addEventListener('click', refresh);
  root.querySelector('[data-open-filters]')?.addEventListener('click', () => root.classList.add('filters-open'));
  root.querySelector('[data-reset-filters]').addEventListener('click', () => { form.reset(); refresh(); });
  root.querySelector('[data-close-filters]')?.addEventListener('click', () => root.classList.remove('filters-open'));

  const panelForKpi = { revenue: 'room-type', 'top-room': 'top-rooms', 'top-country': 'country-revenue', adr: 'room-type', bar: 'bar' };
  root.querySelectorAll('[data-kpi]').forEach((card) => {
    card.tabIndex = 0;
    const focus = () => root.querySelector(`[data-panel="${panelForKpi[card.dataset.kpi]}"]`)?.scrollIntoView({ behavior: 'smooth', block: 'start' });
    card.addEventListener('click', focus);
    card.addEventListener('keydown', (event) => { if (event.key === 'Enter' || event.key === ' ') { event.preventDefault(); focus(); } });
  });

  const selectCountryFromChart = (event) => {
    const row = event.target.closest('[data-filter-key="country_code"]');
    if (!row) return;
    if (event.type === 'keydown' && event.key !== 'Enter' && event.key !== ' ') return;
    if (event.type === 'keydown') event.preventDefault();
    form.elements.country_code.value = row.dataset.filterValue;
    refresh();
  };
  const countryChart = root.querySelector('[data-country-chart]');
  countryChart.addEventListener('click', selectCountryFromChart);
  countryChart.addEventListener('keydown', selectCountryFromChart);

  service.getRoomTypes().then((types) => {
    roomTypes = types;
    types.forEach((type) => form.elements.room_type_id.add(new Option(type.name, type.id)));
  }).catch(() => { /* Filteret kan stadig bruges uden typekataloget. */ });

  return { refresh, openFilters: () => root.classList.add('filters-open'), getRoomTypes: () => roomTypes };
}
