// Rene HTML/SVG-byggere til analysefanen. Alle tal kommer færdigberegnet fra
// GET /api/analytics/dashboard; her formateres, sorteres og tegnes de kun.

const decimalFormat = new Intl.NumberFormat('da-DK', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
const integerFormat = new Intl.NumberFormat('da-DK', { maximumFractionDigits: 0 });
const regionNames = typeof Intl.DisplayNames === 'function' ? new Intl.DisplayNames(['da'], { type: 'region' }) : null;

export const SEASONS = [
  { code: 'low', label: 'Lavsæson' },
  { code: 'mid', label: 'Mellemsæson' },
  { code: 'high', label: 'Højsæson' },
];
const SEASON_LABELS = Object.fromEntries(SEASONS.map(({ code, label }) => [code, label]));
const CATEGORY_LABELS = { cocktail: 'Cocktails', coffee: 'Kaffe' };

export const escapeHtml = (value) => String(value ?? '').replace(/[&<>"']/g, (char) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[char]));
export const asNumber = (value) => Number(value ?? 0);
export const formatDKK = (value) => `${integerFormat.format(asNumber(value))} DKK`;
export const formatCount = (value) => integerFormat.format(asNumber(value));
export const formatPercent = (value) => `${decimalFormat.format(asNumber(value))}%`;
export const seasonLabel = (code) => SEASON_LABELS[code] ?? code;
export const categoryLabel = (code) => CATEGORY_LABELS[code] ?? code;

export function countryName(code) {
  if (!code) return '';
  try {
    const name = regionNames?.of(String(code).toUpperCase());
    return name && name !== code ? `${name} (${code})` : String(code);
  } catch {
    return String(code);
  }
}

export function emptyState(message = 'Data ikke tilgængelig') {
  return `<div class="chart-empty"><span class="empty-icon" aria-hidden="true">—</span><span>${escapeHtml(message)}</span></div>`;
}

/**
 * Vandrette bjælker som HTML (teksten skaleres ikke ned på mobil). `rows`
 * sorteres efter `valueKey` (højeste først) og begrænses til `limit` (Infinity = alle).
 */
export function horizontalBars(rows, {
  valueKey, labelKey = 'label', label = (row) => row[labelKey], formatter = formatDKK,
  color = 'gold', colorFor, limit = 8, filterKey, filterParam = filterKey, rank = false, compact = false,
} = {}) {
  const data = [...(rows ?? [])].sort((a, b) => asNumber(b[valueKey]) - asNumber(a[valueKey])).slice(0, limit);
  if (!data.length) return emptyState();
  const max = Math.max(...data.map((row) => asNumber(row[valueKey])), 1);
  const items = data.map((row, index) => {
    const text = `${rank ? `${index + 1}. ` : ''}${String(label(row) ?? '').replace(/\s+\/\s+/g, ' · ')}`;
    const value = asNumber(row[valueKey]);
    const ratio = value / max;
    const tone = ratio >= 0.66 ? 'high' : ratio >= 0.33 ? 'medium' : 'low';
    const barColor = colorFor ? colorFor(row) : color;
    const filterAttrs = filterKey ? ` data-filter-key="${escapeHtml(filterParam)}" data-filter-value="${escapeHtml(row[filterKey])}" tabindex="0" role="button"` : '';
    return `<li class="bar-row"${filterAttrs} title="${escapeHtml(text)}: ${escapeHtml(formatter(value))}">`
      + `<span class="bar-label">${escapeHtml(text)}</span>`
      + `<span class="bar-track"><span class="bar-fill bar-${barColor} bar-tone-${tone}" style="width:${Math.max(ratio * 100, 1).toFixed(2)}%"></span></span>`
      + `<span class="bar-value">${escapeHtml(formatter(value))}</span></li>`;
  }).join('');
  return `<ol class="bar-list${compact ? ' bar-list-compact' : ''}">${items}</ol>`;
}

/**
 * Indtjening pr. værelsestype opdelt på sæson. `roomTypeOrder` er backendens
 * `by_room_type` (sorteret efter omsætning), `rows` er `by_room_type_season`
 * med labels på formen "<værelsestype> / <sæsonkode>".
 */
export function roomTypeSeasonChart(rows, roomTypeOrder = []) {
  const cells = new Map();
  for (const row of rows ?? []) {
    const [roomType, season] = String(row.label).split(' / ');
    if (!cells.has(roomType)) cells.set(roomType, {});
    cells.get(roomType)[season] = row;
  }
  if (!cells.size) return emptyState();
  const ordered = [...roomTypeOrder.map((row) => row.label).filter((name) => cells.has(name)),
    ...[...cells.keys()].filter((name) => !roomTypeOrder.some((row) => row.label === name))];
  const max = Math.max(...(rows ?? []).map((row) => asNumber(row.revenue)), 1);
  const groups = ordered.map((roomType) => {
    const bars = SEASONS.map(({ code, label }) => {
      const value = asNumber(cells.get(roomType)[code]?.revenue);
      return `<li class="season-row" title="${escapeHtml(roomType)} · ${escapeHtml(label)}: ${escapeHtml(formatDKK(value))}">`
        + `<span class="bar-track"><span class="season-fill season-${code}" style="width:${((value / max) * 100).toFixed(2)}%"></span></span>`
        + `<span class="bar-value">${escapeHtml(formatDKK(value))}</span></li>`;
    }).join('');
    return `<li class="season-group"><span class="bar-label">${escapeHtml(roomType)}</span><ul class="season-bars">${bars}</ul></li>`;
  }).join('');
  const legend = SEASONS.map(({ code, label }) => `<span><i class="scale-swatch season-${code}"></i>${escapeHtml(label)}</span>`).join('');
  return `<div class="chart-visual"><div class="chart-scale-key">${legend}</div><ol class="season-list" aria-label="Indtjening pr. værelsestype og sæson">${groups}</ol></div>`;
}

/** Donut med cocktail/kaffe-fordelingen. Procenterne er beregnet i backend. */
export function categoryDonut(categories, totalRevenue) {
  const data = (categories ?? []).filter((row) => asNumber(row.percent) > 0);
  if (!data.length) return emptyState('Ingen barsalg i perioden');
  const radius = 42;
  const circumference = 2 * Math.PI * radius;
  const colors = { cocktail: 'var(--chart-cocktail)', coffee: 'var(--chart-coffee)' };
  let offset = 0;
  const segments = data.map((row) => {
    const length = (asNumber(row.percent) / 100) * circumference;
    const segment = `<circle cx="64" cy="64" r="${radius}" class="donut-segment" stroke="${colors[row.category] ?? 'var(--chart-cocktail)'}" stroke-dasharray="${length} ${circumference - length}" stroke-dashoffset="${-offset}"><title>${escapeHtml(categoryLabel(row.category))}: ${escapeHtml(formatPercent(row.percent))}</title></circle>`;
    offset += length;
    return segment;
  }).join('');
  const legend = data.map((row) => `<span class="legend-item"><i style="background:${colors[row.category] ?? 'var(--chart-cocktail)'}"></i>${escapeHtml(categoryLabel(row.category))} <strong>${escapeHtml(formatPercent(row.percent))}</strong><small>${escapeHtml(formatDKK(row.revenue))}</small></span>`).join('');
  return `<div class="donut-wrap"><svg class="donut-chart" viewBox="0 0 128 128" role="img" aria-label="Barsalg fordelt på cocktails og kaffe"><circle cx="64" cy="64" r="${radius}" class="donut-track"/>${segments}`
    + `<text x="64" y="61" text-anchor="middle" class="donut-total">${escapeHtml(formatDKK(totalRevenue).replace(' DKK', ''))}</text><text x="64" y="76" text-anchor="middle" class="donut-label">DKK i alt</text></svg><div class="legend">${legend}</div></div>`;
}
