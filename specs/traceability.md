# Sporbarhed — tillægsopgave uge 2

## Status

2026-11-06 (T-047): 41 backend-/API-tests mod PostgreSQL, 70 frontendtests og
19 browser-checks består. Sidste Converge: [converge-tillaeg-uge2.md](converge-tillaeg-uge2.md).
Tidligere PostgreSQL-bevis: [PostgreSQL-Converge](converge-postgres-2026-11-03.md).
Tableau-dashboardet vedligeholdes manuelt af gruppen og er ikke automatisk verificeret.

Main indeholder task-id-kollisioner: T-027 blev brugt både til importerede ophold
og RevPAR. De omtales nedenfor med opgavenavn. T-028 er CSV-demodata.

Scope 2026-11-06 (C-018): kun US-001, US-002, US-005 og US-006 spores.
Krav, der alene hørte til US-003, US-004, US-007 eller US-008, er fjernet fra
matricen; tilsvarende kode og endpoints er bevaret uden story.

## Story-acceptkriterier

| Krav / acceptkriterie | Spec | Story | Task | Test/verifikationstype | Status |
|---|---|---|---|---|---|
| Bookingformular opretter/redigerer og viser resultat | spec Booking | US-001 | T-025, T-037 | Frontendtest + manuel browserkontrol | Implementeret i main; ikke genverificeret her |
| POST 201; komplet idempotent PUT | spec Booking | US-001 | T-008, T-037 | API-test | Verificeret mod PostgreSQL |
| ISO-dato, kapacitet, overlap 409 | spec Booking | US-001 | T-008, T-037 | API-/concurrency-test | Verificeret mod PostgreSQL |
| DELETE soft-cancel/idempotent; genbooking mulig | spec Booking | US-001 | T-008, T-037 | API-test | Verificeret mod PostgreSQL |
| GET-filter/paginering/404 | spec Booking | US-001 | T-008, T-037 | API-test | Verificeret mod PostgreSQL |
| Mutation ses i næste GET/analyse uden genimport | spec Live | US-002 | T-009, T-037 | Integrationstest | Verificeret mod PostgreSQL |
| CSV/XLSX seed/import reproducerbar og idempotent | spec Data | US-002 | T-028, T-032, T-037 | Import-/integrationstest | CSV- og XLSX/importgeneratorer verificeret mod PostgreSQL |
| Importerede rækker har `synthetic_import` og er skrivebeskyttede | spec Data | US-002 | T-027 (importerede ophold), T-037 | API-/runtime-test | Implementeret i main; ikke genverificeret her |
| Live-definition og ingen push dokumenteret | clarify C-001 | US-002 | T-009, T-038 | Dokumentationsreview | Dækket i specifikation; implementation følger næste GET |
| PostgreSQL uden API-kontraktændring | constitution, plan | US-002 | T-031, T-032, T-034, T-037 | API-/kontrakttest | Verificeret med OpenAPI-lighed og API-tests |
| Eksisterende 29 API-tests samt concurrency består mod PostgreSQL | tasks | US-002 | T-037 | API-/concurrency-test | 35 tests består mod PostgreSQL |
| Bar-total for Helene Christine | clarify C-008 | US-005 | T-012, T-037 | API-/golden dataset-test | Verificeret mod PostgreSQL |
| Omsætning pr. drink = quantity × unit_price | spec Analyser | US-005 | T-012, T-037 | Formel-/API-test | Eksisterende v1-dækning |
| Cocktail/kaffe beløb og andele | spec Analyser | US-005 | T-012, T-037 | API-test | Eksisterende v1-dækning |
| Nævner nul = 0 med advarsel | clarify C-010 | US-005 | T-012, T-034, T-037 | API-test | Verificeret mod PostgreSQL |
| Baranalyse dokumenteret som GET/JSON | clarify C-014 | US-005 | T-033, T-034 | OpenAPI-/kontrakttest | Findes i nuværende OpenAPI; review mangler |
| Én rating 1–5; gentagen PUT opdaterer | clarify C-009 | US-006 | T-013, T-032, T-037 | API-/integrationstest | Eksisterende v1-dækning |
| Ugyldig/fremtidig/annulleret bedømmelse afvises | clarify C-009 | US-006 | T-013, T-032, T-037 | API-test | Eksisterende v1-dækning |
| Gennemsnit, svarprocent, antal og fordeling | spec Kundetilfredshed | US-006 | T-013, T-033, T-037 | Formel-/API-test | Verificeret mod PostgreSQL |
| Ingen ratings giver null og advarsel | clarify C-010 | US-006 | T-013, T-033, T-037 | API-test | Eksisterende v1-dækning |
| Tilfredshed-GET dokumenteret og afstemt | clarify C-014 | US-006 | T-033, T-034, T-036 | OpenAPI, API og manuel afstemning | Verificeret: API-tests, OpenAPI-lighed og vist i analysefanen (T-047) |

## Tværgående leverancer

| Krav | Spec | Stories | Task | Test/verifikationstype | Status |
|---|---|---|---|---|---|
| PostgreSQL runtime og SQL-dialektskift | constitution, plan | US-002 | T-031, T-032 | Compose-, migrations- og integrationstest | Verificeret mod PostgreSQL 17 (T-031/T-032, 41 tests) |
| Samme API-kontrakt efter databaseskift | constitution, spec | US-002 | T-033, T-034, T-037 | OpenAPI-lighed + API-regression | Verificeret med OpenAPI-lighed og API-tests |
| Compose healthcheck, start og persistence | constitution, plan | US-002 | T-031 | Manuel Compose-smoke | Verificeret: alle services healthy, `/health` ok (2026-11-06) |
| Sikkert PostgreSQL-testreset | plan | US-002 | T-032, T-037 | Negativ sikkerheds-/integrationstest | Verificeret i T-032/T-037 (separat test-db) |
| README, guides og analysevejledning | tasks | US-002 | T-038 | Dokumentationsreview/clean checkout | Dokumenteret; runtimevejledninger afventer PostgreSQL |
| Afsluttende Converge | constitution | — (leverance) | T-039 | Converge-review | Udført 2026-11-06, se converge-tillaeg-uge2.md |

## Historik og eksisterende bevis

T-027 importerede ophold, T-027 RevPAR og T-028 CSV-demodata er implementeret i
main. Main dokumenterer 29 MySQL-baserede API-tests, herunder RevPAR og import-
regressioner. Dette er ikke PostgreSQL-bevis. Converge-rapporterne fra
2026-10-28 er historiske; ny vurdering efter uge 2 tilføjes i
`specs/converge-tillaeg-uge2.md`.

T-031/T-032 → US-001/US-002 → database/postgres, repositories/database.py, load_school_csv.py → 35 PostgreSQL-tests inkl. importgeneratorer. Se docs/postgres-migration.md.

T-040 → US-002 → demo-init + school_demo.py → 37 backendtests, ren Compose-start, upgrade/persistence → docs/automatic-demo-data.md.
T-041 → (ingen story; Tableau-endpoint) → GET /analytics/revenue/combined → 38 API-/kontrakttests består; Tableau-preview afventer.
T-042 → US-005/US-006 → school_demo.py + realistic_demo_data.py → 38 tests, fresh-volume, idempotens, foundation checks og API-afstemning består; se docs/realistic-demo-data.md.
T-043 → (ingen story; Tableau-endpoint) → GET /analytics/revenue/daily-combined → daglige hotel-/barsalgspunkter og backend-korrelationer til Tableau; automatisk test og Tableau-preview afventer.
T-044 → US-006 → GET /analytics/customer-satisfaction/by-country-room-type → numeriske ratings-, kohorte- og svarprocentrækker pr. land/rumtype; automatisk test og Tableau-preview afventer.
T-045 → (ingen story; ALOS-endpoint) → GET /analytics/bookings/average-stay-length → samlet ALOS samt måned-, værelsestype- og landeopdeling; testet i T-047 (test_average_stay_length.py) og vist i frontend.
T-046 → US-005 → frontend/js/ui/dashboard*.js → analysefane efter opgavens krav og hvid/guld-stil; 66 frontendtests og 19 browser-checks.
T-047 → US-006 (+ opgavekrav uden story) → analysefane med belægning, ALOS og kundetilfredshed; OpenAPI-drift rettet; SWA-svar, README-diagram og Converge opdateret → 41 backendtests, 70 frontendtests, 19 browser-checks.
