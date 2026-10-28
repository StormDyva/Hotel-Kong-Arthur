"""Refresh Tableau CSVs from the API and anonymized imported MySQL aggregates."""
import argparse
import csv
import json
import os
import subprocess
from pathlib import Path
from urllib.parse import urlencode
from urllib.request import urlopen


ANALYTICS_ENDPOINTS = {
    'occupancy': ('/api/analytics/occupancy', {'occupancy_percent', 'room_nights', 'available_room_nights', 'adr'}),
    'revenue': ('/api/analytics/revenue', {'revenue'}),
    'revenue_by_room': ('/api/analytics/revenue-by-room', {'revenue'}),
    'revenue_by_room_type': ('/api/analytics/revenue-by-room-type', {'revenue'}),
    'revenue_by_country': ('/api/analytics/revenue-by-country', {'revenue'}),
    'revenue_by_season': ('/api/analytics/revenue-by-season', {'revenue'}),
    'revenue_by_room_type_season': ('/api/analytics/revenue-by-room-type-season', {'revenue'}),
    'guests_by_country': ('/api/analytics/guests-by-country', {'booking_guests', 'guest_nights', 'distinct_bookers'}),
    'top_performers': ('/api/analytics/top-performers', {'revenue'}),
    'bar_sales': ('/api/analytics/bar-sales', {'total_revenue', 'revenue', 'quantity', 'percent'}),
    'customer_satisfaction': ('/api/analytics/customer-satisfaction', {'average_rating', 'response_percent', 'rated_bookings', 'eligible_bookings', 'count'}),
    'flat_revenue_by_room_type_season': ('/analytics/revenue/by-room-type-season', {'revenue'}),
    'flat_revenue_by_country': ('/analytics/revenue/by-country', {'revenue'}),
}


def fetch_json(url):
    with urlopen(url, timeout=30) as response:
        return json.load(response)


def booking_datasets(api):
    """Fetch all booking pages without exporting guest contact details."""
    all_bookings = []
    page = 1
    total = None
    while total is None or len(all_bookings) < total:
        payload = fetch_json(api.rstrip('/') + '/api/bookings?' + urlencode({
            'page': page, 'page_size': 100,
        }))
        all_bookings.extend(payload['items'])
        total = payload['total']
        page += 1
        if not payload['items']:
            break

    def label(booking):
        guest = booking['guest']
        return (
            f"#{booking['id']} | {booking['data_origin']} | {guest['country_code']} | "
            f"{booking['room_type']} {booking['room_number']} | "
            f"{booking['check_in']}–{booking['check_out']} | "
            f"{booking['guests_count']} guests | {booking['status']}"
        )

    return {
        'api_bookings': [(label(item), float(item['price_total'])) for item in all_bookings],
        'api_synthetic_bookings': [
            (label(item), float(item['price_total']))
            for item in all_bookings if item['data_origin'] == 'synthetic_import'
        ],
    }


def mysql_rows(query):
    result = subprocess.run(
        [
            'docker', 'compose', 'exec', '-T', 'db', 'sh', '-c',
            'exec mysql --default-character-set=utf8mb4 --batch --raw --skip-column-names '
            '-uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" -e "$1"',
            'sh', query,
        ],
        check=True,
        capture_output=True,
        text=True,
    )
    return [line.split('\t') for line in result.stdout.splitlines() if line]


def imported_customer_datasets():
    """Export imported staging rows without guest names or contact details."""
    stays = mysql_rows(
        "SELECT source_record_id, country_name, country_code, source_room_type, "
        "season_code, days_rented, price_total FROM customer_stay_records "
        "WHERE row_status = 'accepted' ORDER BY source_record_id"
    )
    drinks = mysql_rows(
        "SELECT a.source_record_id, p.name, a.category, a.unit_price, a.units_sold "
        "FROM customer_bar_sales_aggregates a JOIN bar_products p ON p.id = a.product_id "
        "WHERE a.row_status = 'accepted' ORDER BY a.source_record_id"
    )

    stay_records = []
    stay_revenue_by_country = {}
    stay_nights_by_country = {}
    for source_id, country, country_code, room_type, season, nights, price in stays:
        label = f'{source_id} | {country} ({country_code}) | {room_type} | {season} | {nights} nights'
        stay_records.append((label, float(price)))
        stay_revenue_by_country[country] = stay_revenue_by_country.get(country, 0.0) + float(price)
        stay_nights_by_country[country] = stay_nights_by_country.get(country, 0) + int(nights)

    drink_records = []
    drink_revenue = {}
    drink_units = {}
    for source_id, product, category, unit_price, units_sold in drinks:
        label = f'{category} | {product}'
        drink_records.append((f'{source_id} | {label} | {units_sold} units', float(unit_price) * int(units_sold)))
        drink_revenue[label] = drink_revenue.get(label, 0.0) + float(unit_price) * int(units_sold)
        drink_units[label] = drink_units.get(label, 0) + int(units_sold)

    return {
        'imported_stay_records': stay_records,
        'imported_stay_revenue_by_country': list(stay_revenue_by_country.items()),
        'imported_stay_nights_by_country': list(stay_nights_by_country.items()),
        'imported_drink_records': drink_records,
        'imported_drink_revenue': list(drink_revenue.items()),
        'imported_drink_units': list(drink_units.items()),
    }


def analytics_rows(payload, metric_names):
    """Flatten only documented measures; keep dimensions in the Tableau label."""
    rows = []

    dimension_keys = {'label', 'country', 'roomType', 'season', 'product', 'category', 'room', 'name', 'employee_name'}

    def visit(value, path, dimensions=()):
        if isinstance(value, dict):
            local_dimensions = dimensions + tuple(
                f'{key}={child}' for key, child in value.items()
                if key in dimension_keys and isinstance(child, (str, int, float))
            )
            for key, child in value.items():
                visit(child, path + [str(key)], local_dimensions)
        elif isinstance(value, list):
            for index, child in enumerate(value):
                visit(child, path + [str(index + 1)], dimensions)
        elif path and path[-1] in metric_names and value is not None:
            try:
                number = float(value)
            except (TypeError, ValueError):
                return
            label = ' / '.join(tuple(path[:-1]) + dimensions + (path[-1],))
            rows.append((label, number))

    visit(payload, [])
    return rows


def guest_rows(data):
    # Party size is attributed to the booking guest's country.
    return [(x['label'], x['booking_guests']) for x in data['by_country']]


def refresh(api, output, start, end):
    url = api.rstrip('/') + '/api/analytics/dashboard?' + urlencode({'from':start, 'to':end})
    data = fetch_json(url)
    output.mkdir(parents=True, exist_ok=True)
    s = data['summary']
    datasets = {
        'summary': [(k, v) for k, v in s.items()],
        'rooms': [(x['label'],x['revenue']) for x in data['by_room_type']],
        'countries': [(x['label'],x['revenue']) for x in data['by_country']],
        'guests': guest_rows(data),
        'seasons': [(x['label'],x['revenue']) for x in data['by_season']],
        'room_seasons': [(x['label'],x['revenue']) for x in data['by_room_type_season']],
        'drinks': [(x['product'],x['revenue']) for x in data['bar_products']],
        'mix': [(x['category'],x['percent']) for x in data['bar_categories']],
    }
    query = urlencode({'from': start, 'to': end})
    for name, (path, metric_names) in ANALYTICS_ENDPOINTS.items():
        payload = fetch_json(api.rstrip('/') + path + '?' + query)
        datasets['endpoint_' + name] = analytics_rows(payload, metric_names)
    datasets.update(booking_datasets(api))
    datasets.update(imported_customer_datasets())
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
