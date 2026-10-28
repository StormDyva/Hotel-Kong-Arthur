# Decision: expose imported customer stays as synthetic bookings

**Context:** The user asked that all 1,000 imported stays appear in `/api/bookings`.
The source provides room category, stay length, season, country, and total price,
but no dates, assigned room, or party size.

**Decision:** Preserve those source fields and generate deterministic dates and
room assignments, with `guests_count=1`. Seed the rows at container initialization.
Mark each row `data_origin=synthetic_import`, anonymize its guest name in API output,
omit contact details, and reject edits/cancellation. Operational API-created rows
remain `data_origin=operational`.

**Consequences:** The rows are queryable via booking endpoints and included in
booking analytics under generated years. They must not be described as factual
historical reservations. Imported drink aggregates remain outside dated bar sales.
