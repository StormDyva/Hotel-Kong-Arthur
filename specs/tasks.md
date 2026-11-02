# Tasks

## Status

Historiske tasks fra 2026-10-26/28 bevares som udført eller tidligere planlagt
arbejde. Tillægsopgave uge 2 er et nyt, endnu ikke implementeret taskforløb.

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
Dashboardet bygges manuelt senere og blokerer ikke denne API-PR. Containeriserede
tests, numeriske 24-rækkers exports og KPI-endpoints genkontrolleres, PR-beskrivelsen
samles om den færdige implementering og PR markeres ready for review, uden merge.
Se docs/tableau-api-handoff.md.

## Tillægsopgave uge 2 — nye tasks

Alle nedenstående tasks er **ikke startet**. Acceptance- og testbeskrivelser er
planlagte; de er ikke testbevis. T-003–T-018 og T-020–T-026 ovenfor bevares som
historik. Tasks med markeringen “ændret i tillægsopgave uge 2” skal læses sammen
med disse afløsnings-/udvidelsesopgaver.

### T-027 — Sikr og bevar v1 i Git

- **Status:** Completed før specifikationsarbejdet.
- **Stories:** ingen; dette er projektleverance under constitution.
- **Afhængighed:** v1-arbejde på main.
- **Accept:** annoteret tag og branch `v1-mysql-tableau` på commit `366534b`, pushet
  til origin; arbejdsbranch `feature/tillaeg-uge2` oprettet. README beskriver
  checkout og Compose-start af v1.
- **Verifikation:** `git ls-remote --tags origin`, `git branch -vv`, git status.

### T-028 — Vælg og definér selvvalgt nøgletal

- **Status:** Blokerende, afventer gruppens valg (C-013).
- **Stories/accept:** US-004, kriteriet om selvvalgt KPI; US-007 og US-008.
- **Afhængighed:** gruppens beslutning dokumenteret i Clarify.
- **Omfang:** vælge RevPAR, gennemsnitlig opholdslængde, annulleringsrate eller
  andet godkendt tal; fastlægge formel, kohorte, filtre, nul-/tom-dataadfærd.
- **Verifikation:** beslutningsreview og sporbarhed. Blokerer KPI-specifik
  endpoint, frontend og Tableau-implementering.

### T-029 — PostgreSQL Compose og miljø

- **Status:** Ikke startet; ændret i tillægsopgave uge 2.
- **Stories/accept:** US-002; PostgreSQL i Compose, persistence, `pg_isready`,
  testservice og én `docker compose up --build`.
- **Afhængighed:** T-027; C-012 afklaret. Lokal port kontrolleres før valg.
- **Verifikation:** Compose config, start/healthcheck, volume-persistens.

### T-030 — PostgreSQL schema, repositories, seed og import

- **Status:** Ikke startet; ændret i tillægsopgave uge 2.
- **Stories/accept:** US-001 og US-002; PostgreSQL schema/seed/import, samme
  forretningsregler og idempotent genkørsel; importerede historiske rækker
  markeres `synthetic_import` og er skrivebeskyttede.
- **Afhængighed:** T-029. Re-import fra CSV/XLSX; ingen MySQL-datamigrering.
- **Omfang:** psycopg 3 / `DATABASE_URL`, SQL-dialekt, constraints, casesensitiv
  filtrering, locking, og PostgreSQL-sikkert testreset med de samme spærringer.
- **Verifikation:** migration, import to gange, persistence, reset-sikkerhed,
  bookingconcurrency og regressions/API-tests.

### T-031 — Analysekontrakt og endpoint-dækning

- **Status:** Analyseinventaret er udført; kontraktafklaring afventer C-014.
- **Stories/accept:** US-003–US-006.
- **Afhængighed:** review af eksisterende paths i `plan.md`, derefter Clarify.
- **Accept:** beslutte om de eksisterende analyse-endpoints dækker kravene, samt
  eventuelle præcise path-, parameter-, respons-, fejl- og warning-ændringer.
- **Verifikation:** endpoint-/acceptkriteriemapping og kontraktreview. Ingen
  implementation før beslutningen.

### T-032 — OpenAPI og Swagger for godkendte analysekontrakter

- **Status:** Ikke startet.
- **Stories/accept:** US-003–US-006; API-responser/parametre dokumenteres, uden
  at ændre eksisterende kontrakter utilsigtet.
- **Afhængighed:** T-031 og T-028 for KPI-specifik kontrakt.
- **Verifikation:** OpenAPI-validering, runtime-schema-lighed og Swagger-review.

### T-033 — Analysevisninger i frontend

- **Status:** Ikke startet; ny frontendfunktion.
- **Stories/accept:** US-008; vis analyser fra US-003–US-006 via API, filtre,
  loading/tom-/fejltilstand og opdatering efter booking.
- **Afhængighed:** T-031; T-028 for selvvalgt KPI; C-015 om opdateringsmåde.
- **Verifikation:** browser-/frontendtests mod REST API og manuel UI-review.

### T-034 — Tableau kobles til API og afstemmes

- **Status:** Ikke startet; C-016 afklarer om dashboardet fortsat kræves.
- **Stories/accept:** US-007; API som eneste beregningskilde, filtersæt,
  refresh-procedure og kendt datasæt.
- **Afhængighed:** C-016, T-031 og T-028 for KPI-specifik dashboardvisning.
- **Verifikation:** Tableau-demo/refresh og afstemning mod API-tal.

### T-035 — Regression- og PostgreSQL-testdækning

- **Status:** Ikke startet.
- **Stories/accept:** US-001–US-006; eksisterende 26 API-tests og
  bookingconcurrency-test skal bestå mod PostgreSQL, sammen med kontrakt- og
  frontendtests.
- **Afhængighed:** T-029–T-033.
- **Verifikation:** målrettede tests, testreset-spærre og `git diff --check`.

### T-036 — Dokumentation for PostgreSQL og analyseforbrug

- **Status:** Ikke startet; ændret i tillægsopgave uge 2.
- **Stories/accept:** US-002, US-007, US-008 og projektleverance.
- **Afhængighed:** T-029–T-034.
- **Omfang:** README, AGENTS/projektguides, CONTRIBUTING/CONTRIBUTE, datagrundlag,
  API-testing, Tableau-handoff og kort analyse-API-vejledning.
- **Verifikation:** dokumentationsreview og clean-checkout walkthrough.

### T-037 — Converge efter tillægsopgave uge 2

- **Status:** Ikke startet; kommende leverance, ikke en brugerstory.
- **Afhængighed:** T-035 og relevante dele af T-034/T-036.
- **Accept:** vurder alle aktuelle traceabilityrækker som implementeret, delvist
  implementeret eller mangler, med konkrete testbeviser, ejere og resterende
  problemer. Den historiske Converge fra 2026-10-28 omskrives ikke.
- **Verifikation:** ny Converge-fil og review mod matrixen.

## Kvalitetstjek — tillægsopgave uge 2

- Dækning: målrettet mod de otte nye stories; status er planlagt, ikke verificeret.
- Afhængigheder: C-013 blokerer selvvalgt KPI; C-014–C-016 afklarer kontrakt,
  frontendopdatering og Tableau-omfang.
- Testbarhed: PostgreSQL-, API-, concurrency-, frontend- og manuel Tableau-
  verifikation er planlagt, men ikke udført i specifikationsopgaven.
