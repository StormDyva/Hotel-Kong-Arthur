# Sporbarhed — tillægsopgave uge 2

## Status

Denne matrix skelner mellem nuværende MySQL-baseret kode fra main og manglende
PostgreSQL-/frontendarbejde. De seneste ændringer er flettet fra main, men tests
er ikke genkørt som del af konfliktløsningen. PostgreSQL-bevis findes ikke endnu.
Converge-rapporten fra 2026-10-28 er historisk og må ikke omskrives.

Main indeholder task-id-kollisioner: T-027 blev brugt både til importerede ophold
og RevPAR. De omtales nedenfor med opgavenavn. T-028 er CSV-demodata.

## Story-acceptkriterier

| Krav / acceptkriterie | Spec | Story | Task | Test/verifikationstype | Status |
|---|---|---|---|---|---|
| Bookingformular opretter/redigerer og viser resultat | spec Booking | US-001 | T-025, T-037 | Frontendtest + manuel browserkontrol | Implementeret i main; ikke genverificeret her |
| POST 201; komplet idempotent PUT | spec Booking | US-001 | T-008, T-037 | API-test | Eksisterende v1-testdækning; PostgreSQL mangler |
| ISO-dato, kapacitet, overlap 409 | spec Booking | US-001 | T-008, T-037 | API-/concurrency-test | Eksisterende v1-testdækning; PostgreSQL mangler |
| DELETE soft-cancel/idempotent; genbooking mulig | spec Booking | US-001 | T-008, T-037 | API-test | Eksisterende v1-testdækning; PostgreSQL mangler |
| GET-filter/paginering/404 | spec Booking | US-001 | T-008, T-037 | API-test | Eksisterende v1-testdækning; PostgreSQL mangler |
| Mutation ses i næste GET/analyse uden genimport | spec Live | US-002 | T-009, T-037 | Integrationstest | Implementeret mod nuværende DB; PostgreSQL mangler |
| CSV/XLSX seed/import reproducerbar og idempotent | spec Data | US-002 | T-028, T-032, T-037 | Import-/integrationstest | T-028 dokumenterer gennemført import; PostgreSQL-genimport mangler |
| Importerede rækker har `synthetic_import` og er skrivebeskyttede | spec Data | US-002 | T-027 (importerede ophold), T-037 | API-/runtime-test | Implementeret i main; ikke genverificeret her |
| Live-definition og ingen push dokumenteret | clarify C-001 | US-002 | T-009, T-038 | Dokumentationsreview | Dækket i specifikation; implementation følger næste GET |
| PostgreSQL uden API-kontraktændring | constitution, plan | US-002 | T-031, T-032, T-034, T-037 | API-/kontrakttest | Mangler |
| Eksisterende 29 API-tests samt concurrency består mod PostgreSQL | tasks | US-002 | T-037 | API-/concurrency-test | Mangler; aktuelle tests er MySQL-baserede |
| Belægningsformel og eksklusiv checkout | clarify C-005/C-014 | US-003 | T-033, T-037 | Formel-/API-test | API findes; fast 214 vs aktiv inventarnævner er åben |
| Periodeklip og annulleringer | clarify C-005/C-006 | US-003 | T-033, T-037 | Golden dataset/API-test | Eksisterende v1-dækning; ny formelafstemning mangler |
| Periodeparametre/default | clarify C-003/C-014 | US-003 | T-033, T-034 | OpenAPI-/API-test | API findes; godkendt kontraktreview mangler |
| Nævner nul = 0 med advarsel | clarify C-005/C-010 | US-003 | T-033, T-034, T-037 | Formel-/API-test | Eksisterende endpoint; formelafstemning mangler |
| Occupancy-GET og dashboardtal afstemt | spec Analyser | US-003, US-007 | T-033, T-034, T-036 | OpenAPI, API og manuel afstemning | API findes; samlet dashboardafstemning mangler |
| Års- og periodesomsætning | spec Analyser | US-004 | T-033, T-037 | API-test | Eksisterende MySQL-baseret endpoint |
| Omsætning pr. type/sæson/land og topresultater | spec Analyser | US-004 | T-033, T-034, T-037 | API-/golden dataset-test | Eksisterende MySQL-baserede endpoints |
| Gæster pr. land | spec Analyser | US-004 | T-033, T-034, T-037 | API-test | Eksisterende endpoint; PostgreSQL mangler |
| Prislinjer, annullering og sæsonfordeling | clarify C-004/C-007 | US-004 | T-033, T-037 | Formel-/API-test | Eksisterende v1-dækning; PostgreSQL mangler |
| RevPAR = værelsesomsætning / disponible værelsesnætter | spec T-027 (RevPAR) | US-004 | T-027 (RevPAR), T-037 | `test_revpar.py` + API-test | Implementeret i main; ikke genverificeret her |
| Selvvalgt KPI med formel i API/frontend/dashboard | clarify C-013 | US-004, US-007, US-008 | T-030, T-034–T-036 | API-, frontend- og manuel dashboardtest | **Mangler; valg åbent. RevPAR findes som kandidat** |
| Tom periode giver tomt resultat | clarify C-010 | US-004 | T-033, T-037 | API-test | Eksisterende v1-endpoints; PostgreSQL mangler |
| Analyse-GET dokumenteret i OpenAPI | clarify C-014 | US-004 | T-033, T-034 | OpenAPI-/kontrakttest | Nuværende paths findes; ændringer afventer kontraktbeslutning |
| Bar-total for Helene Christine | clarify C-008 | US-005 | T-012, T-037 | API-/golden dataset-test | Eksisterende MySQL-baseret endpoint |
| Omsætning pr. drink = quantity × unit_price | spec Analyser | US-005 | T-012, T-037 | Formel-/API-test | Eksisterende v1-dækning |
| Cocktail/kaffe beløb og andele | spec Analyser | US-005 | T-012, T-037 | API-test | Eksisterende v1-dækning |
| Nævner nul = 0 med advarsel | clarify C-010 | US-005 | T-012, T-034, T-037 | API-test | Eksisterende endpoint; PostgreSQL mangler |
| Baranalyse dokumenteret som GET/JSON | clarify C-014 | US-005 | T-033, T-034 | OpenAPI-/kontrakttest | Findes i nuværende OpenAPI; review mangler |
| Én rating 1–5; gentagen PUT opdaterer | clarify C-009 | US-006 | T-013, T-032, T-037 | API-/integrationstest | Eksisterende v1-dækning |
| Ugyldig/fremtidig/annulleret bedømmelse afvises | clarify C-009 | US-006 | T-013, T-032, T-037 | API-test | Eksisterende v1-dækning |
| Gennemsnit, svarprocent, antal og fordeling | spec Kundetilfredshed | US-006 | T-013, T-033, T-037 | Formel-/API-test | Eksisterende endpoint; PostgreSQL mangler |
| Ingen ratings giver null og advarsel | clarify C-010 | US-006 | T-013, T-033, T-037 | API-test | Eksisterende v1-dækning |
| Tilfredshed-GET dokumenteret og afstemt | clarify C-014 | US-006, US-007, US-008 | T-033, T-034, T-036 | OpenAPI, API og manuel afstemning | API findes; UI-/dashboardafstemning mangler |
| Tableau viser besluttede KPI'er | clarify C-016 | US-007 | T-030, T-036 | Manuel dashboardreview | Mangler; Tableau-krav åbent |
| Dashboardfiltre virker | clarify C-016 | US-007 | T-036 | Manuel dashboardtest | Mangler; Tableau-krav åbent |
| Dashboardtal hentes fra API, ikke DB | constitution Analysebarhed | US-007 | T-036 | Kildereview + manuel afstemning | API-handoff findes; dashboardreview mangler |
| Refresh-procedure og bookingændring demonstreret | clarify C-001/C-016 | US-007 | T-036 | Manuel refresh-demonstration | Mangler; Tableau-krav åbent |
| Frontend viser analyser fra US-003–US-006 | spec Frontend | US-008 | T-035 | Frontend-/browsertest | Mangler |
| Frontend bruger API uden egne formler/DB-adgang | constitution Analysebarhed | US-008 | T-035 | Kildereview + browsertest | Mangler |
| Periode/filtre opdaterer frontend | clarify C-015 | US-008 | T-035 | Frontend-/browsertest | Mangler; opdateringsmåde åben |
| Tomme data og API-fejl vises tydeligt | spec Frontend | US-008 | T-035 | Frontend-/browsertest | Mangler |
| Ny booking ses efter genindlæsning/opdatering | clarify C-001/C-015 | US-008 | T-035, T-037 | Integration-/browsertest | Mangler |

## Tværgående leverancer

| Krav | Spec | Stories | Task | Test/verifikationstype | Status |
|---|---|---|---|---|---|
| PostgreSQL runtime og SQL-dialektskift | constitution, plan | US-002 | T-031, T-032 | Compose-, migrations- og integrationstest | Mangler |
| Samme API-kontrakt efter databaseskift | constitution, spec | US-002 | T-033, T-034, T-037 | OpenAPI-lighed + API-regression | Mangler |
| Compose healthcheck, start og persistence | constitution, plan | US-002 | T-031 | Manuel Compose-smoke | Mangler |
| Sikkert PostgreSQL-testreset | plan | US-002 | T-032, T-037 | Negativ sikkerheds-/integrationstest | Mangler |
| README, guides og analysevejledning | tasks | US-002, US-007, US-008 | T-038 | Dokumentationsreview/clean checkout | Dokumenteret; runtimevejledninger afventer PostgreSQL |
| Afsluttende Converge | constitution | — (leverance) | T-039 | Converge-review | Mangler |

## Historik og eksisterende bevis

T-027 importerede ophold, T-027 RevPAR og T-028 CSV-demodata er implementeret i
main. Main dokumenterer 29 MySQL-baserede API-tests, herunder RevPAR og import-
regressioner. Dette er ikke PostgreSQL-bevis. Converge-rapporterne fra
2026-10-28 er historiske; ny vurdering efter uge 2 tilføjes i
`specs/converge-tillaeg-uge2.md`.
