# Automatic school demo — T-040

## Start or upgrade

```sh
docker compose up --build -d --wait
```

No raw CSV/XLSX files, local Python installation or manual import is required.
Compose starts PostgreSQL → db-init → demo-init → API → frontend. Both init
services should exit with status 0. For troubleshooting:

```sh
docker compose ps -a
docker compose logs --tail=100 db-init demo-init api
```

The final database contains **1,104 bookings** on a fresh volume:

| Source | Count | Dates |
|---|---|---|
| Anonymized source-derived stays | 1,000 | Generated in 2026, retaining source season, nights and exact total |
| Extra mock bookings | 100 | Generated in 2026, prices calculated by the booking service |
| Foundation examples | 4 | Existing 2026 examples, including one cancelled booking |

Revenue excludes cancelled bookings: 2026 analyses normally represent 1,103
confirmed bookings, with 21 country rows and all 24 room-type/season combinations.
These row counts describe grouped results, not missing reservations.
The complete demo also turns the 30 accepted drink aggregates into dated 2026
transactions, and adds deterministic reviews for 40% of completed demo stays.
The extra operational bookings made locally are preserved and can change totals.

## Existing installations

Do not delete the database volume. The next Compose start prepares existing
future-year source stays in 2026 and adds only missing mock keys. Existing 2026
source stays and operational bookings are preserved. Existing 100-mock batches
from the old CSV loader are reused. Extra student-created bookings can make the
overall count greater than 1,104; they are not removed to force an exact count.
The separate MySQL volume is untouched.

Bootstrap uses a transaction and a version marker (`demo_calendar_2026_v1`) in
import_batches. Failure rolls back the calendar, mock rows and marker together;
retrying is safe. Once prepared, normal restarts skip the work instead of
resetting edited data. Bar sales and reviews have separate version markers in
import_batches and are added on existing volumes without resetting bookings or
user-entered rows. `bar_sales` has no import-batch or data-origin column, so generated
transactions use the fixed demo-import timestamp `2026-11-04 00:00:00` alongside the
batch marker to identify the synthetic rows. Do not run the loader manually to repair
deliberate SQL changes without reviewing what changed.

Imported customer prices remain historical snapshots and can differ from the
current room_type_prices tariff table. The separate 100 mock stays and operational
bookings use current room tariffs. See [realistic demo data](realistic-demo-data.md)
for the original table counts, sources and the reason those imported snapshots are
preserved.

The optional [exact CSV loader](customer-data-import.md#exact-csv--extra-school-project-data-t-028)
adds exact original strings/names locally. It is not needed for all 1,100 school
stays and reuses the same mock batch instead of creating another 100.

## Check in browser/Tableau

- `http://localhost:8000/api/bookings?page_size=1`: `total` is 1,104 on a fresh stack.
  The items array is paginated; one page is not the whole dataset.
- `http://localhost:8000/analytics/revenue/by-country?year=2026`: 21 grouped rows.
- `http://localhost:8000/analytics/revenue/by-room-type-season?year=2026`: 24 rows.
- In Tableau, refresh via **Data → Refresh All Extracts** after upgrading.
  `localhost` refers to each student's own machine/database.

Older versions loaded only the SQL fixtures: 1,004 bookings, with most source
stays in future years and only three revenue countries in 2026. T-040 fixes that
startup gap rather than requiring every student to run a separate raw-file import.

## Verification

- 37 PostgreSQL/API/import tests passed, including existing golden and contract
  tests. Dedicated bootstrap tests cover the complete demo, an existing operational
  booking, existing 2026/mock batches, reruns and rollback/retry after failure.
- Fresh Compose project hka-full-demo on separate ports/volume initialized without
  any external raw files. HTTP checks returned 1,104 bookings, 21 countries and
  24 room-type/season rows. All runtime services became healthy.
- Repeated full container recreation still returned 1,104 bookings and 21 countries.
- The existing CSV-loaded working volume upgraded without changing any booking or
  contact snapshot (full before/after comparison); the optional CSV loader rerun
  added zero mocks. No Tableau UI test is claimed.
