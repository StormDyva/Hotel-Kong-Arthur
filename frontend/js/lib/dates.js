// Datohjælpere. Datoer håndteres som ISO 8601-kalenderdatoer (ÅÅÅÅ-MM-DD)
// og regnes i UTC, så sommertid ikke påvirker antal nætter.
const ISO_DATE = /^\d{4}-\d{2}-\d{2}$/;
const DAY_MS = 24 * 60 * 60 * 1000;

export function parseIsoDate(value) {
  if (typeof value !== 'string' || !ISO_DATE.test(value)) return null;
  const [year, month, day] = value.split('-').map(Number);
  const date = new Date(Date.UTC(year, month - 1, day));
  const isRealDate =
    date.getUTCFullYear() === year &&
    date.getUTCMonth() === month - 1 &&
    date.getUTCDate() === day;
  return isRealDate ? date : null;
}

export function toIsoDate(date) {
  return date.toISOString().slice(0, 10);
}

// Dagens dato i brugerens lokale tidszone (receptionen i København).
export function todayIso(now = new Date()) {
  const pad = (n) => String(n).padStart(2, '0');
  return `${now.getFullYear()}-${pad(now.getMonth() + 1)}-${pad(now.getDate())}`;
}

export function addDays(isoDate, days) {
  const date = parseIsoDate(isoDate);
  if (!date) return '';
  return toIsoDate(new Date(date.getTime() + days * DAY_MS));
}

// Check-out-dagen tæller ikke som en nat (C-005/C-011).
export function nightsBetween(checkIn, checkOut) {
  const start = parseIsoDate(checkIn);
  const end = parseIsoDate(checkOut);
  if (!start || !end) return 0;
  return Math.max(0, Math.round((end - start) / DAY_MS));
}
