# Converge — API / T-020, 2026-10-28

Denne rapport erstatter API-manglerne i den tidligere integrationsrapport.
Brugeren har udskudt manuel Tableau-opbygning og aktiveret kundetilfredshed 1–5.
Rapporten er testbevis og reviewgrundlag, ikke en påstand om gruppens godkendelse.

| Krav | Implementering og verifikation | Status |
|---|---|---|
| Tre lag, REST/JSON, MySQL | api/main + schemas → services → repositories; SQL kun i repository | Implementeret |
| Booking CRUD og løbende opdatering | POST/GET/PUT/DELETE, fuld PUT og soft-cancel; live HTTP/MySQL/analyse-rundtur | Verificeret |
| Bookingfiltre/paginering | status, room_id, guest_id, from/to, page/page_size; overlapgrænser testet | Verificeret |
| Dato/antal/pris/kapacitet | request- og servicevalidering, serverberegnede prislinjer | Verificeret |
| Samtidige writes og værelsesskift | rumlåse i ID-rækkefølge, bookinglås, 201/409 ved samtidighed | Verificeret |
| Belægning og ADR | aktive valgte rum × sæsonnætter; landefilter kun tæller, nulnævner warning | Verificeret |
| Års-/periodeindtjening | natlige snapshots, checkout eksklusiv, annullering udeladt | Verificeret |
| Land/type/sæson/medarbejderfiltre | fælles validering, eksplicit anvendelsesområde og metadata | Verificeret |
| Fysisk værelse/type/land/sæson/krydstabel | selvstændige endpoints, faldende omsætningssortering og topresultater | Verificeret |
| Gæster pr. land | booking_guests, distinct_bookers, guest_nights med dokumenteret land-antagelse | Verificeret |
| Helene-årstal, drinks og kategoriandele | samlet typed barresponse, særskilt barregistrering, UTC/Copenhagen-årsgrænse | Verificeret |
| Kundetilfredshed | én 1–5-rating pr. afsluttet booking, gennemsnit/svarprocent/fordeling | Verificeret |
| 214 værelser/otte kategorier/428 pladser | syntetisk referenceinventar, klart skilt fra faktiske hoteldata | Verificeret |
| 20 cocktails/10 kaffeprodukter | syntetisk katalog; ingen nye opdigtede salg eller ratings | Verificeret |
| Sommer og jul som højsæson | 20.–31. december er dokumenteret datoantagelse; sæsongrænse testet | Verificeret |
| OpenAPI/Swagger | 25 operationer, typed input/output/errors, eksempelrequests, lokal JS/CSS | Verificeret |
| Swagger faktisk API-kald | isoleret browser klikker Try it out/Execute og får barreport 200 | Verificeret |
| Docker-opstart og persistens | MySQL health → db-init → API health → frontend; migrering/seed køres én gang | Verificeret |
| Spec-artefakter og SWA-dokumentation | constitution/spec/clarify/plan/tasks/stories/traceability opdateret | Implementeret |
| Tableau-dashboard | brugerens senere manuelle opgave | Uden for T-020 |

## Testkommandoer og resultater

- `PYTHONPATH=backend MYSQL_PORT=3307 backend/.venv/bin/pytest -q backend/tests`:
  18 tests mod rigtig MySQL, inkl. OpenAPI 3.1-validering og kontraktlighed.
- `python3 backend/tests/live_http.py`: POST → MySQL → analyse → PUT → DELETE →
  oprindelig analyse-total. Verificerer også commit før efterfølgende request.
- `node backend/tests/swagger-smoke.mjs`: 25 operationer og bar-GET via Swagger → 200.
- `npm --prefix frontend test`: 59 tests bestået.
- `docker compose --profile test run --rm test-runner`: migrations/seed/foundation.
- `docker compose config --quiet`, nginx-konfiguration og `git diff --check`: bestået.

## Datakvalitet og fortolkning

Ved uberørt seed for kalender 2026: hotelomsætning 12.700 DKK, 6 solgte nætter,
78.110 tilgængelige nætter, belægning 0,01 %, ADR 2.116,67 DKK. Helene-omsætning
575 DKK: cocktail 43,48 %, kaffe 56,52 %. Kundetilfredshed har ingen opdigtede ratings.
Historiske prislinjer ændres ikke af nye sæsonpriser.

Referenceinventar, julegrænser og fordelingen af nationalitet på hele selskabet er
dokumenterede modelantagelser. Aktuel aktiv inventarstatus bruges også ved historiske
rapporter, fordi systemet ikke har historiske inventar-snapshots. Autentifikation og
produktion er uden for den aftalte lokale MVP. Ingen Tableau-filer er ændret i T-020.

## T-022 tillæg — flade rækker

To ekstra GET-operationer (nu 27 i Swagger):
`/analytics/revenue/by-room-type-season` og `/analytics/revenue/by-country`.
Disse returnerer arrays uden wrapper med numerisk revenue i DKK. Første endpoint
nuludfylder hele type × sæson-produktet. Multiplikation og summering ligger i
services/revenue_rows.py. Samme periode-/annulleringsregler som den øvrige API.

23 backend-/kontrakttests bestået, inklusive fem nye målrettede tests. Tests beviser
24 kombinationer, ingen-data, historisk inaktiv type, landelabel, decimalpriser,
sæsonskift, eksklusiv checkout, annullering og ugyldige perioder.

## T-023 — dataintegritet efter review

De tre reproducerede fund er rettet: nye bookings bruger separate gæstesnapshots;
kontaktændringer kopierer frem for at overskrive en delt gæst; bedømte bookinger
låser navn/land, datoer, værelse og gæsteantal, men tillader email/telefonrettelser.
Import-idempotens bygger på kilde-ID, ikke navn. Eksporten tæller booking_guests.
26 backend-/kontrakttests består, inklusive tre nye regressionstests. Import kørt
to gange i testdatabasen med uændret gæsteantal efter anden kørsel; SQL-check består.
API → CSV/Hyper-eksport er kørt i separat midlertidig mappe, og gæsterækkernes antal
er afstemt med API'ets booking_guests. En booking med fire personer er særskilt testet.

Dette er IKKE verifikation af det samlede Tableau-dashboard eller dets opdatering.
Den samlede Tableau-godkendelse forbliver åben. Tidligere overskrevne kontaktdata
kan ikke gendannes uden en autoritativ kilde; eksisterende rækker slettes ikke.
distinct_bookers tæller gæstesnapshots/profiler og hævder ikke at deduplikere personer.
Allerede fejltilskrevne bedømmelser kan heller ikke identificeres sikkert uden
oprindelig gæste-/opholdshistorik; de kræver autoritativ kilde eller manuel kontrol.
