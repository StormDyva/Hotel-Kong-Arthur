# Tasks

## Status

Approved as working agreement – 2026-10-26. T-002 er gennemført som dokumentationsbeslutning; implementation-tasks kan starte i rækkefølge.

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

### T-003 – MySQL-schema og datadictionary

- Stories: US-001–US-010.
- Afhængighed: T-002.
- Område: database/migrations/, docs/data-dictionary.md.
- Accept: relationer, kardinaliteter, obligatoriske/valgfrie felter, status, DKK, UTC/Europe-Copenhagen, 214 værelser, 8 typer, capacity constraint og indeks er implementerbare.
- Test: migration på ren MySQL, constraint-tests og schema-review.

### T-004 – Seed og CSV/XSLT-import

- Stories: US-005, US-010.
- Afhængighed: T-003.
- Område: database/seed/, importdokumentation.
- Accept: eksempeldata mappes til MySQL, import er reproducerbar, genkørsel/dubletter er dokumenteret, live-flow er adskilt.
- Test: seed/import smoke test og kontrol af antal/relationsfejl.

### T-005 – Import af kundedata fra ITAKEA/hoteldata

- Stories: US-005, US-008, US-010.
- Afhængighed: T-003 og T-004.
- Område: database/migrations/, database/import/, database/tests/, docs/.
- Accept: kundens filer profileres, mapping dokumenteres, importen er reproducerbar og idempotent, ufuldstændige rækker afvises, og bookingmodellen ændres ikke utilsigtet.
- Test: ren MySQL, import to gange, relationstjek, afvisningsrapport og eksisterende booking-/prislinjetjek.

### T-005-Docker – Docker Compose og miljø

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

### T-009 – Live API-flow

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

### T-017 – Samlet test og CI

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

## T-020 — API op til opgavekrav (2026-10-28)

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

## T-022 — Flade indtjeningsrækker til Tableau

Brugerkrav: GET /analytics/revenue/by-room-type-season og
GET /analytics/revenue/by-country returnerer arrays med færdigberegnet indtjening.
Service-laget summerer gemt natpris × antal nætter (natlige prislinjer og quantity).
Alle otte typer × tre sæsoner medtages, også ved 0. Ingen Tableau-beregninger.
Beløb returneres som JSON-tal i DKK. Filtre: year eller from/to, samme periodevalg
som øvrige analyser. Annullerede bookinger udelades, checkout er eksklusiv.
Test: 24 kombinationer, nulperiode, sæson-/periodegrænse, landegruppering og kontrakt.

## T-023 — Gæstesnapshots, bedømmelsesintegritet og eksport

Ret de reproducerede reviewfund. API-oprettelse får selvstændig gæsterække pr.
booking; kontaktændringer bruger copy-on-write, uændret PUT genbruger samme række.
Navn/land fjernes som unik identitet. Historisk import bruger eksplicit kilde-ID.
Bedømt booking afviser ændring af navn/land, datoer, værelse eller selskabsstørrelse
med 409; email/telefon må rettes. Tableau-guests bruger booking_guests.
Accept: regressionstests mod MySQL, idempotent import og eksportdata med fire gæster.
Tableau-dashboardets samlede opdateringsdemo er fortsat ikke godkendt.


## T-024 — Compose og dokumentationsafstemning før PR-accept

Accept: ren Compose-opstart og containeriserede API-/kontrakttests i separat
projekt; proxy, custom porte/CORS, persistens og OpenAPI kontrolleret. README,
startguide, projektguide, datadictionary, frontend, Tableau, import, SWA og specs
skal beskrive nuværende adfærd; gamle rapporter markeres historiske. Samlet
Tableau-accept må ikke hævdes. Testbevis: docs/release-checklist.md.

## T-025 — enkel bookingprototype mod rigtig API

US-001/002/005. Bevar enkelt søg → værelse → gæst → bekræft-flow. Vis ét ledigt
forslag pr. type som standard med mulighed for typefilter/alle rum. Brug API-priser,
send ikke klientberegnet pris, vis feltfejl og genvej til oversigten. Accept: browser
opretter en booking mod MySQL, genfinder den efter reload, og testbookingen annulleres.

## T-026 — API-PR klar til manuel Tableau-integration

Acceptomfang: API, bookingprototype og dokumenteret Tableau-datakontrakt/refresh.
Dashboardet bygges manuelt senere og blokerer ikke denne API-PR. Containeriserede
tests, numeriske 24-rækkers exports og KPI-endpoints genkontrolleres, PR-beskrivelsen
samles om den færdige implementering og PR markeres ready for review, uden merge.
Se docs/tableau-api-handoff.md.

## T-027 — RevPAR i backend og Tableau-datagrundlag

US-007: beregn værelsesomsætning / tilgængelige værelsesnætter i service-laget.
Tilføj revpar i summary og et selvstændigt GET /api/analytics/revpar med samlet tal
og månedsrækker til Tableau-kurven. Samme periode/type/land/sæson-regler; nulnævner
returnerer 0 med warning. OpenAPI, Swagger og handoff opdateres; tests mod MySQL.
