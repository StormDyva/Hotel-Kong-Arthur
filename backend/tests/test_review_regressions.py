from pathlib import Path
import importlib.util
from test_api import repo, client, payload


def test_names_never_merge_guests_and_contact_edits_are_isolated(client, repo):
    p = payload(); p.update(check_in='2047-03-01',check_out='2047-03-03')
    first = client.post('/api/bookings',json=p).json()
    p['room_id']=401; p['guest']['email']='second@example.com'
    second = client.post('/api/bookings',json=p).json()
    assert first['guest_id'] != second['guest_id']
    assert client.get(f"/api/bookings/{first['id']}").json()['guest']['email']=='test@example.com'
    groups=client.get('/api/analytics/guests-by-country?year=2047').json()['data']
    assert next(g for g in groups if g['label']=='DK')['distinct_bookers']==2
    p['room_id']=101; p['guest']['email']='corrected@example.com'
    updated=client.put(f"/api/bookings/{first['id']}",json=p)
    assert updated.status_code==200, updated.text
    assert client.get(f"/api/bookings/{second['id']}").json()['guest']['email']=='second@example.com'
    count=repo.one('SELECT COUNT(*) n FROM guests')['n']
    assert client.put(f"/api/bookings/{first['id']}",json=p).status_code==200
    assert repo.one('SELECT COUNT(*) n FROM guests')['n']==count


def test_review_cannot_follow_another_guest_or_stay(client):
    p=payload(); p.update(check_in='2025-03-01',check_out='2025-03-03')
    b=client.post('/api/bookings',json=p).json(); path=f"/api/bookings/{b['id']}"
    assert client.put(path+'/review',json={'rating':5}).status_code==200
    changes=[{'guest':{**p['guest'],'name':'Different Guest'}},
             {'guest':{**p['guest'],'country_code':'SE'}},
             {'check_in':'2025-03-02'}, {'check_out':'2025-03-04'}, {'room_id':401}]
    for change in changes:
        response=client.put(path,json={**p,**change})
        assert response.status_code==409, response.text
        assert response.json()['error']=='REVIEWED_BOOKING_IMMUTABLE'
    assert client.get(path).json()['guest']['name']==p['guest']['name']
    p['guest']['email']='contactfix@example.com'
    assert client.put(path,json=p).status_code==200
    assert client.get(path+'/review').json()['rating']==5
    stats=client.get('/api/analytics/customer-satisfaction?year=2025').json()['data']
    assert stats['rated_bookings']==1 and stats['average_rating']=='5.00'


def test_export_counts_people_not_bookings():
    path=Path(__file__).parents[2]/'tableau/refresh.py'
    spec=importlib.util.spec_from_file_location('tableau_refresh',path)
    module=importlib.util.module_from_spec(spec); spec.loader.exec_module(module)
    assert module.guest_rows({'by_country':[{'label':'DK','bookings':1,'booking_guests':4}]})==[('DK',4)]
