// Tester analysefanens grafbyggere med API-formede data (ingen KPI-beregning i frontend).
import assert from 'node:assert/strict';
import { describe, test } from 'node:test';

import { categoryDonut, countryName, horizontalBars, roomTypeSeasonChart } from '../js/ui/dashboard-charts.js';

const text = (html) => html.replace(/ | /g, ' ');

describe('analysefanens grafer', () => {
  test('vandrette bjælker sorterer højeste først, nummererer og respekterer limit', () => {
    const rows = [
      { label: 'A', revenue: '100.00' },
      { label: 'B', revenue: '300.00' },
      { label: 'C', revenue: '200.00' },
    ];
    const html = text(horizontalBars(rows, { valueKey: 'revenue', limit: 2, rank: true }));
    assert.ok(html.indexOf('1. B') < html.indexOf('2. C'));
    assert.ok(!html.includes('>3. A<'));
    assert.match(html, /300 DKK/);
  });

  test('landebjælker bærer filterværdien til klik-filtrering', () => {
    const html = horizontalBars([{ label: 'DK', revenue: '10' }], {
      valueKey: 'revenue', label: (row) => countryName(row.label), filterKey: 'label', filterParam: 'country_code',
    });
    assert.match(html, /data-filter-key="country_code" data-filter-value="DK"/);
    assert.match(html, /Danmark \(DK\)/);
  });

  test('værelsestype × sæson følger backendens rækkefølge og viser alle tre sæsoner', () => {
    const html = text(roomTypeSeasonChart([
      { label: 'Standard / high', revenue: '50' },
      { label: 'Suite / low', revenue: '20' },
      { label: 'Suite / high', revenue: '80' },
    ], [{ label: 'Suite' }, { label: 'Standard' }]));
    assert.ok(html.indexOf('>Suite<') < html.indexOf('>Standard<'));
    assert.match(html, /Suite · Mellemsæson: 0 DKK/);
    assert.match(html, /Suite · Højsæson: 80 DKK/);
    assert.match(html, /Lavsæson.*Mellemsæson.*Højsæson/);
  });

  test('donut viser backendens procentfordeling og total', () => {
    const html = text(categoryDonut([
      { category: 'cocktail', revenue: '600', percent: '60.00' },
      { category: 'coffee', revenue: '400', percent: '40.00' },
    ], '1000'));
    assert.match(html, /Cocktails <strong>60,00%<\/strong>/);
    assert.match(html, /Kaffe <strong>40,00%<\/strong>/);
    assert.match(html, />1\.000</);
  });

  test('tomme data giver en tom-tilstand i stedet for en tom graf', () => {
    assert.match(horizontalBars([], { valueKey: 'revenue' }), /Data ikke tilgængelig/);
    assert.match(roomTypeSeasonChart([], []), /Data ikke tilgængelig/);
    assert.match(categoryDonut([], 0), /Ingen barsalg/);
  });
});
