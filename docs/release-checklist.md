# PR-accept — T-024, 2026-10-28

Denne liste adskiller verificeret API/Compose fra det udestående Tableau-dashboard.
Branch: feature/T-009-live-api-tableau, PR #7. Merge foretages først efter review.

## Verificeret i denne dokumentations-/Compose-revision

- [x] `docker compose config --quiet` består.
- [x] Ren installation i et nyt Compose-projekt med ny databasevolume:
  `MYSQL_PORT=13307 API_PORT=18000 FRONTEND_PORT=15500 docker compose -p hka-prverify up -d --build --wait`.
- [x] MySQL, API og frontend bliver healthy; db-init afslutter succesfuldt.
- [x] Alle migrationer 001–007 og seed 001–003 kan initialisere den rene database.
- [x] `docker compose -p hka-prverify --profile test run --build --rm api-tests`:
  26 tests består i test-imaget mod separat test-db. Indeholder OpenAPI 3.1,
  kontraktlighed, booking-/analyse-/review-regressioner og gæsteeksportens enhedstest.
- [x] /health, /docs, /openapi.json, Swagger-JS og /analytics/revenue-rækker fungerer
  via nginx på den alternative frontendport.
- [x] CORS tillader Origin http://localhost:15500 ved direkte API-kald på port 18000.
- [x] Booking oprettet via HTTP; containere genskabt med
  `up -d --force-recreate --wait db db-init api frontend`; booking og kontaktdata
  genlæst uændret fra den bevarede volume. Seed genafspiller ikke bookingrækker.
- [x] Runtime-target starter uvicorn; pytest/httpx/PyYAML/validator er i test-target.
- [x] README, start-/projektguide, frontend, drift, datamodel, import, SWA og specs
  er afstemt. Ældre integrationsrapport og beslutningsnotat er markeret historiske.
- [x] `git diff --check` består.

## Tidligere verificeret (T-020–T-023)

59 frontend-unit-tests, 19 mock-browser-checks, Swagger Try it out mod MySQL,
live HTTP-mutation/analyse, to gange kundeimport med stabilt gæsteantal samt
API → CSV/Hyper-gæsteafstemning. Disse er ikke nye Tableau-dashboardtests.

## Før merge af denne API-PR

- [ ] Mindst to reviewers på API-/database-/Dockerændringer.
- [ ] Godkend de dokumenterede syntetiske data og modelantagelser til projektets demo.
- [ ] Vurder eksisterende data: kontaktværdier eller ratings, som allerede var
  fejlbehæftede før rettelserne, kan kræve autoritativ kilde/manuelt review.

## Senere manuel dashboardaflevering (uden for denne PR)

- [ ] Byg/afstem Tableau-dashboardet, test filtre og demonstrér en bookingændring,
  der ses via API og efter opdatering i dashboardet.

Dette punkt blokerer ikke API-PR'ens review. Datakontrakt og indlæsning beskrives i
[Tableau-handoff](tableau-api-handoff.md).

API-/Compose-revisionen kan reviewes på ovenstående bevis. Det samlede Tableau-krav
må fortsat ikke markeres færdigt. Denne checkliste accepterer eller merger ikke PR'en.

## T-026 — endelig API-handoff og kontrol

26 containeriserede tests og 59 frontendtests genkørt med succes. De to flade
revenue-svar og KPI-endpoints er genkontrolleret mod den kørende API, og served
OpenAPI matcher Git-kontrakten. Handoff beskriver felter og lokal CSV/Hyper-refresh.
Testopsætningen er rettet til at rense sin dedikerede database før fixtures, fordi
legacy-import ellers kunne ændre katalog/priser og give ikke-reproducerbare tests.
Reset afvises ved andet database-/hostnavn; dette er verificeret før DB-forbindelse.
PR er klar til menneskeligt review af API'et. Der er ikke konfigureret GitHub Actions;
testbeviset ovenfor er fra lokale/containeriserede kørsler. Tableau-demo følger senere.

T-027 tilføjer RevPAR og tre regressionstests: nu 29 containeriserede tests
og 28 Swagger-operationer. Se /api/analytics/revpar og Tableau-handoff.
