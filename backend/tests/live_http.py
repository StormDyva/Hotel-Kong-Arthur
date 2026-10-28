"""Run explicitly against the local demo stack; retain the test booking as cancelled."""
import json
from urllib.request import Request, urlopen
from decimal import Decimal
BASE = 'http://localhost:5500'

def call(path, method='GET', body=None):
    req = Request(BASE+path, method=method, headers={'Content-Type':'application/json'},
                  data=json.dumps(body).encode() if body is not None else None)
    with urlopen(req, timeout=15) as r:
        return json.load(r) if r.status != 204 else None

before = call('/api/analytics/dashboard')['summary']['revenue']
p = dict(room_id=101, check_in='2026-12-20', check_out='2026-12-22', guests_count=1,
         guest=dict(name='Live Verification', email='live@example.com', phone='+4512345678',country_code='DK'))
b = call('/api/bookings','POST',p)
try:
    assert Decimal(str(call('/api/analytics/dashboard')['summary']['revenue'])) == Decimal(str(before))+1800
    assert call('/api/bookings/'+str(b['id']))['status'] == 'confirmed'
    p['check_out'] = '2026-12-23'
    assert Decimal(call('/api/bookings/'+str(b['id']),'PUT',p)['price_total']) == 2700
finally:
    call('/api/bookings/'+str(b['id']),'DELETE')
assert call('/api/analytics/dashboard')['summary']['revenue'] == before
print('Live HTTP POST → MySQL → analytics → PUT → DELETE → analytics passed')
