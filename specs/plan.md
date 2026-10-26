# Plan

## Status

Approved as working agreement – 2026-10-26. Planen må bruges som grundlag for T-003 og frem.

## Teknologistak og source of truth

Python/FastAPI, SQLAlchemy, MySQL, Docker Compose og simpel HTML/CSS/vanilla JavaScript. openapi/openapi.yaml er normativ API-kontrakt; FastAPI-kode og Swagger UI skal valideres mod den. MySQL-schema/migrations er normativ datamodel; seed-data følger migrations.

## 3-lagsarkitektur

Presentation/API: routes, request/response schemas, HTTP, JSON og fejl. Service: bookingregler, overlap, kapacitet, sæsoner, periodeklip og analyseformler. Repository: SQLAlchemy queries, transaktioner og persistence. Controllers indeholder ikke SQL; repositories kender ikke HTTP; services testes uden webserver.

## Datamodel og relationer

room_types 1-til-mange rooms; guests 1-til-mange bookings; rooms 1-til-mange bookings; bar_products 1-til-mange bar_sales. Booking har obligatoriske guest, room, check_in, check_out, guests_count, price_total, currency og status. Status er confirmed eller cancelled. Datoer er ISO 8601; timestamps lagres UTC. Valuta er DKK. guests_count må ikke overstige room_type.capacity.

## API-kontrakt

OpenAPI skal beskrive alle endpoints fra Specify med schemas, query-parametre, paginering, statuskoder, idempotens, fejlformat og eksempler. POST returnerer 201, PUT er fuld idempotent opdatering, DELETE soft-canceller og er idempotent. GET /bookings har page/page_size (maks. 100), status, room_id, guest_id, from og to. Analytics har from/to og relevante land-, room_type-, season- og employee_name-filtre.

## Live- og Tableau-dataflow

Frontend eller hotelklient skriver bookingændringer via POST/PUT/DELETE til API → service-validering → repository-transaktion → MySQL. GET og analyse læser MySQL ved hvert request. CSV/XSLT importeres kun via seed/importflow. Tableau bruger dokumenteret MySQL-live connection eller refreshable extract; MVP’en lover manuel/planlagt refresh, ikke WebSockets.

## Analyse

Belægning bruger solgte værelsesnætter / aktive værelser * kalenderdage * 100. Bookingperioder klippes til analyseperioden; check-out er eksklusiv. Indtjening summerer faktisk price_total for ikke-annullerede bookings; ved perioder krydses bookingens pris proportionalt efter overnatningsnætter, hvis rapporten kræver periodeindtjening. Sæsonindtjening fordeles pr. nat. Baromsætning er quantity * unit_price, med Helene-filter og kategoriandele. Nævner 0 giver 0 plus warning; ingen data giver tomme grupper og metadata.

## Kundetilfredshed

Ikke implementeret i MVP uden godkendt datakilde/definition. Ved aktivering kræves separat customer_satisfaction-model, import, endpoint, analyse-service, Tableau-view, story, task, test og traceability-rækker.

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
