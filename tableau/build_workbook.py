"""Create a portable native Tableau workbook over API-derived CSV sources."""
from pathlib import Path
from xml.etree.ElementTree import Element, SubElement as E, ElementTree

ROOT = Path(__file__).parent
charts = [
    ('summary', 'Hotel KPIs - DKK, nights and percent'),
    ('rooms', 'Revenue by room type - DKK'),
    ('countries', 'Revenue by country - DKK'),
    ('guests', 'Guest stays by country'),
    ('room_seasons', 'Room type and season - DKK'),
    ('seasons', 'Revenue by season - DKK'),
    ('drinks', 'Helene Christine - drink revenue DKK'),
    ('mix', 'Helene Christine - revenue share percent'),
]
endpoint_titles = {
    'api_bookings': 'API - All bookings',
    'api_synthetic_bookings': 'API - Synthetic bookings',
    'endpoint_occupancy': 'API - Occupancy and ADR',
    'endpoint_revenue': 'API - Total hotel revenue',
    'endpoint_revenue_by_room': 'API - Revenue by room',
    'endpoint_revenue_by_room_type': 'API - Revenue by room type',
    'endpoint_revenue_by_country': 'API - Revenue by country',
    'endpoint_revenue_by_season': 'API - Revenue by season',
    'endpoint_revenue_by_room_type_season': 'API - Revenue by room type and season',
    'endpoint_guests_by_country': 'API - Guests by country',
    'endpoint_top_performers': 'API - Top performers',
    'endpoint_bar_sales': 'API - Bar sales',
    'endpoint_customer_satisfaction': 'API - Customer satisfaction',
    'endpoint_flat_revenue_by_room_type_season': 'API - Flat room type and season revenue',
    'endpoint_flat_revenue_by_country': 'API - Flat country revenue',
    'imported_stay_records': 'Imported stays - anonymized detail',
    'imported_stay_revenue_by_country': 'Imported stay value by country',
    'imported_stay_nights_by_country': 'Imported stay nights by country',
    'imported_drink_records': 'Imported drink sales - detail',
    'imported_drink_revenue': 'Imported drink revenue by product',
    'imported_drink_units': 'Imported drink units by product',
}
charts.extend((key, title) for key, title in endpoint_titles.items() if (ROOT/'data'/f'{key}.csv').exists())
w = Element('workbook', {'locale':'en_US','source-platform':'mac','source-build':'2024.1.0 (20241.24.0201.0000)','version':'18.1','xmlns:user':'http://www.tableausoftware.com/xml/user'})
E(w,'preferences'); E(w,'style-theme',name='smooth')
dss = E(w,'datasources')
works = E(w,'worksheets')
for key,title in charts:
    connection_id = 'textscan.' + key
    ds = E(dss,'datasource',caption=title,inline='true',name='federated.'+key,version='18.1')
    c=E(ds,'connection',{'class':'federated'})
    named_connections=E(c,'named-connections')
    named=E(named_connections,'named-connection',{'caption':key,'name':connection_id})
    E(named,'connection',{'class':'textscan','directory':'data','filename':key+'.csv','password':'','server':''})
    rel=E(c,'relation',{'connection':connection_id,'name':key+'.csv','table':'['+key+'#csv]','type':'table'})
    columns=E(rel,'columns',{'character-set':'UTF-8','header':'yes','locale':'en_US','separator':','})
    E(columns,'column',datatype='string',name='Label',ordinal='0')
    E(columns,'column',datatype='real',name='Value',ordinal='1')
    for parent in [ds]:
        E(parent,'column',datatype='string',name='[Label]',role='dimension',type='nominal')
        E(parent,'column',datatype='real',name='[Value]',role='measure',type='quantitative')
    extract=E(ds,'extract',**{'enabled':'true','units':'records','count':'-1'})
    hc=E(extract,'connection',{'class':'hyper','dbname':'data/'+key+'.hyper','schema':'Extract','access_mode':'readonly'})
    E(hc,'relation',name='Extract',table='[Extract].[Extract]',type='table')
    source_name='federated.'+key
    ws=E(works,'worksheet',name=title)
    t=E(ws,'table'); v=E(t,'view'); sources=E(v,'datasources'); E(sources,'datasource',caption=title,name=source_name)
    deps=E(v,'datasource-dependencies',datasource=source_name)
    E(deps,'column',datatype='string',name='[Label]',role='dimension',type='nominal')
    E(deps,'column',datatype='real',name='[Value]',role='measure',type='quantitative')
    E(deps,'column-instance',column='[Label]',derivation='None',name='[none:Label:nk]',pivot='key',type='nominal')
    E(deps,'column-instance',column='[Value]',derivation='Sum',name='[sum:Value:qk]',pivot='key',type='quantitative')
    E(v,'aggregation',value='true')
    E(t,'style')
    pane=E(E(t,'panes'),'pane'); E(E(pane,'view'),'breakdown',value='auto')
    E(pane,'mark',{'class':'Text' if key in {'summary','imported_stay_records'} else 'Bar'})
    enc=E(pane,'encodings'); E(enc,'text',column=f'[{source_name}].[sum:Value:qk]')
    style=E(pane,'style'); rule=E(style,'style-rule',element='mark')
    E(rule,'format',attr='mark-color',value='#225b5a'); E(rule,'format',attr='mark-labels-show',value='true')
    E(t,'rows').text=f'[{source_name}].[none:Label:nk]'
    E(t,'cols').text='' if key in {'summary','imported_stay_records'} else f'[{source_name}].[sum:Value:qk]'
dash=E(E(w,'dashboards'),'dashboard',name='Hotel Kong Arthur - API dashboard')
layout=E(dash,'layout-options'); title=E(E(layout,'title'),'formatted-text'); E(title,'run',fontsize='18',bold='true').text='Hotel Kong Arthur | API / MySQL | Synthetic booking data'
E(dash,'size',maxheight='1100',maxwidth='1400',minheight='1100',minwidth='1400')
zones=E(dash,'zones'); outer=E(zones,'zone',h='100000',w='100000',x='0',y='0',id='100',type='layout-basic')
E(outer,'zone',h='4500',w='100000',x='0',y='0',id='101',type='title')
note=E(outer,'zone',h='3500',w='100000',x='0',y='4500',id='102',type='text')
E(E(note,'formatted-text'),'run',fontsize='10').text='API analytics snapshot. Refresh API data with tableau/refresh.py, then rebuild this workbook. Select marks for details; use worksheet Keep Only / Exclude to filter.'
for i,(_,title) in enumerate(charts):
    E(outer,'zone',h='23000',w='50000',x=str((i%2)*50000),y=str(8000+(i//2)*23000),id=str(i+1),name=title,**{'show-title':'true'})
windows=E(w,'windows')
for _,title in charts:
    win=E(windows,'window',{'class':'worksheet','name':title})
    E(win,'cards')
    E(win,'viewpoint')
win=E(windows,'window',{'class':'dashboard','name':'Hotel Kong Arthur - API dashboard'})
E(win,'viewpoints')
E(win,'active',id='-1')
E(win,'device-preview')
E(w,'thumbnails')
ElementTree(w).write(ROOT/'Hotel-Kong-Arthur.twb',encoding='utf-8',xml_declaration=True)
print(ROOT/'Hotel-Kong-Arthur.twb')

import zipfile
with zipfile.ZipFile(ROOT/'Hotel-Kong-Arthur.twbx','w',zipfile.ZIP_DEFLATED) as package:
    package.write(ROOT/'Hotel-Kong-Arthur.twb','Hotel-Kong-Arthur.twb')
    for path in (ROOT/'data').glob('*.hyper'):
        package.write(path,'data/'+path.name)
    for path in (ROOT/'data').glob('*.csv'):
        package.write(path,'data/'+path.name)
