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
w = Element('workbook', {'locale':'en_US','source-platform':'mac','source-build':'2024.1.0 (20241.24.0201.0000)','version':'18.1','xmlns:user':'http://www.tableausoftware.com/xml/user'})
E(w,'preferences'); E(w,'style-theme',name='smooth')
dss = E(w,'datasources')
works = E(w,'worksheets')
for key,title in charts:
    ds = E(dss,'datasource',caption=title,inline='true',name=key,version='18.1')
    c=E(ds,'connection',{'class':'textscan','directory':'data','filename':key+'.csv','header':'yes','separator':',','character-set':'UTF-8'})
    rel=E(c,'relation',name=key+'.csv',table='['+key+'#csv]',type='table')
    columns=E(rel,'columns',header='yes',separator=',')
    E(columns,'column',datatype='string',name='Label',ordinal='0')
    E(columns,'column',datatype='real',name='Value',ordinal='1')
    for parent in [ds]:
        E(parent,'column',datatype='string',name='[Label]',role='dimension',type='nominal')
        E(parent,'column',datatype='real',name='[Value]',role='measure',type='quantitative')
    extract=E(ds,'extract',**{'enabled':'true','units':'records','count':'-1'})
    hc=E(extract,'connection',{'class':'hyper','dbname':'data/'+key+'.hyper','schema':'Extract','access_mode':'readonly'})
    E(hc,'relation',name='Extract',table='[Extract].[Extract]',type='table')
    ws=E(works,'worksheet',name=title)
    t=E(ws,'table'); v=E(t,'view'); sources=E(v,'datasources'); E(sources,'datasource',caption=title,name=key)
    deps=E(v,'datasource-dependencies',datasource=key)
    E(deps,'column',datatype='string',name='[Label]',role='dimension',type='nominal')
    E(deps,'column',datatype='real',name='[Value]',role='measure',type='quantitative')
    E(deps,'column-instance',column='[Label]',derivation='None',name='[none:Label:nk]',pivot='key',type='nominal')
    E(deps,'column-instance',column='[Value]',derivation='Sum',name='[sum:Value:qk]',pivot='key',type='quantitative')
    E(v,'aggregation',value='true')
    E(t,'style')
    pane=E(E(t,'panes'),'pane'); E(E(pane,'view'),'breakdown',value='auto')
    E(pane,'mark',{'class':'Text' if key=='summary' else 'Bar'})
    enc=E(pane,'encodings'); E(enc,'text',column=f'[{key}].[sum:Value:qk]')
    style=E(pane,'style'); rule=E(style,'style-rule',element='mark')
    E(rule,'format',attr='mark-color',value='#225b5a'); E(rule,'format',attr='mark-labels-show',value='true')
    E(t,'rows').text=f'[{key}].[none:Label:nk]'
    E(t,'cols').text='' if key=='summary' else f'[{key}].[sum:Value:qk]'
dash=E(E(w,'dashboards'),'dashboard',name='Hotel Kong Arthur - API dashboard')
layout=E(dash,'layout-options'); title=E(E(layout,'title'),'formatted-text'); E(title,'run',fontsize='18',bold='true').text='Hotel Kong Arthur | API / MySQL | 2026 DEMO'
E(dash,'size',maxheight='1100',maxwidth='1400',minheight='1100',minwidth='1400')
zones=E(dash,'zones'); outer=E(zones,'zone',h='100000',w='100000',x='0',y='0',id='100',type='layout-basic')
E(outer,'zone',h='4500',w='100000',x='0',y='0',id='101',type='title')
note=E(outer,'zone',h='3500',w='100000',x='0',y='4500',id='102',type='text')
E(E(note,'formatted-text'),'run',fontsize='10').text='Demo inventory: 16 rooms. Refresh API snapshot, then refresh Tableau data. Select marks for details; use worksheet Keep Only / Exclude to filter.'
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
