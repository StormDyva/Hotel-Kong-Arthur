// Service-lag mellem UI og backend. UI'et kalder kun disse funktioner og
// kender hverken HTTP eller mock-data. Frontend forbinder aldrig direkte
// til MySQL; al dataadgang går via REST-API'et.
import { config } from '../config.js';
import { ApiError } from './api-error.js';
import { createMockApi } from './mock-api.js';

export const ENDPOINTS = Object.freeze({
  availability: '/api/rooms/availability',
  bookings: '/api/bookings',
  booking: (id) => `/api/bookings/${encodeURIComponent(id)}`,
});

export function createHttpApi({ baseUrl, fetchImpl = globalThis.fetch?.bind(globalThis) }) {
  async function request(method, path, { query, body } = {}) {
    const url = new URL(path, baseUrl || globalThis.location?.origin);
    Object.entries(query ?? {}).forEach(([key, value]) => {
      if (value !== undefined && value !== null && value !== '') url.searchParams.set(key, value);
    });

    let response;
    try {
      response = await fetchImpl(url.toString(), {
        method,
        headers: {
          Accept: 'application/json',
          ...(body ? { 'Content-Type': 'application/json' } : {}),
        },
        body: body ? JSON.stringify(body) : undefined,
      });
    } catch {
      throw new ApiError(0, 'NETWORK_ERROR', 'Kunne ikke kontakte API’et. Kontrollér, at backend kører.');
    }

    if (response.status === 204) return null;
    const data = await response.json().catch(() => null);
    if (!response.ok) {
      throw new ApiError(
        response.status,
        data?.error ?? 'HTTP_ERROR',
        data?.message ?? `Uventet svar fra API’et (HTTP ${response.status}).`,
        data?.details,
      );
    }
    return data;
  }

  return {
    searchAvailability: (criteria) => request('GET', ENDPOINTS.availability, { query: criteria }),
    listBookings: (filters) => request('GET', ENDPOINTS.bookings, { query: filters }),
    createBooking: (payload) => request('POST', ENDPOINTS.bookings, { body: payload }),
    updateBooking: (id, payload) => request('PUT', ENDPOINTS.booking(id), { body: payload }),
    cancelBooking: (id) => request('DELETE', ENDPOINTS.booking(id)),
  };
}

// Lister kan komme som et array eller som et pagineret objekt { items: [...] }.
const asList = (data) => (Array.isArray(data) ? data : data?.items ?? []);

export function createBookingService({ useMock, apiBaseUrl, mockLatencyMs, fetchImpl, mockApi } = {}) {
  const api = useMock
    ? mockApi ?? createMockApi({ latencyMs: mockLatencyMs })
    : createHttpApi({ baseUrl: apiBaseUrl, fetchImpl });

  return {
    mode: useMock ? 'mock' : 'api',
    async searchAvailability(criteria) {
      return asList(await api.searchAvailability(criteria));
    },
    async listBookings(filters = {}) {
      return asList(await api.listBookings(filters));
    },
    createBooking: (payload) => api.createBooking(payload),
    updateBooking: (id, payload) => api.updateBooking(id, payload),
    cancelBooking: (id) => api.cancelBooking(id),
  };
}

export const bookingService = createBookingService(config);
