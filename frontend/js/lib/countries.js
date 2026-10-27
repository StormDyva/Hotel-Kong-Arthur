// Lande til gæsteformularen (ISO 3166-1 alpha-2, svarer til guests.country_code).
export const COUNTRIES = [
  { code: 'DK', name: 'Danmark' },
  { code: 'SE', name: 'Sverige' },
  { code: 'NO', name: 'Norge' },
  { code: 'FI', name: 'Finland' },
  { code: 'IS', name: 'Island' },
  { code: 'DE', name: 'Tyskland' },
  { code: 'NL', name: 'Holland' },
  { code: 'BE', name: 'Belgien' },
  { code: 'FR', name: 'Frankrig' },
  { code: 'ES', name: 'Spanien' },
  { code: 'IT', name: 'Italien' },
  { code: 'PL', name: 'Polen' },
  { code: 'AT', name: 'Østrig' },
  { code: 'CH', name: 'Schweiz' },
  { code: 'GB', name: 'Storbritannien' },
  { code: 'IE', name: 'Irland' },
  { code: 'US', name: 'USA' },
  { code: 'CA', name: 'Canada' },
  { code: 'AU', name: 'Australien' },
  { code: 'CN', name: 'Kina' },
  { code: 'JP', name: 'Japan' },
  { code: 'IN', name: 'Indien' },
];

export function countryName(code) {
  return COUNTRIES.find((c) => c.code === code)?.name ?? code ?? '';
}

export function countryOptionsHtml(selected = '') {
  const placeholder = `<option value=""${selected ? '' : ' selected'}>Vælg land</option>`;
  return (
    placeholder +
    COUNTRIES.map(
      (c) => `<option value="${c.code}"${c.code === selected ? ' selected' : ''}>${c.name}</option>`,
    ).join('')
  );
}
