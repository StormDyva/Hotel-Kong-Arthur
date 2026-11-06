# SWA supplementary questions: code walkthrough

1. **Architecture.** README's diagram shows the browser frontend (nginx), the FastAPI
   presentation layer with Swagger, services, repositories, PostgreSQL 17 and the
   Tableau REST API Connector. Compose also runs the one-shot `db-init` (schema/seed)
   and `demo-init` (2026 demo data) containers. JSON over HTTP is the only public
   interface: the booking pages, the analysis tab and Tableau all call the API, and
   SQL exists only in repositories.
2. **Follow a request.** See README's POST walkthrough and `services/bookings.py:save`.
   The browser sends JSON to nginx, which proxies `/api` to FastAPI. The request
   dependency creates a transaction; the service validates dates, capacity and
   overlap and prices each night; the repository writes `bookings` and
   `booking_price_lines` in PostgreSQL. Failures roll back; successful writes commit
   before the 201 response is sent. Room locking serializes overlap checks.
3. **Three layers.** `api/main.py` defines HTTP routes and schemas;
   `services/bookings.py` implements dates, capacity, overlap and pricing;
   `repositories/database.py` owns parameterized SQL. Example: the overlap predicate
   is queried in the repository but the service decides whether to reject the booking.
4. **KPI placement.** `services/analytics.py` computes occupancy, revenue, RevPAR,
   ALOS, bar totals/percentages and satisfaction from nightly revenue snapshots.
   The frontend analysis tab and Tableau only present the API results. Moving the
   rules into Tableau or JavaScript would create several implementations that can
   disagree; moving them into SQL views would tie business rules to one database.
5. **Replaceability.** This was tested for real: the week-2 change replaced MySQL with
   PostgreSQL 17. Repositories, schema/seed files and the Compose database service
   changed; routes, services, the frontend and the OpenAPI contract did not (the
   existing API tests pass unchanged against PostgreSQL). The MySQL version is kept in
   the `v1-mysql-tableau` tag. Replacing the frontend with the hotel's own booking
   system needs no backend change, because it only uses the documented JSON API.
6. **REST.** POST /api/bookings → 201; GET → 200/404; PUT replaces the booking inputs;
   DELETE → 204, retaining history as cancelled. An overlapping booking → 409.
   Room availability is a read resource. Errors have error/message/details fields.
7. **Contract.** `openapi/openapi.yaml` is the checked-in contract; Swagger serves the
   generated equivalent at `/docs`. `test_openapi_contract` compares the entire
   document against `app.openapi()`, so drift fails the test suite. Consumers are the
   booking frontend, the analysis tab, Tableau's REST connector and external booking
   clients. Change the schema, update the file, then review the contract diff together.
8. **Docker.** `db`, `db-init`, `demo-init`, `api` and `frontend` communicate through
   Compose DNS (e.g. `db:5432`). PostgreSQL health → schema/seed applied → demo data
   prepared → API health → frontend. The named volume `postgres_data` survives
   container shutdown; only `docker compose down -v` deletes data. Host ports are
   bound to 127.0.0.1.
9. **Static to live.** POST/PUT/DELETE change PostgreSQL; the next API read sees the
   committed state, with no re-import of CSV files. The analysis tab fetches fresh
   results on open or "Opdatér". Tableau's REST API Connector reads the same analytics
   endpoints into extracts; Data → Refresh All Extracts shows the change. There is no
   push/WebSocket, and Tableau Public cannot reach localhost.
10. **Ownership.** A reviewable AI-proposed decision is using server-calculated nightly
    price snapshots instead of trusting submitted totals. The team must assess and own
    this choice; no claim is made that team members already approved it. Production
    weaknesses include missing authentication/authorization, audit logs, API idempotency
    keys for POST, backup/recovery procedures, load tests and automatic Tableau refresh.
    The MySQL-only `sold_at` range check (1970–2038) was kept after the PostgreSQL move
    to avoid changing the API contract.
    Guest snapshots do not identify repeat visitors; real person identity requires a separate design.


## API-revision T-020

27 selvstændige operationer dokumenteres i Swagger. Analyse-endpoints har år/periode,
land/type/sæson og medarbejderfiltre med eksplicitte definitioner i spec.md.
Kundetilfredshed beregnes nu i service-laget fra 1–5-ratings i booking_reviews.
Swagger UI assets serveres lokalt. Tableau bygges manuelt senere; det tidligere
extract-flow er derfor ikke et afsluttet dashboard-acceptbevis for denne iteration.


T-023: Gæster sammenkobles ikke længere efter navn/land. Nye bookinger og
kontaktændringer bruger egne snapshots. Uændret PUT genbruger samme snapshot.
Bedømte bookinger tillader kun email-/telefonrettelser; gæst/ophold kan ikke
ændres. Historisk mistede kontaktoplysninger kan ikke gendannes automatisk.

RevPAR beregnes nu i backenden: /api/analytics/revpar, med periodens tal og
månedlige rækker til Tableau. Omsætning / tilgængelige værelsesnætter, DKK.
