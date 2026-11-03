# Converge — PostgreSQL migration, 2026-11-03

## Scope and verdict

T-031/T-032, US-001/US-002: PostgreSQL runtime, persistence, repositories,
constraints, seeds and CSV/XLSX imports are **ready for review** in PR #13.
Human approval is still required; this report does not merge or approve the PR.
Other week-2 tasks and their Clarify decisions are outside this migration.

## What changed

- Compose runtime/test profile: PostgreSQL 17, psycopg 3, pg_isready, separate
  postgres_data volume. Existing mysql_data stays untouched; no MySQL rows copied.
- New PostgreSQL baseline, identity counters, decimal prices, UTC timestamps,
  capacity/updated_at triggers and CHECK constraints. API has a non-superuser
  DML role; bootstrap uses separate credentials.
- Repository uses parameterized PostgreSQL SQL, INSERT RETURNING and ON CONFLICT.
  Room locking/order, READ COMMITTED and booking validation remain in effect.
- CSV loader and all three XLSX/SQL generators are PostgreSQL-native. They preserve
  import keys and nightly totals. Generated SQL handles apostrophes, backslashes
  and dollar delimiters. Synthetic seeds remain anonymized/read-only through API.
- Tableau connects only through REST API Connector; the legacy export bridge and
  workbook generator are outside scope. No API or OpenAPI contract change.

## Verification

| Check | Evidence |
|---|---|
| `docker compose config --quiet` | Passed |
| `docker compose --profile test run --build --rm api-tests` | 35 passed; one existing Starlette test-client deprecation warning |
| Existing API, OpenAPI equality, CRUD, ratings, analytics, concurrency | Passed against PostgreSQL, including one 201/one 409 for competing bookings |
| SQL foundation checks | 214 active rooms, eight types, three seasons, 1000 source stays, no confirmed fixture overlaps |
| Raw XLSX generator | Mock source import executed twice; counts stable; accepted/rejected rows retained; guest attributes stay distinct |
| Anonymized + synthetic generators | Mock 1000-stay source executed twice in isolated schema; 1000 source bookings, 2000 nightly lines, exact totals, no room/date overlap |
| Invalid anonymized source | Generator exits with an error and produces no partial SQL |
| `npm --prefix frontend test` | 59 tests passed |
| `node backend/tests/swagger-smoke.mjs` | 28 operations; bar-sales HTTP 200; Swagger Try it out passed |
| Fresh Compose project | hka-pg-review, new volume, ports 15433/18000/15500; DB/API/frontend healthy; initialization exits 0 without external raw files |
| Fresh HTTP/proxy checks | health, Swagger, OpenAPI, frontend health and 24 type/season revenue rows passed |
| Fresh persistence | HTTP-created booking and its price/contact fields survived full container recreation; disposable project then removed |
| Working dataset | 1104 bookings, 1000 exact CSV rows; loader rerun adds no mocks; old MySQL volume preserved |
| Reset safeguards and runtime role | Wrong host/database rejected; runtime role not superuser, cannot CREATE schema objects; transactional write passed |
| `git diff --check` | Passed |

## Limits and review requirements

- No automated end-to-end Tableau connector/dashboard test was performed. Its
  extracts and manual refresh must be demonstrated separately by the group.
- C-013–C-016, analysis frontend and complete week-2 acceptance remain separate.
- Fixtures have generated dates/rooms; bar source aggregates are not fabricated
  into employee/date-level sales. No ratings are invented.
- External source data is not committed. Raw importer retains names locally;
  only anonymized fixture output is suitable for Git. The raw importer records
  invalid rows; strict anonymized generation refuses invalid input.
- App data is recreated from seed/import, not copied from MySQL (C-017).
  PostgreSQL changes are not synchronized back to the preserved MySQL volume.
- At least two human reviewers are required for API/database/Docker changes.
