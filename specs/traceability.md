# Sporbarhed — tillægsopgave uge 2

## Status

Specifikationsudkast på `feature/tillaeg-uge2`. Ingen ny implementering eller
testverifikation er udført. Derfor står nye krav som **mangler** eller
**planlagt**, selv hvor en nuværende MySQL-baseret API-operation allerede findes.
Den historiske Converge fra 2026-10-28 er bevaret uændret i dens egne filer.

## Story-acceptkriterier

| Krav / acceptkriterie | Spec | Story | Task | Test/verifikationstype | Status |
|---|---|---|---|---|---|
| Bookingformular opretter/redigerer og viser resultat | spec Booking | US-001 | T-035 | Frontendtest + manuel | Planlagt |
| POST 201; komplet idempotent PUT | spec Booking | US-001 | T-030, T-035 | API-test | Planlagt |
| ISO-dato, kapacitet, overlap 409 | spec Booking | US-001 | T-030, T-035 | API-/concurrency-test | Planlagt |
| DELETE soft-cancel/idempotent; genbooking mulig | spec Booking | US-001 | T-030, T-035 | API-test | Planlagt |
| GET-filter/paginering/404 | spec Booking | US-001 | T-030, T-035 | API-test | Planlagt |
| Mutation afspejles i næste GET og analyser uden import | spec Live | US-002 | T-030, T-031, T-035 | Integrationstest | Planlagt |
| CSV/XLSX seed/import reproducerbar og idempotent | spec Data | US-002 | T-030, T-035 | Import-/integrationstest | Planlagt |
| Importerede rækker mærket `synthetic_import`, skrivebeskyttet | spec Data | US-002 | T-030, T-035 | API-/importtest | Mangler |
| Live-definition og ingen push dokumenteret | spec Live | US-002 | T-036 | Dokumentationsreview | Planlagt |
| PostgreSQL uden API-kontraktændring; 26 tests består | constitution, plan | US-002 | T-029, T-030, T-035 | API-/kontrakttest | Mangler |
| Belægningsformel 214 × nætter, eksklusiv checkout | clarify C-005, spec Analyser | US-003 | T-031, T-035 | Formeltest + API-test | Planlagt; formelkonflikt åben |
| Afstem 214 faste værelser mod tidligere aktive-inventar-nævner | clarify C-014 | US-003 | T-031 | Beslutningsreview | Mangler; åben beslutning |
| Periodeklip og annulleringer | clarify C-005/C-006 | US-003 | T-031, T-035 | Golden dataset/API-test | Planlagt |
| Periodeparametre/default | clarify C-003/C-014 | US-003 | T-031, T-032 | OpenAPI-/API-test | Planlagt |
| Nævner nul = 0 med warning | clarify C-005/C-010 | US-003 | T-031, T-032, T-035 | Formel-/API-test | Planlagt |
| Dokumenteret occupancy-endpoint; dashboardtal afstemt | spec Analyser | US-003, US-007 | T-031, T-032, T-034 | OpenAPI, API og manuel afstemning | Planlagt |
| Års- og valgt periodes omsætning | spec Analyser | US-004 | T-031, T-035 | API-test | Planlagt |
| Omsætning pr. type/sæson/land og topresultater | spec Analyser | US-004 | T-031, T-032, T-035 | API-/golden dataset-test | Planlagt |
| Gæster pr. land | spec Analyser | US-004 | T-031, T-032, T-035 | API-test | Planlagt |
| Prislinjer, annullering, sæsonfordeling | clarify C-004/C-007 | US-004 | T-031, T-035 | Formel-/API-test | Planlagt |
| Selvvalgt KPI med formel i API/frontend/dashboard | clarify C-013 | US-004, US-007, US-008 | T-028, T-032–T-034 | API-, frontend- og manuel dashboardtest | **Mangler; blokeret af valg** |
| Tom periode giver tomt resultat | clarify C-010 | US-004 | T-031, T-035 | API-test | Planlagt |
| Analyse-GET endpoints dokumenteret i OpenAPI | clarify C-014 | US-004 | T-031, T-032 | OpenAPI-/kontrakttest | Planlagt |
| Bar-total for Helene Christine | clarify C-008 | US-005 | T-031, T-035 | API-/golden dataset-test | Planlagt |
| Produktomsætning quantity × unit_price | spec Analyser | US-005 | T-031, T-035 | Formel-/API-test | Planlagt |
| Cocktail/kaffe beløb og andele | spec Analyser | US-005 | T-031, T-035 | API-test | Planlagt |
| Nævner nul = 0 med warning | clarify C-010 | US-005 | T-031, T-032, T-035 | API-test | Planlagt |
| Baranalyse dokumenteret som GET/JSON | clarify C-014 | US-005 | T-031, T-032 | OpenAPI-/kontrakttest | Planlagt |
| Én rating 1–5, gentagen PUT opdaterer | clarify C-009 | US-006 | T-030, T-035 | API-/integrationstest | Planlagt |
| Ugyldig/fremtidig/annulleret bedømmelse afvises | clarify C-009 | US-006 | T-030, T-035 | API-test | Planlagt |
| Gennemsnit, svarprocent, antal og fordeling | spec Kundetilfredshed | US-006 | T-031, T-035 | Formel-/API-test | Planlagt |
| Ingen ratings: null og warning | clarify C-010 | US-006 | T-031, T-035 | API-test | Planlagt |
| Tilfredshed GET dokumenteret og afstemt | clarify C-014 | US-006, US-007, US-008 | T-031, T-032, T-034 | OpenAPI, API og manuel afstemning | Planlagt |
| Tableau viser alle besluttede KPI'er | clarify C-016 | US-007 | T-028, T-034 | Manuel dashboardreview | Mangler; Tableau-krav åbent |
| Dashboardfiltre virker | clarify C-016 | US-007 | T-034 | Manuel dashboardtest | Mangler; Tableau-krav åbent |
| Dashboardtal fra API, ikke database | constitution Analysebarhed | US-007 | T-034 | Kildereview og manuel afstemning | Planlagt |
| Refresh-kilde/procedure og bookingændring vises | clarify C-001/C-016 | US-007 | T-034 | Manuel refresh-demonstration | Mangler; Tableau-krav åbent |
| Frontend viser analyser US-003–US-006 | spec Frontend | US-008 | T-033 | Frontend-/browsertest | Mangler |
| Frontend henter kun API-data; ingen egne beregninger/DB | constitution Analysebarhed | US-008 | T-033 | Kilde-review + browsertest | Mangler |
| Periode og valgte filtre opdaterer visning | clarify C-015 | US-008 | T-033 | Frontend-/browsertest | Mangler; opdateringsmåde åben |
| Tomme data og fejl har tydelige UI-tilstande | spec Frontend | US-008 | T-033 | Frontend-/browsertest | Mangler |
| Ny booking ses ved næste opdatering/indlæsning | clarify C-001/C-015 | US-008 | T-033, T-035 | Integration-/browsertest | Mangler |

## Tværgående leverancer

| Krav | Spec | Stories | Task | Test/verifikationstype | Status |
|---|---|---|---|---|---|
| PostgreSQL runtime og migration fra MySQL-dialekt | constitution, plan | US-002 | T-029, T-030 | Compose-, migration- og integrationstest | Mangler |
| Samme API-kontrakt | constitution, spec | US-002 | T-031, T-032, T-035 | OpenAPI-lighed + API-regression | Mangler |
| Compose start, healthcheck, persistence | constitution, plan | US-002 | T-029 | Manuel Compose-smoke | Mangler |
| Sikkert PostgreSQL-testreset | plan | US-002 | T-030, T-035 | Negativ sikkerheds-/integrationstest | Mangler |
| README, guides og analysevejledning | tasks | US-002, US-007, US-008 | T-036 | Dokumentationsreview/clean checkout | Planlagt |
| Samlet Converge og rapportering af gaps | constitution | — (leverance) | T-037 | Converge-review | Mangler |

## Historik

Den oprindelige traceability- og implementeringsstatus for T-020–T-026 fremgår af
`specs/converge-api-2026-10-28.md` og `specs/converge-2026-10-28.md`. De rapporter
er historiske og er ikke ændret af denne specifikationsrevision. Deres MySQL-
testresultater dokumenterer v1 og er ikke PostgreSQL-testbevis.
