# SWA supplementary questions: code walkthrough

1. **Architecture.** README's diagram shows nginx/browser, FastAPI, services,
   repositories, MySQL, and API-to-Hyper-to-Tableau. JSON over HTTP is the public
   interface; SQL exists only in repositories. Extracts carry aggregate data.
2. **Follow a request.** See README's POST walkthrough and `services/bookings.py:save`.
   The request dependency creates a transaction. Failures roll it back. Successful
   writes commit before the response is sent. Room locking serializes overlap checks.
3. **Three layers.** `api/main.py` defines HTTP routes and schemas;
   `services/bookings.py` implements dates, capacity, overlap and pricing;
   `repositories/database.py` owns parameterized SQL. Example: the overlap predicate
   is queried in the repository but the service decides whether to reject the booking.
4. **KPI placement.** The service combines nightly revenue snapshots and computes
   occupancy/ADR/category percentages. Tableau presents the result. Moving these
   rules into Tableau would create a second implementation and inconsistent API clients.
5. **Replaceability.** Another hotel client can call the same JSON API without
   changing services or repositories. Replacing MySQL requires repository and migration
   changes; triggers, lock semantics and SQL must be retested. Database portability
   is not automatic merely because SQLAlchemy is used.
6. **REST.** POST /api/bookings → 201; GET → 200/404; PUT replaces the booking inputs;
   DELETE → 204, retaining history as cancelled. An overlapping booking → 409.
   Room availability is a read resource. Errors have error/message/details fields.
7. **Contract.** `openapi/openapi.yaml` is the checked-in contract; Swagger serves the
   generated equivalent. A test compares the entire document against app.openapi().
   Browser, Tableau refresh bridge and external booking clients depend on it.
   Change the schema, regenerate the file, then review the contract diff together.
8. **Docker.** db, db-init, api and frontend communicate through Compose DNS.
   MySQL health → completed migrations/seed → API health → frontend readiness.
   The named volume survives container shutdown. Host ports are local-only.
9. **Static to live.** POST/PUT/DELETE change MySQL; later API reads see committed
   state. The Tableau bridge fetches current analytics JSON and creates Hyper extracts.
   Reopening Tableau reads the refreshed extracts. Tableau Public is not a continuously
   live database client and the published dashboard cannot reach localhost.
10. **Ownership.** A reviewable AI-proposed decision is using server-calculated nightly
    price snapshots instead of trusting submitted totals. The team must assess and own
    this choice; no claim is made that team members already approved it. Production
    weaknesses include missing authentication/authorization, audit logs, API idempotency
    keys for POST, backup/recovery procedures, load tests and automatic Tableau refresh.
    The shared guest identity assumption (name/country) also needs redesign.
