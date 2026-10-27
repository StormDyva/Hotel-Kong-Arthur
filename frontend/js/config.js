// Frontend-konfiguration for booking-UI'et.
//
// useMock: true  -> service-laget bruger mock-data i browseren (ingen backend).
// useMock: false -> service-laget kalder REST-API'et på apiBaseUrl.
//
// Værdierne kan overskrives uden at ændre denne fil ved at sætte
// window.HKA_CONFIG før main.js indlæses, eller med URL-parametrene
// ?mock=false&api=http://localhost:8000
const defaults = {
  useMock: true,
  apiBaseUrl: 'http://localhost:8000',
  mockLatencyMs: 250,
};

function readUrlOverrides() {
  if (typeof location === 'undefined') return {};
  const params = new URLSearchParams(location.search);
  const overrides = {};
  if (params.has('mock')) overrides.useMock = params.get('mock') !== 'false';
  if (params.has('api')) overrides.apiBaseUrl = params.get('api');
  return overrides;
}

export const config = Object.freeze({
  ...defaults,
  ...(globalThis.HKA_CONFIG ?? {}),
  ...readUrlOverrides(),
});
