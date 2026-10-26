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

### T-005 – Docker Compose og miljø

- Stories: US-005, US-012.
- Afhængighed: T-003.
- Område: docker-compose.yml, .env.example, README.
- Accept: api, db og eventuelt frontend starter med healthcheck, persistent volume og ingen secrets.
- Test: docker compose config og docker compose up --build.

## API og backend

### T-006 – 3-lags FastAPI-struktur og health

- Stories: US-012.
- Afhængighed: T-003 og T-005.
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
