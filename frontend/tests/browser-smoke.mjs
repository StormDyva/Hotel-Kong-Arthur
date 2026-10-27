// Browser-smoke-test af hele booking-flowet i headless Chrome (mock-tilstand).
// Kører ikke som en del af `npm test`, fordi den kræver Chrome.
//
//   npm run smoke
//   CHROME_PATH=/sti/til/chrome npm run smoke
//   SCREENSHOT_DIR=./screenshots npm run smoke   # gemmer skærmbilleder
import { spawn } from 'node:child_process';
import { mkdtempSync, mkdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { createServer } from 'node:http';
import { tmpdir } from 'node:os';
import { extname, join, normalize, resolve } from 'node:path';

const ROOT = resolve(import.meta.dirname, '..');
const CHROME =
  process.env.CHROME_PATH ??
  {
    darwin: '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',
    win32: 'C:/Program Files/Google/Chrome/Application/chrome.exe',
  }[process.platform] ??
  'google-chrome';
const SCREENSHOT_DIR = process.env.SCREENSHOT_DIR;
const PORT = Number(process.env.SMOKE_PORT ?? 5599);
const DEBUG_PORT = Number(process.env.SMOKE_DEBUG_PORT ?? 9333);

const TYPES = { '.html': 'text/html', '.js': 'text/javascript', '.css': 'text/css' };

function startServer() {
  const server = createServer((req, res) => {
    const path = normalize(new URL(req.url, 'http://x').pathname).replace(/^(\.\.[/\\])+/, '');
    const file = join(ROOT, path === '/' ? 'index.html' : path);
    let body;
    try {
      body = readFileSync(file);
    } catch {
      res.writeHead(404).end();
      return;
    }
    res.writeHead(200, { 'Content-Type': TYPES[extname(file)] ?? 'application/octet-stream' });
    res.end(body);
  });
  return new Promise((ok) => server.listen(PORT, '127.0.0.1', () => ok(server)));
}

async function connect(port) {
  for (let i = 0; i < 50; i++) {
    try {
      const targets = await (await fetch(`http://127.0.0.1:${port}/json/list`)).json();
      const page = targets.find((t) => t.type === 'page');
      if (page) {
        const ws = new WebSocket(page.webSocketDebuggerUrl);
        await new Promise((ok, fail) => {
          ws.onopen = ok;
          ws.onerror = fail;
        });
        return ws;
      }
    } catch {
      // Chrome er ikke klar endnu.
    }
    await new Promise((r) => setTimeout(r, 100));
  }
  throw new Error('Kunne ikke forbinde til Chrome DevTools.');
}

function cdp(ws) {
  let id = 0;
  const pending = new Map();
  const listeners = [];
  ws.onmessage = ({ data }) => {
    const msg = JSON.parse(data);
    if (msg.id && pending.has(msg.id)) {
      const { ok, fail } = pending.get(msg.id);
      pending.delete(msg.id);
      msg.error ? fail(new Error(msg.error.message)) : ok(msg.result);
    } else if (msg.method) {
      listeners.forEach((fn) => fn(msg));
    }
  };
  return {
    send: (method, params = {}) =>
      new Promise((ok, fail) => {
        pending.set(++id, { ok, fail });
        ws.send(JSON.stringify({ id, method, params }));
      }),
    on: (fn) => listeners.push(fn),
  };
}

// Kører i browseren. Returnerer en liste af { name, ok, detail }.
async function scenario() {
  const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
  const waitFor = async (fn, label, timeout = 4000) => {
    const start = Date.now();
    while (Date.now() - start < timeout) {
      const value = fn();
      if (value) return value;
      await sleep(25);
    }
    throw new Error(`Timeout: ${label}`);
  };
  const iso = (days) => new Date(Date.now() + days * 864e5).toISOString().slice(0, 10);
  const results = [];
  const check = (name, ok, detail = '') => {
    results.push({ name, ok: Boolean(ok), detail });
    console.info(`step: ${name}`);
  };
  const $ = (sel) => document.querySelector(sel);
  // checkVisibility() er false, hvis elementet eller en forfader er skjult.
  const visible = (el) => Boolean(el?.checkVisibility());
  const errorFor = (form, name) => form.querySelector(`[data-error-for="${name}"]`).textContent;

  try {
    await waitFor(() => $('#guest-country option'), 'app indlæst');
    const search = $('#search-form');
    const inDate = iso(30);
    const outDate = iso(33);

    search.elements.check_in.value = inDate;
    search.elements.check_out.value = inDate;
    search.elements.guests_count.value = '0';
    search.requestSubmit();
    check('check-out skal være efter check-in', errorFor(search, 'check_out') === 'Check-out skal være efter check-in.');
    check('antal gæster skal være større end nul', /større end nul/.test(errorFor(search, 'guests_count')));
    check('ugyldig søgning viser ingen værelser', $('#rooms').hidden);

    search.elements.check_out.value = outDate;
    search.elements.guests_count.value = '2';
    search.requestSubmit();
    await waitFor(() => document.querySelectorAll('.room-card').length, 'værelseskort');
    const cards = [...document.querySelectorAll('.room-card')];
    const card204 = cards.find((c) => c.dataset.roomId === '12');
    check('mock-ledige værelser vises', cards.length >= 1 && cards.every(visible), `${cards.length} værelser`);
    check(
      'værelsestype, kapacitet, pris pr. nat og samlet pris vises',
      card204 && /Standard dobbeltværelse/.test(card204.textContent) && /2 gæster/.test(card204.textContent) &&
        /1\.600/.test(card204.textContent) && /4\.800/.test(card204.textContent),
    );

    card204.querySelector('[data-select-room]').click();
    const guestForm = $('#guest-form');
    check('gæsteformular vises', visible(guestForm));
    guestForm.requestSubmit();
    const required = ['name', 'email', 'phone', 'country_code'].filter((f) => errorFor(guestForm, f));
    check('bookingformularen validerer nødvendige felter', required.length === 4, required.join(','));

    guestForm.elements.name.value = 'Smoke Test';
    guestForm.elements.email.value = 'smoke@example.com';
    guestForm.elements.phone.value = '+45 12 34 56 78';
    guestForm.elements.country_code.value = 'NO';
    guestForm.requestSubmit();
    await waitFor(() => !$('#confirmation').hidden, 'bekræftelse');
    const confirmationText = $('#confirmation').textContent;
    const id = confirmationText.match(/#(\d+)/)?.[1];
    check('mock-booking oprettes og bekræftes', visible($('#confirmation')) && id && /Bookingen er bekræftet/.test(confirmationText), `#${id}`);
    check('bekræftelse viser gæst og land', /Smoke Test/.test(confirmationText) && /Norge/.test(confirmationText));

    $('#tab-reception').click();
    const row = () => $(`tr[data-booking-id="${id}"]`);
    await waitFor(row, 'booking i oversigt');
    check('bookingen ses i receptionistens oversigt', visible(row()) && !visible($('#search-form')) && /Smoke Test/.test(row().textContent));

    row().querySelector('[data-action="edit"]').click();
    const editForm = $('#edit-dialog form');
    check('redigeringsdialog åbner', $('#edit-dialog').open);
    editForm.elements.check_out.value = editForm.elements.check_in.value;
    editForm.requestSubmit();
    check('redigering afviser ugyldige datoer', errorFor(editForm, 'check_out') === 'Check-out skal være efter check-in.');
    editForm.elements.check_out.value = iso(34);
    editForm.dispatchEvent(new Event('input'));
    check('ny pris beregnes live', /6\.400/.test($('[data-edit-price]').textContent));
    editForm.requestSubmit();
    await waitFor(() => !$('#edit-dialog').open && row() && /6\.400/.test(row().textContent), 'opdateret række');
    check('booking kan redigeres', /6\.400/.test(row().textContent));

    row().querySelector('[data-action="cancel"]').click();
    check('annulleringsdialog åbner', $('#cancel-dialog').open);
    $('[data-confirm-cancel]').click();
    await waitFor(() => row()?.classList.contains('is-cancelled'), 'annulleret række');
    check('booking kan annulleres', /Annulleret/.test(row().textContent) && !row().querySelector('[data-action]'));

    $('#tab-booking').click();
    search.requestSubmit();
    await waitFor(() => !$('[data-rooms-list]').hasAttribute('aria-busy') && $('.room-card'), 'ny søgning');
    check('annulleret værelse er ledigt igen', visible($('.room-card[data-room-id="12"]')));
  } catch (error) {
    check('scenariet gennemført uden fejl', false, error.message);
  }
  return results;
}

async function main() {
  const server = await startServer();
  const url = `http://127.0.0.1:${server.address().port}/`;
  const profile = mkdtempSync(join(tmpdir(), 'hka-smoke-'));
  const chrome = spawn(CHROME, [
    '--headless=new',
    '--disable-gpu',
    '--no-first-run',
    `--remote-debugging-port=${DEBUG_PORT}`,
    `--user-data-dir=${profile}`,
    url,
  ]);
  const consoleErrors = [];

  try {
    const client = cdp(await connect(DEBUG_PORT));
    client.on((msg) => {
      if (msg.method === 'Runtime.exceptionThrown') consoleErrors.push(msg.params.exceptionDetails.text);
      if (process.env.SMOKE_VERBOSE && msg.method === 'Runtime.consoleAPICalled') {
        console.log('[page]', msg.params.args.map((a) => a.value ?? a.description).join(' '));
      }
      if (msg.method === 'Runtime.consoleAPICalled' && msg.params.type === 'error') {
        consoleErrors.push(msg.params.args.map((a) => a.value ?? a.description).join(' '));
      }
    });
    await client.send('Runtime.enable');
    await client.send('Emulation.setDeviceMetricsOverride', { width: 1280, height: 900, deviceScaleFactor: 1, mobile: false });
    await client.send('Page.reload');
    await new Promise((r) => setTimeout(r, 500));

    const { result } = await client.send('Runtime.evaluate', {
      expression: `(${scenario.toString()})()`,
      awaitPromise: true,
      returnByValue: true,
    });
    const results = result.value;

    const shot = async (name) => {
      if (!SCREENSHOT_DIR) return;
      mkdirSync(SCREENSHOT_DIR, { recursive: true });
      const { data } = await client.send('Page.captureScreenshot', { captureBeyondViewport: true });
      writeFileSync(join(SCREENSHOT_DIR, name), Buffer.from(data, 'base64'));
    };
    await shot('desktop-booking.png');
    await client.send('Runtime.evaluate', { expression: "document.getElementById('tab-reception').click()" });
    await new Promise((r) => setTimeout(r, 600));
    await shot('desktop-reception.png');

    await client.send('Emulation.setDeviceMetricsOverride', { width: 390, height: 844, deviceScaleFactor: 2, mobile: true });
    await new Promise((r) => setTimeout(r, 300));
    const { result: width } = await client.send('Runtime.evaluate', {
      expression: 'document.documentElement.scrollWidth',
      returnByValue: true,
    });
    results.push({ name: 'ingen vandret scroll ved 390 px', ok: width.value <= 390, detail: `${width.value}px` });
    await shot('mobile-reception.png');

    results.push({ name: 'ingen JavaScript-fejl i konsollen', ok: consoleErrors.length === 0, detail: consoleErrors.join(' | ') });

    for (const r of results) console.log(`${r.ok ? '✔' : '✖'} ${r.name}${r.detail ? ` (${r.detail})` : ''}`);
    const failed = results.filter((r) => !r.ok).length;
    console.log(`\n${results.length - failed}/${results.length} browser-checks bestået`);
    process.exitCode = failed ? 1 : 0;
  } finally {
    const exited = new Promise((ok) => chrome.once('exit', ok));
    chrome.kill();
    await exited;
    server.close();
    rmSync(profile, { recursive: true, force: true, maxRetries: 5, retryDelay: 200 });
  }
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
