import { spawn } from 'node:child_process';
import { mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
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


const base=process.env.BOOKING_BASE_URL ?? 'http://localhost:5500';
const profile=mkdtempSync(join(tmpdir(),'hka-live-booking-'));
const port=9455;
const chrome=spawn(process.env.CHROME_PATH ?? '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',[
 '--headless=new','--disable-gpu','--no-first-run',`--remote-debugging-port=${port}`,
 `--user-data-dir=${profile}`,'about:blank']);
let bookingId;
try {
 const client=cdp(await connect(port));
 await client.send('Page.enable');
 await client.send('Emulation.setDeviceMetricsOverride',{width:1280,height:900,deviceScaleFactor:1,mobile:false});
 await client.send('Runtime.enable');
 await client.send('Page.navigate',{url:base});
 for(let i=0;i<100;i++){
  try { const r=await client.send('Runtime.evaluate',{expression:"!!document.querySelector('#guest-country option')",returnByValue:true});if(r.result?.value)break; }catch{}
  await new Promise(r=>setTimeout(r,100));
 }
 const {result,exceptionDetails}=await client.send('Runtime.evaluate',{
 expression:`(async()=>{
  const wait=async(f)=>{for(let i=0;i<150;i++){if(f())return;await new Promise(r=>setTimeout(r,100));}throw new Error('Booking UI timeout: '+document.body.innerText.slice(-1500));};
  if(!document.querySelector('#mode-banner').hidden)throw new Error('Expected real API mode');
  const form=document.querySelector('#search-form');
  form.elements.check_in.value='2048-03-31';form.elements.check_out.value='2048-04-02';form.elements.guests_count.value='1';form.requestSubmit();
  await wait(()=>document.querySelector('[data-select-room]'));
  if(document.querySelectorAll('.room-card').length!==8)throw new Error('Expected one proposal for each type');
  document.querySelector('[data-select-room]').click();
  const guest=document.querySelector('#guest-form');
  guest.elements.name.value='Prototype Browser Test';guest.elements.email.value='prototype@example.com';guest.elements.phone.value='+4512345678';guest.elements.country_code.value='DK';
  guest.elements.email.value='a@a..com'; guest.requestSubmit();
  await wait(()=>guest.querySelector('[data-error-for="email"]').textContent);
  guest.elements.email.value='prototype@example.com'; guest.requestSubmit();
  await wait(()=>!document.querySelector('#confirmation').hidden);
  const text=document.querySelector('[data-confirmation]').innerText;
  const id=Number(document.querySelector('#confirmation .alert strong').textContent.replace('#',''));
  document.querySelector('[data-show-bookings]').click();
  await wait(()=>document.querySelector('tr[data-booking-id="'+id+'"]'));
  return {id,confirmation:text};
 })()`,awaitPromise:true,returnByValue:true});
 if(exceptionDetails)throw new Error(JSON.stringify(exceptionDetails));
 bookingId=result.value.id;
 const b=await (await fetch(base+'/api/bookings/'+bookingId)).json();
 if(b.guest.email!=='prototype@example.com'||Number(b.price_total)!==2000)throw new Error(JSON.stringify(b));
 await client.send('Page.reload');
 await new Promise(r=>setTimeout(r,500));
 const reloaded=await client.send('Runtime.evaluate',{expression:`(async()=>{
  const wait=async(f)=>{for(let i=0;i<100;i++){if(f())return;await new Promise(r=>setTimeout(r,100));}throw new Error('Reload timeout');};
  await wait(()=>document.querySelector('#guest-country option'));
  document.querySelector('#tab-reception').click();
  await wait(()=>document.querySelector('tr[data-booking-id="${bookingId}"]'));
  return document.querySelector('tr[data-booking-id="${bookingId}"]').innerText;
 })()`,awaitPromise:true,returnByValue:true});
 if(reloaded.exceptionDetails||!reloaded.result.value.includes('Prototype Browser Test'))throw new Error('Booking not retained after reload');
 await client.send('Runtime.evaluate',{expression: `const query=document.querySelector('#filter-query');query.value='${bookingId}';query.dispatchEvent(new Event('input'));window.scrollTo(0,0);`});
 const screenshot=await client.send('Page.captureScreenshot',{captureBeyondViewport:false});
 if(process.env.SCREENSHOT_PATH)writeFileSync(process.env.SCREENSHOT_PATH,Buffer.from(screenshot.data,'base64'));
 console.log(JSON.stringify({realBooking:bookingId,seasonalPrice:b.price_total,persistedAfterReload:true,overview:true}));
} finally {
 if(bookingId){const r=await fetch(base+'/api/bookings/'+bookingId,{method:'DELETE'});if(r.status!==204)throw new Error('Could not cancel test booking');}
 const exited=new Promise(r=>chrome.once('exit',r));chrome.kill();await exited;
 rmSync(profile,{recursive:true,force:true,maxRetries:5,retryDelay:200});
}
