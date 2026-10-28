"""Refresh Tableau CSVs from ONE API snapshot. No SQL access or personal data."""
import argparse
import csv
import json
import os
from pathlib import Path
from urllib.parse import urlencode
from urllib.request import urlopen


def refresh(api, output, start, end):
    url = api.rstrip('/') + '/api/analytics/dashboard?' + urlencode({'from':start, 'to':end})
    with urlopen(url, timeout=30) as response:
        data = json.load(response)
    output.mkdir(parents=True, exist_ok=True)
    s = data['summary']
    datasets = {
        'summary': [(k, v) for k, v in s.items()],
        'rooms': [(x['label'],x['revenue']) for x in data['by_room_type']],
        'countries': [(x['label'],x['revenue']) for x in data['by_country']],
        'guests': [(x['label'],x['bookings']) for x in data['by_country']],
        'seasons': [(x['label'],x['revenue']) for x in data['by_season']],
        'room_seasons': [(x['label'],x['revenue']) for x in data['by_room_type_season']],
        'drinks': [(x['product'],x['revenue']) for x in data['bar_products']],
        'mix': [(x['category'],x['percent']) for x in data['bar_categories']],
    }
    for name, rows in datasets.items():
        path = output / (name + '.csv')
        tmp = path.with_suffix('.tmp')
        with tmp.open('w', newline='', encoding='utf-8') as f:
            w = csv.writer(f); w.writerow(['Label','Value']); w.writerows(rows)
        os.replace(tmp, path)
    from tableauhyperapi import HyperProcess, Connection, Telemetry, CreateMode, TableDefinition, TableName, SqlType, Inserter
    with HyperProcess(Telemetry.DO_NOT_SEND_USAGE_DATA_TO_TABLEAU) as hyper:
        for name, rows in datasets.items():
            path = output / (name+'.hyper')
            tmp = output / (name+'.new.hyper')
            with Connection(hyper.endpoint, str(tmp), CreateMode.CREATE_AND_REPLACE) as connection:
                connection.catalog.create_schema('Extract')
                table = TableDefinition(TableName('Extract','Extract'), [
                    TableDefinition.Column('Label', SqlType.text()),
                    TableDefinition.Column('Value', SqlType.double())])
                connection.catalog.create_table(table)
                with Inserter(connection, table) as insert:
                    insert.add_rows([(str(label),float(value)) for label,value in rows])
                    insert.execute()
            os.replace(tmp, path)
    (output/'snapshot.json').write_text(json.dumps(data, indent=2), encoding='utf-8')
    print(f"Refreshed {len(datasets)} Tableau sources at {data['refreshed_at']} ({start} to {end}, exclusive)")


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('--api', default='http://localhost:8000')
    p.add_argument('--output', type=Path, default=Path(__file__).parent/'data')
    p.add_argument('--from', dest='start', default='2026-01-01')
    p.add_argument('--to', dest='end', default='2027-01-01')
    a = p.parse_args()
    refresh(a.api, a.output, a.start, a.end)
