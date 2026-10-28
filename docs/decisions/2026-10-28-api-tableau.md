> Historisk beslutningsnotat fra den første integration. Aktuel kontrakt og
> prioritering findes i specs/spec.md og PROJECT_GUIDE.md.

# T-009 integration scope, 2026-10-28

Sources: E26 Tværfaglig Opgave Hotel Kong Arthur and Tillægsspørgsmål_swa in the parent folder.

Implement T-006 → T-007 → T-008 → T-009 → T-010/11/12 → T-015/16/17 in dependency order on this integration branch. Existing stories US-001–US-010 and US-012 apply. Each phase is verified before the next.

Canonical URLs use `/api` (matching the existing browser). Health is `/health`.
GET availability, bookings (paginated), booking detail, room-types and analytics;
POST/PUT bookings accept guest contact data but prices are calculated on the server.
DELETE cancels without deleting history. Room-row locks serialize booking writes.
Check-out and analytics `to` are exclusive. Default report period is calendar 2026.
Night-level price snapshots drive revenue; average daily rate (ADR) is the extra KPI.
Tableau must consume the API, not connect directly to MySQL: override that earlier plan.
The installed Tableau Public supports file extracts; an API refresh bridge will produce
CSV snapshots from a single analytics response, without guest personal information.
These are refreshable extracts, not a continuously pushed live connection.
A native Tableau workbook must be opened and verified before T-015 is complete.
The 16-room seed is demonstration inventory, not the actual 214-room hotel.
Customer satisfaction remains an explicit gap under C-009; no fabricated scores.
