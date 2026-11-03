# PostgreSQL migration — T-031/T-032

Status 2026-11-03: ready for migration review on `feature/T-031-postgres-migration`.
The user explicitly requested implementation; this is not a claim that all week-2
requirements or the pending analysis/frontend decisions are complete.

## Runtime and data

- PostgreSQL 17 + psycopg 3 replace MySQL/PyMySQL in Compose and repositories.
- Host `127.0.0.1:5433`, container `db:5432`. API and frontend ports are unchanged.
- New `postgres_data` volume; existing `mysql_data` remains untouched.
- Admin/bootstrap credentials: POSTGRES_ADMIN_USER/POSTGRES_ADMIN_PASSWORD.
  API credentials: POSTGRES_USER/POSTGRES_PASSWORD. The application role is not
  superuser, owns no schema, and has DML and sequence permissions only.
- PostgreSQL baseline and anonymized fixtures are in `database/postgres/`.
  The older MySQL files remain available for historical reference; Compose never
  executes them on PostgreSQL.
- Identity columns replace auto-increment. Seed scripts synchronize sequences
  after explicit fixture IDs. CHECK constraints replace ENUM/unsigned domains.
  Capacity and updated_at triggers are ported. Money stays DECIMAL; timestamps
  remain UTC without changing the JSON contract. Employee matching uses lower/trim.
- Each SQL script and its migration marker commit together. Failed setup rolls
  back the script and can be retried. Applied seeds do not overwrite live edits.
- API paths, schemas, nightly snapshots, cancellation, guest isolation, ratings and
  room-lock order are preserved. OpenAPI equality is tested; no contract change.

Start:

```sh
docker compose up --build -d --wait
docker compose ps
```

T-040 follow-up: Compose now prepares 1,104 bookings automatically (1,000 source
stays + 100 extra mocks + four foundation bookings), with the school stays in
2026. `demo-init` also upgrades older volumes safely. See
[automatic demo setup](automatic-demo-data.md). The earlier 1,004-booking count
below describes SQL-only initialization before that follow-up.

The optional exact CSV loader preserves original source strings and names locally;
it is no longer needed to create the complete demo:

```sh
uv pip install --python backend/.venv/bin/python -r backend/requirements-dev.txt
backend/.venv/bin/python database/import/load_school_csv.py \
  --csv ../hoteldata-master/international_names_with_rooms_1000.csv
```

Python commands do not automatically load `.env`; export any custom POSTGRES_*
values or DATABASE_URL first. The loader uses the runtime DML account.
On the verified local instance this yields 1,104 bookings. The ten additional
operational bookings previously present only in MySQL are not copied, per C-017.
They remain in the old MySQL volume. Synthetic API names remain anonymized.
The source CSV is external and not committed. Its 54 existing replacement
characters are preserved, not guessed or repaired.

## Verification

- `docker compose config --quiet`: passed.
- `docker compose --profile test run --build --rm api-tests`: **35 passed**,
  one existing Starlette test-client deprecation warning. Includes the original
  29 API/contract tests plus six PostgreSQL/import regressions. Concurrent competing
  reservations still produce one 201 and one 409.
- PostgreSQL SQL foundation checks: inventory, source count and no overlapping
  confirmed fixture bookings passed as part of test initialization.
- Exact CSV loader: 1,000 source rows, 100 mocks; rerun added zero mocks and
  verified exact raw records and nightly/source totals.
- Database reset is rejected before any database command unless both host
  `test-db` and database `hotel_kong_arthur_test` match. Only the public schema of
  this dedicated database is reset. Never run parallel test runners.
- Runtime recreation/persistence and HTTP smoke results are recorded in the
  final branch verification below.

## Scope and limitations

- XLSX/SQL generators are now PostgreSQL-native. Tests execute raw imports
  (including rejected rows and apostrophes/backslashes/dollar delimiters) and
  anonymized fixture + synthetic booking generation twice in isolated schemas.
  Source batch hashes are read from the selected seed, not hardcoded. Rejected
  source rows are recorded by the raw importer; anonymized fixture generation
  refuses invalid inputs instead of silently omitting them.
- Tableau uses the REST API Connector (confirmed by the user 2026-11-03).
  `tableau/refresh.py` and workbook generators are retired from the active workflow;
  they remain historical MySQL tools. Porting them is not a migration requirement
  or acceptance blocker. Tableau reads the existing API, not PostgreSQL directly.
  End-to-end connector/dashboard refresh still needs manual verification.
- Frontend analysis views and the pending C-013–C-016 decisions remain separate.
- This is a local school prototype, not a verified production backup/restore setup.

Rollback: stop Compose without `-v`, switch back to main or the v1 tag, then
rebuild. The MySQL and PostgreSQL volumes are separate. Do not delete either volume
when switching versions. Changes made on PostgreSQL are not copied back to MySQL.

## Final branch verification — 2026-11-03

`docker compose up -d --force-recreate --wait` preserved all 1,104 bookings and
1,000 raw CSV rows. db-init skipped all applied schema/seed markers. Database,
API and frontend became healthy; health, Swagger, OpenAPI, frontend and flat
revenue HTTP requests returned 200. Type/season revenue returned all 24 rows.
The runtime DML role `hotel_app` was verified with `rolsuper=false` and no schema
CREATE permission. A booking transaction under that role succeeded and was
rolled back, leaving the dataset unchanged. No confirmed room/date overlaps.
Both wrong-host and wrong-database reset combinations were rejected.
`git diff --check` passed. The runtime, seed and import migration is ready for
human review. This does not accept the separate analysis frontend, pending
business decisions or end-to-end Tableau dashboard. The retired Tableau export
bridge is excluded from scope.

## Review completion

- All three source generators output PostgreSQL SQL and use the same quoting and
  safe block wrapper. The anonymized generator never emits source guest names.
- 35 PostgreSQL tests pass, 59 frontend unit tests pass, and the Swagger browser
  smoke found 28 endpoints and successfully executed Try it out (HTTP 200).
- A new Compose project on ports 15433/18000/15500 initialized without raw files;
  API/proxy/Swagger/OpenAPI and all 24 revenue combinations worked. A booking
  created through HTTP survived full container recreation with its price intact.
- Original API schemas remain unchanged and match the served OpenAPI document.
- Reviewers still need to approve the API/database/Docker changes before merge.
