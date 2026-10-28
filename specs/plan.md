# Plan

## Status

Approved as working agreement – 2026-10-26. Planen må bruges som grundlag for T-003 og frem.

## Teknologistak og source of truth

Python/FastAPI, SQLAlchemy, MySQL, Docker Compose og simpel HTML/CSS/vanilla JavaScript. openapi/openapi.yaml er normativ API-kontrakt; FastAPI-kode og Swagger UI skal valideres mod den. MySQL-schema/migrations er normativ datamodel; seed-data følger migrations.

## 3-lagsarkitektur

Presentation/API: routes, request/response schemas, HTTP, JSON og fejl. Service: bookingregler, overlap, kapacitet, sæsoner, periodeklip og analyseformler. Repository: SQLAlchemy queries, transaktioner og persistence. Controllers indeholder ikke SQL; repositories kender ikke HTTP; services testes uden webserver.

## Datamodel og relationer

room_types 1-til-mange rooms og room_type_prices; seasons 1-til-mange season_periods og room_type_prices; guests 1-til-mange bookings; rooms 1-til-mange bookings; bookings 1-til-mange booking_price_lines; bar_products 1-til-mange bar_sales. Booking har obligatoriske guest, room, check_in, check_out, guests_count, price_total, currency og status. Status er confirmed eller cancelled. Datoer er ISO 8601; timestamps lagres UTC. Valuta er DKK. guests_count må ikke overstige room_type.capacity. price_total beregnes som summen af booking_price_lines og gemmes som historisk snapshot.

## API-kontrakt

OpenAPI skal beskrive alle endpoints fra Specify med schemas, query-parametre, paginering, statuskoder, idempotens, fejlformat og eksempler. POST returnerer 201, PUT er fuld idempotent opdatering, DELETE soft-canceller og er idempotent. GET /bookings har page/page_size (maks. 100), status, room_id, guest_id, from og to. Analytics har from/to og relevante land-, room_type-, season- og employee_name-filtre.

## Live- og Tableau-dataflow

Frontend eller hotelklient skriver bookingændringer via POST/PUT/DELETE til API → service-validering → repository-transaktion → MySQL. GET og analyse læser MySQL ved hvert request. CSV/XSLT importeres kun via seed/importflow. Tableau bruger dokumenteret MySQL-live connection eller refreshable extract; MVP’en lover manuel/planlagt refresh, ikke WebSockets.

## Analyse

Belægning bruger solgte værelsesnætter / aktive værelser * kalenderdage * 100. Bookingperioder klippes til analyseperioden; check-out er eksklusiv. Indtjening summerer faktisk price_total for ikke-annullerede bookings; ved perioder krydses bookingens pris proportionalt efter overnatningsnætter, hvis rapporten kræver periodeindtjening. Sæsonindtjening fordeles pr. nat. Baromsætning er quantity * unit_price, med Helene-filter og kategoriandele. Nævner 0 giver 0 plus warning; ingen data giver tomme grupper og metadata.

## Kundetilfredshed

Aktiveret ved brugerbeslutning 2026-10-28: booking_reviews har én rating 1–5 pr.
booking. API'et har idempotent PUT og GET på bookingens review. Service-laget
validerer afsluttet/confirmed, beregner gennemsnit og svarprocent for checkout-kohorten.
Ingen ratings seedes. Se spec.md og revideret C-009.

## Docker, dokumentation og aflevering

Compose skal starte db, api og eventuelt frontend med persistent MySQL-volume og healthcheck. Leverancer er README.md med arkitekturdiagram, CONTRIBUTING.md samt afklaring af PDF’ens navn CONTRIBUTE.md, OpenAPI/Swagger, specs, tests og Converge-resultat. Ingen produktionskode implementeres i denne docs-task.

## Teststrategi

Unit: datoer, sæson, overlap, kapacitet, annullering og formler. Integration: migrations, constraints, transaktioner og queries. API: schemas, statuskoder, pagination, filtre, idempotens og fejl. E2E/smoke: Compose, Swagger, frontend CRUD, live MySQL-opdatering, Tableau-refresh og Converge-check.

## Kvalitetstjek

- Er planen entydig? Ja, med åbne valg i Clarify.
- Kan den implementeres? Ja efter T-002 og OpenAPI-godkendelse.
- Kan den testes? Ja, teststrategien dækker alle lag.
- Er den dækket af stories/tasks? Ja, se traceability.md.
- Afhængigheder: Clarify → schema/API → analyser → frontend/Tableau → Converge.

## T-009 integration amendment — 2026-10-28

Canonical resources now use `/api`, matching the booking frontend. See
`openapi/openapi.yaml` for the implemented contract. Swagger is served by FastAPI.
Tableau reads API-generated Hyper extracts through `tableau/refresh.py`; the earlier
proposal for direct MySQL access is superseded by the assignment's API requirement.
`to` is exclusive, including annual reports (2026-01-01 to 2027-01-01).
Docker starts db → db-init → api → frontend. Tableau Public is a desktop client;
the Hyper refresh utility currently runs on the host.

## T-020 gennemført API-præcisering

Selvstændige analyse-endpoints erstatter den tidligere generiske metric-sti.
Periode-/filtermetadata og typede response-schemas følger spec.md. Barregistrering,
feedback, 214 syntetiske referenceværelser og 20/10 produktkatalog er tilføjet.
Swagger UI assets serveres lokalt fra API-containeren. Tableau arbejdes der ikke på
under denne task; senere manuel dashboardopbygning skal tage udgangspunkt i API'et.

## T-022 — Tableau-rækker

api/main eksponerer de to flade revenue-endpoints; services/revenue_rows står for
multiplikation, gruppering og nuludfyldning. Repository returnerer prislinjer og
room type/season-dimensioner uden at aggregere omsætningen. Decimal anvendes under
beregningen; de nye response-modeller leverer numerisk revenue i JSON. Ingen Tableau-
filer eller eksisterende analysekontrakter ændres.
