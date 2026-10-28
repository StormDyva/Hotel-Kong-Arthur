import { spawn } from 'node:child_process';
import { mkdtempSync, rmSync } from 'node:fs';
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

const port=9444;
const profile=mkdtempSync(join(tmpdir(),'hka-swagger-'));
const chrome=spawn('/Applications/Google Chrome.app/Contents/MacOS/Google Chrome',[
 '--headless=new','--disable-gpu','--no-first-run',`--remote-debugging-port=${port}`,
 `--user-data-dir=${profile}`,'about:blank']);
try {
 const client=cdp(await connect(port));
 await client.send('Runtime.enable');
 await client.send('Page.enable');
 await client.send('Page.navigate',{url:'http://localhost:8000/docs'});
 for(let i=0;i<100;i++){
  try {
   const ready=await client.send('Runtime.evaluate',{expression:"document.readyState==='complete' && !!document.querySelector('.opblock')",returnByValue:true});
   if(ready.result?.value)break;
  }catch{}
  await new Promise(r=>setTimeout(r,100));
 }

 const {result,exceptionDetails}=await client.send('Runtime.evaluate',{
  expression:`(async()=>{
   const wait=async(f)=>{for(let i=0;i<150;i++){if(f())return;await new Promise(r=>setTimeout(r,100));}throw new Error('Swagger timeout');};
   await wait(()=>document.querySelectorAll('.opblock').length>20);
   const blocks=[...document.querySelectorAll('.opblock')];
   const block=blocks.find(b=>b.querySelector('.opblock-summary-path')?.dataset.path==='/api/analytics/bar-sales');
   if(!block)throw new Error('Missing bar endpoint');
   block.querySelector('.opblock-summary-control').click();
   await wait(()=>block.querySelector('.try-out__btn'));
   block.querySelector('.try-out__btn').click();
   await wait(()=>block.querySelector('.execute'));
   block.querySelector('.execute').click();
   await wait(()=>block.querySelector('.live-responses-table'));
   const response=block.querySelector('.live-responses-table').innerText;
   if(!response.includes('200')||!response.includes('total_revenue')||!response.includes('575'))throw new Error(response);
   return {endpoints:blocks.length,barSalesStatus:200,swaggerTryItOut:'passed'};
  })()`,awaitPromise:true,returnByValue:true});
 if(exceptionDetails)throw new Error(JSON.stringify(exceptionDetails));
 console.log(JSON.stringify(result.value));
} finally {
 const exited=new Promise(r=>chrome.once('exit',r)); chrome.kill(); await exited;
 rmSync(profile,{recursive:true,force:true,maxRetries:5,retryDelay:200});
}
