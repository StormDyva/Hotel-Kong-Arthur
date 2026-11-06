// Analyseklient: dashboardet læser kun API-beregnede resultater.
import { ApiError } from './api-error.js';

const DASHBOARD_PATH = '/api/analytics/dashboard';
const REVPAR_PATH = '/api/analytics/revpar';
const ROOM_TYPES_PATH = '/api/room-types';
const AVERAGE_STAY_PATH = '/analytics/bookings/average-stay-length';

async function request(baseUrl, path, query = {}, fetchImpl = globalThis.fetch?.bind(globalThis)) {
  const url = new URL(path, baseUrl || globalThis.location?.origin);
  Object.entries(query).forEach(([key, value]) => {
    if (value !== undefined && value !== null && value !== '') url.searchParams.set(key, value);
  });

  let response;
  try {
    response = await fetchImpl(url, { headers: { Accept: 'application/json' } });
  } catch {
    throw new ApiError(0, 'NETWORK_ERROR', 'Kunne ikke hente analysedata. Kontrollér, at API’et kører.');
  }

  const data = await response.json().catch(() => null);
  if (!response.ok) {
    throw new ApiError(response.status, data?.error ?? 'HTTP_ERROR', data?.message ?? `Analyse-API’et svarede med HTTP ${response.status}.`, data?.details);
  }
  return data;
}

export function createAnalyticsService({ baseUrl, fetchImpl } = {}) {
  return {
    getDashboard: (filters) => request(baseUrl, DASHBOARD_PATH, filters, fetchImpl),
    getRevpar: (filters) => request(baseUrl, REVPAR_PATH, filters, fetchImpl),
    // ALOS-endpointet understøtter kun periode (year eller from/to), ikke hotelfiltre.
    getAverageStay: ({ year, from, to } = {}) => request(baseUrl, AVERAGE_STAY_PATH, { year, from, to }, fetchImpl),
    getRoomTypes: async () => {
      const data = await request(baseUrl, ROOM_TYPES_PATH, {}, fetchImpl);
      return Array.isArray(data) ? data : data?.items ?? [];
    },
  };
}

