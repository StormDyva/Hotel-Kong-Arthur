"""Execute generated SQL against an isolated PostgreSQL schema, using mock files."""
import subprocess
import sys
import zipfile
from pathlib import Path
from xml.etree.ElementTree import Element, SubElement, tostring

import pytest
from test_api import repo

ROOT = Path('/project') if Path('/project/database/import').is_dir() else Path(__file__).resolve().parents[2]
IMPORT = ROOT / 'database/import'
POSTGRES = ROOT / 'database/postgres'


def xlsx(path, headers, rows):
    # Minimal first-worksheet fixture using the same cell format as the source reader.
    ns = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main'
    sheet = Element('worksheet', xmlns=ns)
    data = SubElement(sheet, 'sheetData')
    for number, values in enumerate([headers, *rows], 1):
        row = SubElement(data, 'row', r=str(number))
        for index, value in enumerate(values):
            cell = SubElement(row, 'c', r=f'{chr(65+index)}{number}', t='str')
            SubElement(cell, 'v').text = str(value)
    with zipfile.ZipFile(path, 'w') as book:
        book.writestr('xl/worksheets/sheet1.xml', tostring(sheet))


def sources(folder, count=1000, rejected=False):
    import csv
    headers = ['First Name','Family Name','Country','Room Type','Days Rented','Season','Price']
    # Exercise apostrophes, literal backslashes and a potential DO delimiter.
    rows = [["Mock O'Brien $import$", r'Back\slash', 'Sweden', 'Standard Single', '2', 'low', '1800.15'] for _ in range(count)]
    if rejected:
        rows.append(['Rejected','Mock','Unknown','Standard Single','2','low','100'])
    xlsx(folder/'international_names_with_rooms_1000.xlsx', headers, rows)
    with (folder/'international_names_with_rooms_1000.csv').open('w', newline='') as f:
        writer=csv.writer(f); writer.writerow(headers); writer.writerows(rows)
    xlsx(folder/'drinks_menu_with_sales.xlsx', ['Drink Name','Category','Price (DKK)','Units Sold'], [["Mock O'Brien $import$",'coffee','42.15','3']])


def generate(script, *args):
    return subprocess.run([sys.executable, str(IMPORT/script), *map(str,args)], check=True, capture_output=True, text=True).stdout


@pytest.fixture
def isolated(repo):
    repo.execute('CREATE SCHEMA generator_test')
    repo.execute('SET LOCAL search_path TO generator_test')
    repo.db.exec_driver_sql((POSTGRES/'migrations/001_initial_schema.sql').read_text(), execution_options={'no_parameters':True})
    for name in ['001_booking_foundation_seed.sql','002_assignment_reference_inventory.sql','003_christmas_high_season.sql']:
        repo.db.exec_driver_sql((POSTGRES/'seed'/name).read_text(), execution_options={'no_parameters':True})
    return repo


def test_raw_generator_quoting_rejections_and_idempotence(isolated, tmp_path):
    sources(tmp_path, count=2, rejected=True)
    sql=generate('import_customer_data.py','--customer-dir',tmp_path)
    for _ in range(2):
        isolated.db.exec_driver_sql(sql, execution_options={'no_parameters':True})
    assert isolated.one("SELECT count(*) n FROM customer_stay_records WHERE row_status='accepted'")['n']==2
    assert isolated.one("SELECT count(*) n FROM customer_stay_records WHERE row_status='rejected'")['n']==1
    assert isolated.one("SELECT count(*) n FROM customer_bar_sales_aggregates")['n']==1
    assert isolated.one("SELECT count(*) n FROM import_batches")['n']==2
    guests=isolated.rows('SELECT first_name,last_name FROM guests WHERE import_key IS NOT NULL')
    assert len(guests)==2
    rejected=subprocess.run([sys.executable,str(IMPORT/'build_anonymized_customer_seed.py'),'--customer-dir',str(tmp_path)],capture_output=True,text=True)
    assert rejected.returncode==2 and not rejected.stdout
    assert guests[0]==dict(first_name="Mock O'Brien $import$",last_name='Back\\slash')


def test_anonymized_and_booking_generators_preserve_totals(isolated, tmp_path):
    sources(tmp_path)
    sql=generate('build_anonymized_customer_seed.py','--customer-dir',tmp_path)
    assert "Mock O''Brien $import$" not in sql.split('INSERT INTO bar_products')[0]
    source=tmp_path/'anonymized.sql'; source.write_text(sql)
    output=tmp_path/'bookings.sql'
    generate('build_synthetic_bookings_seed.py','--source',source,'--output',output)
    for _ in range(2):
        isolated.db.exec_driver_sql(sql, execution_options={'no_parameters':True})
        isolated.db.exec_driver_sql(output.read_text(), execution_options={'no_parameters':True})
    assert isolated.one("SELECT count(*) n FROM bookings WHERE data_origin='synthetic_import'")['n']==1000
    assert isolated.one('SELECT count(*) n FROM booking_price_lines WHERE booking_id>1004')['n']==2000
    assert isolated.one("SELECT count(*) n FROM guests WHERE import_key IS NOT NULL AND first_name<>'Guest'")['n']==0
    assert isolated.one("""SELECT count(*) n FROM bookings b WHERE data_origin='synthetic_import'
        AND b.price_total<>(SELECT sum(line_total) FROM booking_price_lines l WHERE l.booking_id=b.id)""")['n']==0
    assert isolated.one("""SELECT count(*) n FROM bookings a JOIN bookings b ON a.id<b.id AND a.room_id=b.room_id
        AND a.check_in<b.check_out AND a.check_out>b.check_in WHERE a.status='confirmed' AND b.status='confirmed'""")['n']==0
