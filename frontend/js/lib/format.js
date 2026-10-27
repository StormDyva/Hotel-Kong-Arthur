// Formatering til visning. Valuta er altid DKK (C-007).
import { parseIsoDate } from './dates.js';

const dkk = new Intl.NumberFormat('da-DK', {
  style: 'currency',
  currency: 'DKK',
  maximumFractionDigits: 0,
});

const longDate = new Intl.DateTimeFormat('da-DK', {
  weekday: 'short',
  day: 'numeric',
  month: 'short',
  year: 'numeric',
  timeZone: 'UTC',
});

export function formatDKK(amount) {
  return dkk.format(Number(amount) || 0);
}

export function formatDate(isoDate) {
  const date = parseIsoDate(isoDate);
  return date ? longDate.format(date) : String(isoDate ?? '');
}

export function pluralize(count, singular, plural) {
  return `${count} ${count === 1 ? singular : plural}`;
}

const HTML_ESCAPES = { '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' };

// Alle værdier, der indsættes i HTML-skabeloner, skal escapes.
export function escapeHtml(value) {
  return String(value ?? '').replace(/[&<>"']/g, (ch) => HTML_ESCAPES[ch]);
}
