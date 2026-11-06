import assert from 'node:assert/strict';
import { describe, test } from 'node:test';

import { ApiError } from '../js/services/api-error.js';
import { createAnalyticsService } from '../js/services/analytics-service.js';

function fakeFetch(responses = []) {
  const calls = [];
  const fetchImpl = async (url) => {
    calls.push(String(url));
    const next = responses.shift() ?? { status: 200, body: {} };
    if (next.throws) throw new TypeError('Failed to fetch');
    return {
      ok: next.status >= 200 && next.status < 300,
      status: next.status,
      json: async () => next.body,
    };
  };
  return { calls, fetchImpl };
}

describe('analyse-service', () => {
  test('henter dashboard, RevPAR og værelsestyper fra API-kontrakten', async () => {
    const fake = fakeFetch([
      { status: 200, body: { summary: { revenue: '100.00' } } },
      { status: 200, body: { data: { monthly: [] } } },
      { status: 200, body: [{ id: 1, name: 'Suite' }] },
    ]);
    const service = createAnalyticsService({ baseUrl: 'http://api.test', fetchImpl: fake.fetchImpl });

    // The production client uses global fetch; this test supplies a scoped fetch seam.
    // eslint-free replacement keeps the request contract testable in this vanilla app.
    // @ts-ignore — injected for the test only
    const requestService = service;
    assert.deepEqual(await requestService.getDashboard({ year: '2026', season: '' }), { summary: { revenue: '100.00' } });
    assert.deepEqual(await requestService.getRevpar({ year: '2026' }), { data: { monthly: [] } });
    assert.deepEqual(await requestService.getRoomTypes(), [{ id: 1, name: 'Suite' }]);
    assert.deepEqual(fake.calls, [
      'http://api.test/api/analytics/dashboard?year=2026',
      'http://api.test/api/analytics/revpar?year=2026',
      'http://api.test/api/room-types',
    ]);
  });

  test('ALOS sender kun periodeparametre, ikke hotelfiltre', async () => {
    const fake = fakeFetch([{ status: 200, body: { summary: { average_stay_nights: 5.15 } } }]);
    const service = createAnalyticsService({ baseUrl: 'http://api.test', fetchImpl: fake.fetchImpl });
    await service.getAverageStay({ year: '2026', country_code: 'DK', season: 'high' });
    assert.deepEqual(fake.calls, ['http://api.test/analytics/bookings/average-stay-length?year=2026']);
  });

  test('bevarer API-fejl som ApiError', async () => {
    const fake = fakeFetch([{ status: 503, body: { error: 'UNAVAILABLE', message: 'API nede' } }]);
    const service = createAnalyticsService({ baseUrl: 'http://api.test', fetchImpl: fake.fetchImpl });
    await assert.rejects(service.getDashboard({ year: '2026' }), (error) => {
      assert.ok(error instanceof ApiError);
      assert.equal(error.status, 503);
      assert.equal(error.message, 'API nede');
      return true;
    });
  });
});

