# Tableau: API-backed hotel dashboard

Data flow: MySQL → backend services → GET /api/analytics/dashboard → Hyper extracts → Tableau Public.
No direct database access is used by Tableau. The extract bridge calls the actual API
and never reads historical CSV files as its source. Tableau's UI remains a desktop
application; all application services run through Docker Compose.

## Prepare and open

```sh
uv pip install --python backend/.venv/bin/python -r tableau/requirements.txt
backend/.venv/bin/python tableau/refresh.py
python3 tableau/build_workbook.py
```

Open `tableau/Hotel-Kong-Arthur.twb` in Tableau Public. Generated data files live
beside the workbook in `tableau/data/` and are ignored by Git.

The dashboard contains total revenue, occupancy, ADR (the extra KPI), inventory,
room-type revenue, country revenue, guest stays by country, room type by season,
seasonal revenue, Helene Christine's drink revenue and cocktail/coffee revenue shares.
Guest distribution uses booking_guests (party sizes), not booking counts. All party members are attributed to the booking guest country; other occupants’ nationalities are not recorded.
Select marks for details and use Tableau's Keep Only / Exclude controls for filtering.

## Refresh after a booking

Run `backend/.venv/bin/python tableau/refresh.py` again, then reopen the workbook to
load the new extracts. Existing open extracts may be cached by Tableau.
Change the period with `--from 2026-06-01 --to 2026-09-01` (`to` is exclusive).
The snapshot JSON records the report period and refresh time. Rebuild/reopen the
workbook after changing periods. Do not present a different period under a 2026 title.

Tableau Public uses extracts, not live database connections. A published workbook
will not poll this localhost API. Automatic publication/refresh to Tableau Public
is outside this prototype; don't claim real-time updates on the public website.
For Tableau Desktop with the official REST API Connector, the same dashboard JSON
can be used directly with JSONPath to the relevant arrays, subject to that connector's
installation and licensing requirements.

## Baseline reconciliation (untouched seed, calendar 2026)

- Hotel revenue: 12,700 DKK; six sold room nights; 5,840 available room nights.
- Occupancy: 0.10%; ADR: 2,116.67 DKK.
- Helene Christine bar revenue: 575 DKK.
- Cocktail share: 43.48%; coffee share: 56.52%.

The seed is demo data, not actual hotel financial results. Compare these numbers
against the API after a fresh initialization; real booking changes affect them.

`build_workbook.py` also creates `Hotel-Kong-Arthur.twbx` with all Hyper files
embedded, for portable review. It is a snapshot: rerun refresh and rebuild the
package to update it. The final extract-backed version loaded without workbook
errors in Tableau's logs; visual layout and interactive filtering still need review.
The earlier XML and missing-extract versions were invalid and have been replaced.


T-023: Eksportens guests-rækker tæller nu booking_guests. En booking med fire
personer bidrager med fire. Det er ikke et bevis for et færdigt eller opdateret
Tableau-dashboard; den samlede leverance afventer manuel dashboardverifikation.
