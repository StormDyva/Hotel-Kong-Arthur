import { createAnalyticsService } from '../services/analytics-service.js';
import { config } from '../config.js';

const MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'Maj', 'Jun', 'Jul', 'Aug', 'Sep', 'Okt', 'Nov', 'Dec'];
const numberFormat = new Intl.NumberFormat('da-DK', { maximumFractionDigits: 0 });
const decimalFormat = new Intl.NumberFormat('da-DK', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
const moneyFormat = new Intl.NumberFormat('da-DK', { maximumFractionDigits: 0 });

const escapeHtml = (value) => String(value ?? '').replace(/[&<>"']/g, (char) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[char]));
const asNumber = (value) => Number(value ?? 0);
const formatDKK = (value) => `${moneyFormat.format(asNumber(value))} DKK`;
const formatPercent = (value) => `${decimalFormat.format(asNumber(value))}%`;
const formatMonth = (value) => MONTHS[Number(String(value).slice(5, 7)) - 1] ?? value;

function emptyState(message = 'Data ikke tilgængelig') {
  return `<div class="chart-empty"><span class="empty-icon" aria-hidden="true">—</span><span>${escapeHtml(message)}</span></div>`;
}

function horizontalBars(rows, { valueKey, labelKey = 'label', formatter, color = 'cyan', limit = 8, filterKey, filterParam = filterKey } = {}) {
  const data = [...(rows ?? [])].sort((a, b) => asNumber(b[valueKey]) - asNumber(a[valueKey])).slice(0, limit);
  if (!data.length) return emptyState();
  const max = Math.max(...data.map((row) => asNumber(row[valueKey])), 1);
  const width = 520;
  const rowHeight = 44;
  const height = data.length * rowHeight + 10;
  const bars = data.map((row, index) => {
    const y = index * rowHeight + 4;
    const label = String(row[labelKey] ?? '').replace(/\s+\/\s+/g, ' · ');
    const value = asNumber(row[valueKey]);
    const ratio = value / max;
    const tone = ratio >= 0.66 ? 'high' : ratio >= 0.33 ? 'medium' : 'low';
    const barWidth = Math.max(ratio * 300, 3);
    const filterValue = filterKey ? ` data-filter-key="${escapeHtml(filterParam)}" data-filter-value="${escapeHtml(row[filterKey])}" tabindex="0"` : '';
    return `<g class="bar-row"${filterValue} role="${filterKey ? 'button' : 'img'}"><text x="0" y="${y + 15}" class="chart-label">${escapeHtml(label.slice(0, 24))}</text><rect x="150" y="${y + 4}" width="${barWidth}" height="14" rx="3" class="bar-fill bar-${color} bar-tone-${tone}"/><text x="466" y="${y + 16}" text-anchor="end" class="chart-value">${escapeHtml(formatter(row[valueKey]))}</text></g>`;
  }).join('');
  return `<div class="chart-visual"><div class="chart-scale-key" aria-label="Farveskala: lav til høj værdi"><span><i class="scale-swatch scale-low"></i>Lav</span><span><i class="scale-swatch scale-medium"></i>Mellem</span><span><i class="scale-swatch scale-high"></i>Høj</span></div><svg class="data-chart" viewBox="0 0 ${width} ${height}" role="img" aria-label="${escapeHtml(data.map((row) => `${row[labelKey]} ${formatter(row[valueKey])}`).join(', '))}">${bars}</svg></div>`;
}

function monthlyRevparChart(monthly) {
  if (!monthly?.length) return emptyState('Månedlig RevPAR ikke tilgængelig');
  const width = 760;
  const height = 230;
  const pad = { top: 20, right: 16, bottom: 34, left: 44 };
  const values = monthly.map((row) => asNumber(row.revpar));
  const max = Math.max(...values, 1);
  const x = (index) => pad.left + (index * (width - pad.left - pad.right)) / Math.max(monthly.length - 1, 1);
  const y = (value) => height - pad.bottom - (value / max) * (height - pad.top - pad.bottom);
  const points = monthly.map((row, index) => `${x(index)},${y(asNumber(row.revpar))}`).join(' ');
  const dots = monthly.map((row, index) => `<circle cx="${x(index)}" cy="${y(asNumber(row.revpar))}" r="4" class="line-dot"><title>${escapeHtml(formatMonth(row.month))}: ${escapeHtml(formatDKK(row.revpar))}</title></circle>`).join('');
  const labels = monthly.map((row, index) => `<text x="${x(index)}" y="${height - 10}" text-anchor="middle" class="axis-label">${escapeHtml(formatMonth(row.month))}</text>`).join('');
  const grid = [0, 0.5, 1].map((ratio) => `<line x1="${pad.left}" y1="${y(max * ratio)}" x2="${width - pad.right}" y2="${y(max * ratio)}" class="chart-grid-line"/><text x="${pad.left - 8}" y="${y(max * ratio) + 4}" text-anchor="end" class="axis-label">${escapeHtml(formatDKK(max * ratio).replace(' DKK', ''))}</text>`).join('');
  return `<svg class="data-chart line-chart" viewBox="0 0 ${width} ${height}" role="img" aria-label="Månedlig RevPAR"><g>${grid}</g><polyline points="${points}" class="chart-line"/>${dots}${labels}</svg>`;
}

function donutChart(categories, totalRevenue) {
  const data = (categories ?? []).filter((row) => asNumber(row.percent) > 0);
  if (!data.length) return emptyState();
  const radius = 42;
  const circumference = 2 * Math.PI * radius;
  let offset = 0;
  const colors = { cocktail: 'var(--accent-cyan)', coffee: 'var(--accent-purple)' };
  const segments = data.map((row) => {
    const length = (asNumber(row.percent) / 100) * circumference;
    const segment = `<circle cx="64" cy="64" r="${radius}" class="donut-segment" stroke="${colors[row.category] ?? 'var(--accent-cyan)'}" stroke-dasharray="${length} ${circumference - length}" stroke-dashoffset="${-offset}"/>`;
    offset += length;
    return segment;
  }).join('');
  const legend = data.map((row) => `<span class="legend-item"><i style="background:${colors[row.category] ?? 'var(--accent-cyan)'}"></i>${escapeHtml(row.category === 'coffee' ? 'Kaffe' : 'Cocktails')} <strong>${escapeHtml(formatPercent(row.percent))}</strong></span>`).join('');
  return `<div class="donut-wrap"><svg class="donut-chart" viewBox="0 0 128 128" role="img" aria-label="Barsalg fordelt på kategori"><circle cx="64" cy="64" r="${radius}" class="donut-track"/>${segments}<text x="64" y="61" text-anchor="middle" class="donut-total">${escapeHtml(formatDKK(totalRevenue).replace(' DKK', ''))}</text><text x="64" y="76" text-anchor="middle" class="donut-label">omsætning</text></svg><div class="legend">${legend}</div></div>`;
}

function renderKpi(root, key, value, meta) {
  const card = root.querySelector(`[data-kpi="${key}"]`);
  if (!card) return;
  card.querySelector('.kpi-value').textContent = value;
  card.querySelector('.kpi-meta').textContent = meta;
}

function renderSatisfaction(container, satisfaction, warnings) {
  if (!satisfaction || satisfaction.average_rating === null || warnings?.some((warning) => warning.includes('guest ratings'))) {
    container.innerHTML = `<div class="unavailable-state"><strong>Data ikke tilgængelig</strong><span>Der er endnu ikke indsendt ratings for den valgte periode.</span></div>`;
    return;
  }
  container.innerHTML = `<div class="satisfaction-score"><strong>${escapeHtml(decimalFormat.format(asNumber(satisfaction.average_rating)))}</strong><span>/ 5</span></div><div class="satisfaction-meta">${escapeHtml(formatPercent(satisfaction.response_percent))} svarprocent · ${escapeHtml(numberFormat.format(satisfaction.rated_bookings))} svar</div>`;
}

function updateFilterChips(root, filters) {
  const chips = root.querySelector('[data-active-filters]');
  const labels = { country_code: 'Land', room_type_id: 'Værelse', season: 'Sæson', year: 'År' };
  const values = { ...filters };
  const active = Object.entries(values).filter(([, value]) => value).map(([key, value]) => `<span class="filter-chip">${escapeHtml(labels[key])}: ${escapeHtml(value)} </span>`).join('');
  chips.innerHTML = active || '<span class="filter-chip muted-chip">Alle data</span>';
}

function setPanelState(root, state) {
  root.querySelectorAll('.kpi-card').forEach((card) => card.classList.toggle('is-loading', state === 'loading'));
  root.classList.toggle('is-loading', state === 'loading');
}

export function initDashboard(root) {
  const service = createAnalyticsService({ baseUrl: config.apiBaseUrl });
  const form = root.querySelector('[data-dashboard-filters]');
  const error = root.querySelector('[data-dashboard-error]');
  let roomTypes = [];
  let countriesLoaded = false;
  let lastFilters = { year: '2026' };

  function readFilters() {
    return Object.fromEntries([...new FormData(form).entries()].filter(([, value]) => value));
  }

  function render(data, revpar) {
    const summary = data?.summary ?? {};
    renderKpi(root, 'occupancy', formatPercent(summary.occupancy_percent), 'Valgt periode');
    renderKpi(root, 'revenue', formatDKK(summary.revenue), 'Bekræftede ophold');
    renderKpi(root, 'room-nights', numberFormat.format(summary.room_nights ?? 0), 'Solgte nætter');
    renderKpi(root, 'revpar', formatDKK(summary.revpar), 'Omsætning / tilgængelig nat');
    renderKpi(root, 'bar', formatDKK(summary.bar_revenue), 'Aggregeret barsalg');
    root.querySelector('[data-room-chart]').innerHTML = horizontalBars(data.by_room_type, { valueKey: 'revenue', formatter: formatDKK, color: 'cyan' });
    root.querySelector('[data-season-chart]').innerHTML = horizontalBars(data.by_season, { valueKey: 'revenue', formatter: formatDKK, color: 'purple' });
    root.querySelector('[data-country-chart]').innerHTML = horizontalBars(data.by_country, { valueKey: 'revenue', formatter: formatDKK, color: 'cyan', limit: 7, filterKey: 'label', filterParam: 'country_code' });
    root.querySelector('[data-guest-chart]').innerHTML = horizontalBars(data.by_country, { valueKey: 'booking_guests', formatter: (value) => numberFormat.format(asNumber(value)), color: 'purple', limit: 7 });
    root.querySelector('[data-bar-category-chart]').innerHTML = donutChart(data.bar_categories, summary.bar_revenue);
    root.querySelector('[data-bar-product-chart]').innerHTML = horizontalBars(data.bar_products, { valueKey: 'revenue', labelKey: 'product', formatter: formatDKK, color: 'cyan', limit: 5 });
    renderSatisfaction(root.querySelector('[data-satisfaction]'), data.satisfaction, data.warnings);
    if (!countriesLoaded) {
      const select = form.elements.country_code;
      [...(data.by_country ?? [])].sort((a, b) => String(a.label).localeCompare(String(b.label))).forEach((row) => select.add(new Option(row.label, row.label)));
      countriesLoaded = true;
    }
    root.querySelector('[data-last-updated]').textContent = `Senest opdateret ${new Intl.DateTimeFormat('da-DK', { hour: '2-digit', minute: '2-digit' }).format(new Date(data.refreshed_at ?? data.generated_at))}`;
    root.querySelector('[data-dashboard-status]').classList.remove('is-error');
    error.hidden = true;
  }

  function focusPanel(selector) {
    if (!selector) return;
    const panel = root.querySelector(`[data-panel="${selector}"]`);
    panel?.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }

  async function refresh() {
    lastFilters = readFilters();
    updateFilterChips(root, lastFilters);
    setPanelState(root, 'loading');
    error.hidden = true;
    try {
      const data = await service.getDashboard(lastFilters);
      render(data);
    } catch (requestError) {
      root.querySelector('[data-last-updated]').textContent = 'Kunne ikke hente data';
      root.querySelector('[data-dashboard-status]').classList.add('is-error');
      error.textContent = requestError.message;
      error.hidden = false;
      root.querySelectorAll('.chart-stage').forEach((stage) => { stage.innerHTML = emptyState('Data kunne ikke hentes'); });
      root.querySelectorAll('.kpi-value').forEach((value) => { value.textContent = '—'; });
    } finally {
      setPanelState(root, 'ready');
    }
  }

  form.addEventListener('change', refresh);
  root.querySelector('[data-refresh-dashboard]').addEventListener('click', refresh);
  root.querySelector('[data-open-filters]')?.addEventListener('click', () => root.classList.add('filters-open'));
  root.querySelector('[data-reset-filters]').addEventListener('click', () => { form.reset(); refresh(); });
  root.querySelector('[data-close-filters]')?.addEventListener('click', () => root.classList.remove('filters-open'));

  root.querySelectorAll('[data-kpi]').forEach((card) => {
    card.tabIndex = 0;
    const focus = () => focusPanel({ revenue: 'room-revenue', 'room-nights': 'guest-country', bar: 'bar' }[card.dataset.kpi]);
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
  root.querySelector('[data-country-chart]').addEventListener('click', selectCountryFromChart);
  root.querySelector('[data-country-chart]').addEventListener('keydown', selectCountryFromChart);

  service.getRoomTypes().then((types) => {
    roomTypes = types;
    const select = form.elements.room_type_id;
    types.forEach((type) => select.add(new Option(type.name, type.id)));
  }).catch(() => { /* Filteret kan stadig bruges uden typekataloget. */ });

  return { refresh, openFilters: () => root.classList.add('filters-open'), getRoomTypes: () => roomTypes };
}

