# Tasks

## Status

Historiske tasks fra 2026-10-26/28 bevares som udført eller tidligere planlagt
arbejde. T-031/T-032 er klar til review med PostgreSQL-testbevis; øvrige uge 2-tasks har separat status.

## Dokumentation og beslutninger

### T-001 – PDF/spec-gennemgang

**Status:** Completed – 2026-10-26.

- Stories: alle.
- Afhængighed: eksisterende dokumentationscommit.
- Område: specs/.
- Accept: PDF-krav sammenlignet med alle specs; gaps, antagelser og afgrænsning for kundetilfredshed dokumenteret.
- Test/verifikation: manuel traceability-review og git diff --check.

### T-002 – Godkend krav og åbne beslutninger

**Status:** Completed – 2026-10-26.

- Stories: alle.
- Afhængighed: T-001.
- Område: specs/clarify.md, constitution.md, decisions.
- Accept: standardår, sæson, DELETE/annullering, Helene-filter, pris, live-refresh og kundetilfredshed har ejer, dato og Approved status.
- Test/verifikation: gruppereview og traceability-status.

## Database, import og drift

### T-003 – MySQL-schema og datadictionary (ændret i tillægsopgave uge 2)

- Stories: US-001–US-010.
- Afhængighed: T-002.
- Område: database/migrations/, docs/data-dictionary.md.
- Accept: relationer, kardinaliteter, obligatoriske/valgfrie felter, status, DKK, UTC/Europe-Copenhagen, 214 værelser, 8 typer, capacity constraint og indeks er implementerbare.
- Test: migration på ren MySQL, constraint-tests og schema-review.

### T-004 – Seed og CSV/XSLT-import (ændret i tillægsopgave uge 2)

- Stories: US-005, US-010.
- Afhængighed: T-003.
- Område: database/seed/, importdokumentation.
- Accept: eksempeldata mappes til MySQL, import er reproducerbar, genkørsel/dubletter er dokumenteret, live-flow er adskilt.
- Test: seed/import smoke test og kontrol af antal/relationsfejl.

### T-005 – Import af kundedata fra ITAKEA/hoteldata (ændret i tillægsopgave uge 2)

- Stories: US-005, US-008, US-010.
- Afhængighed: T-003 og T-004.
- Område: database/migrations/, database/import/, database/tests/, docs/.
- Accept: kundens filer profileres, mapping dokumenteres, importen er reproducerbar og idempotent, ufuldstændige rækker afvises, og bookingmodellen ændres ikke utilsigtet.
- Test: ren MySQL, import to gange, relationstjek, afvisningsrapport og eksisterende booking-/prislinjetjek.

### T-005-Docker – Docker Compose og miljø (ændret i tillægsopgave uge 2)

- Stories: US-005, US-012.
- Afhængighed: T-003.
- Område: docker-compose.yml, .env.example, README.
- Accept: api, db og eventuelt frontend starter med healthcheck, persistent volume og ingen secrets.
- Test: docker compose config og docker compose up --build.

## API og backend

### T-006 – 3-lags FastAPI-struktur og health

- Stories: US-012.
- Afhængighed: T-003 og T-005-Docker.
- Område: backend/src/, backend/tests/.
- Accept: API-, service- og repository-lag kan inspiceres; /health kontrollerer API/database.
- Test: pytest health og laggrænse-review.

### T-007 – OpenAPI-kontrakt og Swagger UI

- Stories: US-001–US-010.
- Afhængighed: T-002 og T-006.
- Område: openapi/openapi.yaml, API schemas.
- Accept: normative schemas, endpoints, filtre, pagination, statuskoder, idempotens og fejlformat er beskrevet; Swagger viser samme kontrakt.
- Test: OpenAPI-linter/validator og kontrakttests.

### T-008 – Booking CRUD, status og validering

- Stories: US-001–US-005.
- Afhængighed: T-003, T-006 og T-007.
- Område: API, services, repositories, models og tests.
- Accept: POST 201, GET/404, fuld idempotent PUT, idempotent soft-cancel DELETE, kapacitet og overlap virker.
- Test: pytest booking, concurrency/transaction-test og API-fejltest.

### T-009 – Live API-flow (ændret i tillægsopgave uge 2)

- Stories: US-005.
- Afhængighed: T-008.
- Område: API, frontend-integration, docs.
- Accept: POST/PUT/DELETE → MySQL → næste GET er demonstreret; ingen WebSocket-krav skjules; CSV-flow er adskilt.
- Test: end-to-end live update smoke test.

## Analyse

### T-010 – Periode- og sæsonservice

- Stories: US-006, US-007.
- Afhængighed: T-002 og T-008.
- Område: services, repositories, tests.
- Accept: ISO-perioder, UTC/local regler, eksklusiv check-out, periodeklip og pr.-nat sæsonfordeling virker.
- Test: grænse-, krydsperiode- og krydssæson-tests.

### T-011 – Hotelanalyse

- Stories: US-006, US-007.
- Afhængighed: T-010.
- Område: analytics services/repositories, API, OpenAPI.
- Accept: belægning, total, årsindtjening, room type/sæson/land, top room type/land og ekstra KPI returneres med filtre/metadata.
- Test: formeltests, golden dataset og API-tests.

### T-012 – Cocktailbaranalyse

- Stories: US-008.
- Afhængighed: T-003, T-007 og T-002.
- Område: bar services/repositories, API, OpenAPI.
- Accept: Helene-filter, produktomsætning, cocktail/kaffe-procenter, periode og division med nul virker.
- Test: bar golden dataset og API-tests.

### T-013 – Kundetilfredshed: afgrænsning eller aktivering

- Stories: US-011.
- Afhængighed: T-002.
- Område: specs/traceability.md og eventuelt særskilt model/API/analytics/Tableau.
- Accept: MVP-afgrænsning er accepteret, eller alle ekstra artefakter og tests er tilføjet før implementation.
- Test: beslutningsreview; ved aktivering model-, API- og analyse-tests.

## Frontend, Tableau og aflevering

### T-014 – Booking-frontend

- Stories: US-001–US-005.
- Afhængighed: T-007 og T-009.
- Område: frontend/.
- Accept: liste, filter, opret, redigér, annullér, fejl og loading vises; mutationer rammer API’et.
- Test: manuel browser-smoke-test og live-flow.

### T-015 – Tableau-dashboard og refresh

- Stories: US-006–US-009.
- Afhængighed: T-011 og T-012.
- Område: tableau/, docs/.
- Accept: hotel/bar-KPI’er, filtre, Helene-view, datakilde og manuel/planlagt refresh er dokumenteret; KPI’er stemmer.
- Test: Tableau KPI-afstemning mod golden dataset og refresh-test.

### T-016 – README, CONTRIBUTING/CONTRIBUTE og arkitekturdiagram

- Stories: US-012.
- Afhængighed: T-005, T-007, T-014 og T-015.
- Område: README.md, CONTRIBUTING.md, eventuelt CONTRIBUTE.md, docs/.
- Accept: README har arkitekturdiagram, setup, API/Swagger, seed, tests og demo; PDF-kravets filnavn er afklaret.
- Test: ny udvikler følger README fra ren checkout.

### T-017 – Samlet test og CI (ændret i tillægsopgave uge 2)

- Stories: alle.
- Afhængighed: T-006–T-016.
- Område: backend/tests/, CI, docs/testing.md.
- Accept: unit, integration, API, OpenAPI, Docker, frontend, live-flow og Tableau er dækket eller begrænsninger dokumenteret.
- Test: pytest, OpenAPI-validator, docker compose config, smoke suite og git diff --check.

### T-018 – Converge-resultat og præsentation

- Stories: US-012.
- Afhængighed: T-017.
- Område: specs/traceability.md, docs/, præsentationsmateriale.
- Accept: sidste Converge vurderer hver matrixrække som implementeret, delvist implementeret eller mangler; mangler får ny task/ejer; 10-minutters demo er gennemgået.
- Test: Converge-review og ren demo.

## Kvalitetstjek

- Er hver task entydig? Ja, med story, afhængighed, område, accept og test.
- Kan tasks implementeres? Ja efter T-002.
- Kan de testes? Ja, hver task har konkret test/verifikation.
- Dækker de alle PDF-krav? Ja, se traceability.md.
- Er kundetilfredshed håndteret? Ja, som eksplicit afgrænsning eller aktivering i T-013.

## Integration run — 2026-10-28

Work proceeds in dependency order on `feature/T-009-live-api-tableau` under the user
request to connect the application, MySQL and Tableau according to both PDFs.
T-006/7/8/9 implement the API foundation, contract, CRUD and live dataflow;
T-010/11/12 add nightly hotel/bar analytics; T-014 uses the API by default;
T-015 generates API-backed Hyper extracts and a native workbook; T-016 supplies
startup and SWA explanations. These are implementation results, not assertions of
team approval or full task completion. See `converge-2026-10-28.md` for evidence/gaps.

## T-020 — API op til opgavekrav (2026-10-28; ændret i tillægsopgave uge 2)

Brugeren har prioriteret API og Swagger; Tableau bygges manuelt senere.
Stories: US-001–US-008, US-011–US-012. Afhængigheder: eksisterende API/MySQL.
Accept: særskilte OpenAPI-endpoints, bookingfiltre (status/room/guest/dato),
analysefiltre (år/periode/land/type/sæson/medarbejder), gæstefordeling, indtjening
pr. fysisk værelse/type/sæson/land og rangering, Helene-total/drinks/kategoriandele,
barregistrering, samt 1–5 bedømmelse pr. afsluttet booking. Swagger skal fungere
med lokalt serverede assets. Tests mod MySQL, OpenAPI-validering og Swagger-browser.
Ingen Tableau-ændringer indgår.

### Kundetilfredshed — brugerbeslutning
Brugeren har valgt 1–5 pr. booking. PUT på bookingens review opretter eller erstatter
én bedømmelse. Kun afsluttede, ikke-annullerede bookinger kan bedømmes.
Svarprocent = bedømte / afsluttede bookinger med checkout i rapportperioden * 100.
Ingen bedømmelser giver average_rating=null, antal=0 og warning, ikke opdigtede scores.

### T-020 resultat

Booking-/analysefiltre, selvstændige rapport-endpoints, barsalg, ratings, typed
OpenAPI/fejl, lokale Swagger-assets og syntetisk referenceinventar er implementeret.
Testbevis og formler: converge-api-2026-10-28.md. T-019 dækkes af eksplicit syntetisk
referenceinventar. T-021 kundetilfredshed er aktiveret efter brugerens beslutning.
Tableau-delene af tidligere T-020 er udskudt til brugerens manuelle arbejde.

## T-022 — Flade indtjeningsrækker til Tableau (ændret i tillægsopgave uge 2)

Brugerkrav: GET /analytics/revenue/by-room-type-season og
GET /analytics/revenue/by-country returnerer arrays med færdigberegnet indtjening.
Service-laget summerer gemt natpris × antal nætter (natlige prislinjer og quantity).
Alle otte typer × tre sæsoner medtages, også ved 0. Ingen Tableau-beregninger.
Beløb returneres som JSON-tal i DKK. Filtre: year eller from/to, samme periodevalg
som øvrige analyser. Annullerede bookinger udelades, checkout er eksklusiv.
Test: 24 kombinationer, nulperiode, sæson-/periodegrænse, landegruppering og kontrakt.

## T-023 — Gæstesnapshots, bedømmelsesintegritet og eksport (ændret i tillægsopgave uge 2)

Ret de reproducerede reviewfund. API-oprettelse får selvstændig gæsterække pr.
booking; kontaktændringer bruger copy-on-write, uændret PUT genbruger samme række.
Navn/land fjernes som unik identitet. Historisk import bruger eksplicit kilde-ID.
Bedømt booking afviser ændring af navn/land, datoer, værelse eller selskabsstørrelse
med 409; email/telefon må rettes. Tableau-guests bruger booking_guests.
Accept: regressionstests mod MySQL, idempotent import og eksportdata med fire gæster.
Tableau-dashboardets samlede opdateringsdemo er fortsat ikke godkendt.


## T-024 — Compose og dokumentationsafstemning før PR-accept (ændret i tillægsopgave uge 2)

Accept: ren Compose-opstart og containeriserede API-/kontrakttests i separat
projekt; proxy, custom porte/CORS, persistens og OpenAPI kontrolleret. README,
startguide, projektguide, datadictionary, frontend, Tableau, import, SWA og specs
skal beskrive nuværende adfærd; gamle rapporter markeres historiske. Samlet
Tableau-accept må ikke hævdes. Testbevis: docs/release-checklist.md.

## T-025 — enkel bookingprototype mod rigtig API (ændret i tillægsopgave uge 2)

US-001/002/005. Bevar enkelt søg → værelse → gæst → bekræft-flow. Vis ét ledigt
forslag pr. type som standard med mulighed for typefilter/alle rum. Brug API-priser,
send ikke klientberegnet pris, vis feltfejl og genvej til oversigten. Accept: browser
opretter en booking mod MySQL, genfinder den efter reload, og testbookingen annulleres.

## T-026 — API-PR klar til manuel Tableau-integration (ændret i tillægsopgave uge 2)

Acceptomfang: API, bookingprototype og dokumenteret Tableau-datakontrakt/refresh.

## T-027 — eksponér importerede ophold som syntetiske API-bookinger

Brugerønske: de 1.000 importerede ophold skal kunne hentes fra `/api/bookings`.
Generér deterministiske datoer, værelser og én gæst pr. ophold. Bevar kildebeløb,
opholdslængde, værelseskategori, land og sæson. Marker `data_origin` i API-kontrakten,
anonymisér gæsten i API-svar, og gør disse rækker skrivebeskyttede. Kør seed automatisk
ved databaseinitialisering; seed skal kunne genkendes via batch og kilde-row.
Dashboardet bygges manuelt senere og blokerer ikke denne API-PR. Containeriserede
tests, numeriske 24-rækkers exports og KPI-endpoints genkontrolleres, PR-beskrivelsen
samles om den færdige implementering og PR markeres ready for review, uden merge.
Se docs/tableau-api-handoff.md.

## Tillægsopgave uge 2 — nye tasks

Main indeholder allerede T-027 for importerede ophold og T-028 for CSV-demodata.
To indgående branches brugte også T-027 til henholdsvis importerede ophold og
RevPAR; de historiske betegnelser bevares med emneangivelse for at undgå at
overskrive arbejde. Nye uge 2 tasks starter derfor ved T-029.

### T-027 (importerede ophold) — Eksponér syntetiske API-bookinger (ændret i tillægsopgave uge 2)

- **Status:** Gennemført i main; historisk task.
- **Stories:** tillægsopgave, nu sporet i US-002.
- **Accept:** de 1.000 ophold kan hentes via `/api/bookings`, har deterministiske
  datoer/værelser og én gæst pr. ophold, bevarer kildefelter, angiver
  `data_origin`, anonymiserer og er skrivebeskyttede.
- **Verifikation:** API-/Compose-runtimekontrol dokumenteret i main.

### T-027 (RevPAR) — Beregn RevPAR i backend (ændret i tillægsopgave uge 2)

- **Status:** Gennemført i main; historisk task.
- **Stories:** Ingen (US-004/US-007 fjernet 2026-11-06, C-018); endpoint bevaret.
- **Accept:** `GET /api/analytics/revpar` leverer RevPAR og månedsrækker med
  periode/type/land/sæsonregler, nulnævner og API/OpenAPI-dokumentation.
- **Verifikation:** `test_revpar.py` og MySQL-testbevis i main.

### T-028 — CSV-kildedata og ekstra skoleprojekt-bookinger (ændret i tillægsopgave uge 2)

- **Status:** Gennemført i main; historisk task.
- **Stories:** US-002.
- **Accept:** bevar 1.000 rækker og deres syv kildefelter i lokal JSON, forbind til
  kildebookinger, tilføj 100 særskilte mock-bookinger; genkørsel er idempotent,
  rå CSV/navne committes ikke.
- **Verifikation:** importerens runtimekontrol og gentagen indlæsning i main.

### T-029 — Sikr og bevar v1 i Git

- **Status:** Gennemført.
- **Stories:** ingen; Git-sikring er projektleverance under constitution.
- **Accept:** annoteret `v1-mysql-tableau` tag og branch på commit `366534b` er
  pushet; `feature/tillaeg-uge2` er oprettet; README beskriver checkout og start.
- **Verifikation:** Git remote/tag/branch-status kontrolleret.

### T-030 — Vælg og definér selvvalgt nøgletal

- **Status:** Valgt og defineret af brugeren 2026-11-05: gennemsnitlig opholdslængde (ALOS). Implementeret under T-045; automatisk verifikation afventer.
- **Stories/accept:** Ingen (US-004/US-007/US-008 fjernet 2026-11-06, C-018).
- **Formel/kohorte:** bekræftede bookinger valgt på check-in-dato; hele opholdets
  nætter / antal bookinger. Tom kohorte returnerer null-gennemsnit og nul counts.
- **Afhængighed:** beslutningen er dokumenteret i Clarify; se T-045 for endpoint
  og Tableau-kontrakt.

### T-031 — PostgreSQL Compose og miljø

- **Status:** Klar til review; Compose, persistence og ren installation verificeret 2026-11-03.
- **Story/accept:** US-002; PostgreSQL, persistence, `pg_isready`, testservice og
  én `docker compose up --build`.
- **Afhængighed:** T-029; C-012 afklaret. Lokal port kontrolleres før valg.
- **Verifikation:** Compose config, start/healthcheck og volume-persistens.

### T-032 — PostgreSQL schema, repositories, seed og import

- **Status:** Klar til review; schema, repositories, fixtures, CSV-/XLSX-import og generatorer verificeret med 35 PostgreSQL-tests.
- **Stories/accept:** US-001 og US-002; PostgreSQL schema/seed/import, samme
  forretningsregler og idempotent genkørsel; importerede rækker bevares som
  `synthetic_import` og skrivebeskyttede.
- **Afhængighed:** T-031. Genindlæs fra CSV/XLSX; ingen MySQL-datamigrering.
- **Omfang:** psycopg 3 / `DATABASE_URL`, SQL-dialekt, constraints,
  casesensitiv filtrering, låsning og PostgreSQL-sikkert testreset.
- **Verifikation:** migration, import, persistence, reset-sikkerhed,
  bookingconcurrency og regressions/API-tests.

### T-033 — Analysekontrakt og endpoint-dækning

- **Status:** Analyseinventar udført; kontraktafklaring afventer C-014.
- **Stories/accept:** US-005 og US-006.
- **Afhængighed:** review af eksisterende paths i `plan.md`, derefter Clarify.
- **Accept:** afgør om eksisterende analyser dækker kravene og eventuelle præcise
  path-, parameter-, respons-, fejl- og warning-ændringer.
- **Verifikation:** endpoint-/acceptkriteriemapping og kontraktreview.

### T-034 — OpenAPI og Swagger for godkendte analysekontrakter

- **Status:** Ikke startet.
- **Stories/accept:** US-005 og US-006; dokumenter godkendte analyseparametre og
  responser uden utilsigtet kontraktændring.
- **Afhængighed:** T-033 og T-030 for KPI-specifik kontrakt.
- **Verifikation:** OpenAPI-validering, runtime-schema-lighed og Swagger-review.

### T-035 — Analysevisninger i frontend

- **Status:** Ikke startet; ny frontendfunktion.
- **Stories/accept:** Ingen (US-008 fjernet 2026-11-06, C-018); vis analyser fra API med filtre,
  loading/tom-/fejltilstand og bookingopdatering.
- **Afhængighed:** T-033; T-030 for valgt KPI; C-015 for opdateringsmåde.
- **Verifikation:** browser-/frontendtests mod REST API og manuel UI-review.

### T-036 — Tableau kobles til API og afstemmes

- **Status:** REST API Connector valgt af brugeren 2026-11-03; manuel dashboard-/refresh-verifikation udestår.
- **Afgrænsning:** Ingen portering af legacy CSV/Hyper-eksport eller workbook-generator.
- **Stories/accept:** Ingen (US-007 fjernet 2026-11-06, C-018); API som eneste beregningskilde, filtre, refresh og
  afstemning på kendt datasæt.
- **Afhængighed:** C-016, T-033 og T-030 for valgt KPI.
- **Verifikation:** Tableau-demo/refresh og manuel afstemning mod API-tal.

### T-037 — Regression- og PostgreSQL-testdækning

- **Status:** Ikke startet.
- **Stories/accept:** US-001, US-002, US-005 og US-006; de nuværende 29 API-tests (inklusive de
  oprindelige 26) og bookingconcurrency skal bestå mod PostgreSQL.
- **Afhængighed:** T-031–T-035.
- **Verifikation:** API-/kontrakt-/frontendtests og testreset-spærre.

### T-038 — Dokumentation for PostgreSQL og analyseforbrug

- **Dokumentationstilføjelse 2026-11-03:** docs/tableau-rest-endpoints.md giver URLs, JSONPath, felter og dataset-/paginationbegrænsninger. API-responsers paths kontrolleres; Tableau-UI er fortsat manuel verifikation.

- **Status:** Ikke startet; ændret i tillægsopgave uge 2.
- **Stories/accept:** US-002 og projektleverance.
- **Afhængighed:** T-031–T-036.
- **Omfang:** README, guides, bidragsvejledninger, datagrundlag, API-testing,
  Tableau-handoff og analyse-API-vejledning.
- **Verifikation:** dokumentationsreview og clean-checkout walkthrough.

### T-039 — Converge efter tillægsopgave uge 2

- **Status:** Ikke startet; kommende leverance, ikke en brugerstory.
- **Afhængighed:** T-037 samt relevante dele af T-036/T-038.
- **Accept:** vurder alle aktuelle sporbarhedsrækker med testbevis, ejere og gaps.
  Historisk Converge fra 2026-10-28 må ikke omskrives.
- **Verifikation:** ny Converge-fil og matrixreview.

## Kvalitetstjek — tillægsopgave uge 2

- Dækning: målrettet mod de otte nye stories; status er planlagt, ikke verificeret.
- Afhængigheder: C-013 er afklaret som ALOS; C-014–C-016 afklarer kontrakt,
  frontendopdatering og Tableau-omfang.
- Testbarhed: PostgreSQL-, API-, concurrency-, frontend- og manuel Tableau-
  verifikation er planlagt, men ikke udført i specifikationsopgaven.

### T-040 — Komplet skole-demo ved første Compose-start

- **Status:** Implementeret; 37 backend-/importtests og ren Compose-opstart verificeret.
- **Stories/accept:** US-002; samme komplette 2026-datasæt hos alle studerende.
- **Omfang:** demo-init efter schema/seed og før API; 1.000 kildeophold + 100 ekstra
  mocks i 2026 uden eksterne CSV/XLSX. Fire basisbookinger giver 1.104 i alt.
- **Opgradering:** gamle volumes med fremtidige kildeophold opdateres én gang;
  eksisterende 2026-ophold, operational-bookinger og gamle mocks bevares.
- **Verifikation:** friskt Compose-projekt, 21 lande/24 type-sæsonkombinationer,
  gentagen startup, eksisterende volume, ingen overlap/dubletter og rollback ved fejl.
- **Kontrakt:** ingen ændring af API eller OpenAPI; oprindelige kildepriser bevares.

### T-041 — Kombineret hotel- og baromsætning til Tableau

- **Story:** Ingen (US-007 fjernet 2026-11-06, C-018).
- **Status:** API implementeret på `feature/T-041-combined-tableau-revenue`; 38 API-/kontrakttests består. Manuel Tableau-preview afventer.
- **Omfang:** `GET /analytics/revenue/combined` returnerer ét root-array med én
  række og numeriske `hotelRevenue`, `barRevenue` og `totalRevenue`. Backend
  bruger samme periode på begge datasæt; baromsætningen omfatter daterede salg
  for alle medarbejdere. Udaterede importerede drinkaggregater udelades.
- **Tableau:** JSONPath `$[*]`; beregnet felt `SUM([hotelRevenue]) + SUM([barRevenue])`.
- **Accept:** API- og OpenAPI-kontrakt matcher; periodegrænser og summer afstemmes
  mod hotelprislinjer og daterede barsalg; Tableau connector-preview gennemgås.

### T-042 — Realistiske 2026-demoanalyser

- **Stories:** US-005, US-006.
- **Status:** Implementeret på `feat/realistic-demo-data`; 38 backendtests, frisk Compose-volume, idempotent genstart, foundation checks og US-005/US-006 API-kald verificeret. Manuel Tableau UI-test er ikke udført.
- **Omfang:** Udvid `demo-init` idempotent med daterede transaktioner fra accepterede
  drinkaggregater og realistiske anmeldelser for afsluttede ophold. Ingen schema- eller
  API-kontraktændring; `csv_source_rows` syntetiseres ikke.
- **Accept:** deterministiske 2026-rækker, produktmængder/priser afstemt, 30–50 %
  anmeldelsessvar, FK/CHECK- og datogrænser kontrolleret; ren-volume opstart og
  gentagelse giver samme rækker; US-005/US-006 API-tal afstemmes. Detaljer og
  optælling før ændring: `docs/realistic-demo-data.md`.

### T-043 — Daglig hotel/bar-sammenhæng til Tableau

- **Story:** Understøtter US-005 (US-004/US-007 fjernet 2026-11-06).
- **Status:** Endpoint implementeret på `feat/tableau-bar-occupancy-correlation`;
  automatisk test og Tableau-preview afventer.
- **Omfang:** `GET /analytics/revenue/daily-combined` returnerer daglig hotel- og
  baromsætning, gæstenætter, værelsesnætter og belægning samt backendberegnede
  Pearson-korrelationer. Alle medarbejderes daterede barsalg medtages; kun
  bekræftede ophold indgår.
- **Tableau:** `$.data[*]` til daglige punkter; `$.correlations` til KPI-kort.
  Demoens bartransaktioner er vægtet efter belægning, weekend og sæson, så en
  observeret korrelation er syntetisk og kun illustrativ.

### T-044 — Kundetilfredshed pr. land og værelsestype

- **Story:** US-006.
- **Status:** Implementeret på `feat/tableau-bar-occupancy-correlation`;
  automatisk test og Tableau-preview afventer.
- **Omfang:** `GET /analytics/customer-satisfaction/by-country-room-type` returnerer
  én numerisk række pr. land/værelsestype med gennemsnitsrating, svarprocent,
  kvalificerede/bedømte ophold og fordeling af rating 1–5.
- **Kohorte:** Kun bekræftede bookinger med checkout i perioden, hvor checkout
  ikke ligger i fremtiden. Ingen anmeldelsesdata opfindes af endpointet.
- **Tableau:** JSONPath `$[*]`; brug land og værelsestype som dimensioner og
  rating/svarprocent som measures.

### T-045 — Gennemsnitlig opholdslængde til Tableau

- **Story:** Ingen (US-004/US-007/US-008 fjernet 2026-11-06, C-018).
- **Status:** Endpoint implementeret på `feat/tableau-bar-occupancy-correlation`;
  automatisk test og Tableau-preview afventer.
- **Kohorte/formel:** Bekræftede bookinger med check-in i perioden; samlet antal
  overnatninger divideret med antal bookinger. Hele opholdet tæller med, også
  når checkout ligger uden for perioden.
- **Tableau:** `GET /analytics/bookings/average-stay-length`; JSONPaths
  `$.summary`, `$.monthly[*]`, `$.by_room_type[*]` og `$.by_country[*]`.

### T-046 — Analysefane efter opgavens analysekrav

- **Stories:** US-005 (hotelanalyserne i fanen har ingen story efter C-018).
- **Status:** Implementeret på `feature/T-046-analytics-dashboard-requirements`;
  66 frontendtests og 19 browser-smoke-checks består; analysefanen er verificeret
  visuelt mod live Compose-API ved 1440 px og 390 px.
- **Omfang:** Analysefanen viser nu opgavens spørgsmål i stedet for belægning,
  RevPAR og kundetilfredshed: gæster pr. land, indtjening pr. land, pr.
  værelsestype og pr. værelsestype × sæson, top 10 værelser, mest indbringende
  værelse/land, årets hotelindtjening, ADR (gns. pris pr. solgt nat) som ekstra
  nøgletal samt Helene Christines samlede barsalg, omsætning pr. drink og
  cocktail/kaffe-fordeling.
- **Kontrakt:** Ingen API- eller databaseændring; alle tal læses fra
  `GET /api/analytics/dashboard` (`summary`, `by_country`, `by_room_type`,
  `by_room_type_season`, `by_room`, `top_room`, `top_country`, `bar_products`,
  `bar_categories`). Frontend sorterer og formaterer kun.
- **Visuel stil:** Hele frontenden (booking, bookingoversigt og analyse) bruger
  hotellets hvide/creme og guld-palet; analysefanen er ikke længere mørk.
