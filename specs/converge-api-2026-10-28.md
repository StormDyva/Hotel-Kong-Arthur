# Aktuel Converge — API, Compose og dokumentation

2026-10-28, gennem T-024. Denne samlede status erstatter tidligere delrapporter.
Den dokumenterer verifikation; gruppens PR-review og Tableau-accept er særskilte.

| Område | Aktuel status og evidens |
|---|---|
| Tre lag, REST/JSON, MySQL | API → service → repository; SQL i repository |
| Booking-CRUD og filtre | status/room/guest/periode/pagination, serverpriser, room locks og soft-cancel testet |
| Dataintegritet | gæstesnapshots isolerer kontaktdata; bedømte ophold tillader kun kontaktrettelser |
| Import | eksplicit import_key; genimport to gange med stabilt gæsteantal og SQL-checks |
| Hotel | års-/periodeomsætning, belægning, ADR, land/type/rum/sæson, gæster og rangeringer |
| Flade rækker | /analytics/revenue/by-room-type-season har alle 24 kombinationer; by-country er grupperet; JSON-tal |
| Bar | registrering, Helene-total, produktomsætning og kategoriandele; danske årsgrænser testet |
| Tilfredshed | én faktisk rating 1–5 pr. afsluttet booking, gennemsnit/svarprocent/fordeling |
| Referenceinventar | 214 syntetiske rum, otte opgavekategorier, 428 pladser, 20/10 produktkatalog |
| OpenAPI/Swagger | 27 operationer; input/output/fejl; lokale assets; kontraktlighed og OA3.1-validering |
| Docker | ren isoleret opstart, healthchecks, separate runtime/test-targets, proxy og custom-port CORS |
| Persistens | booking oprettet i isoleret installation og genlæst efter genskabelse med samme volume |
| Dokumentation | README/startguide/projektguide/spec/plan/drift/frontend/import/data/SWA/Tableau afstemt |
| Tableau-eksport | booking_guests bruges; CSV/Hyper-gæstetal afstemt med API; regression: fire personer tæller fire |
| Samlet Tableau-dashboard | IKKE færdigverificeret; manuel afstemning, filtertest og opdateringsdemo mangler |

## Testbevis

- `docker compose --profile test run --build --rm api-tests`: 26 tests består mod
  isoleret MySQL, inklusive OpenAPI og tre review-regressioner.
- Frontend unit: 59 tests; isoleret mock-browser: 19 checks fra integrationsarbejdet.
- Swagger-browser: 27 operationer og Try it out bar-GET med HTTP 200 fra API.
- API → MySQL → analyse → PUT → DELETE er afprøvet via rigtige HTTP-kald.
- Compose/proxy/persistens og kommandoer: docs/release-checklist.md.
- Kundeimport og gæsteeksport blev verificeret i T-023. Dashboardet er ikke verificeret.

## Fortolkning og begrænsninger

Uberørt kalender-2026 seed: 12.700 DKK, seks solgte nætter, 78.110 tilgængelige,
0,01 % belægning, ADR 2.116,67 DKK. Helene 575 DKK, cocktails 43,48 %, kaffe 56,52 %.
Syntetisk inventar/menu er ikke faktiske hoteloplysninger. Julegrænser 20.–31.
december er en projektantagelse. Øvrige nationaliteter mangler, så hele selskabet
henføres til bookinggæstens land. distinct_bookers er profil-/snapshotantal, ikke
sikkert identificerede personer. Aktivt inventar er nutidigt, ikke historiske snapshots.
Allerede overskrevne kontaktværdier og fejltilskrevne ratings kræver autoritativ
kilde/manuelt review. Autentifikation og produktion er ikke del af den lokale MVP.

## T-025 — live bookingprototype

Oprettelse i frontend er nu verificeret gennem en rigtig browser mod API/MySQL:
søgning, ét forslag pr. type, server-emailvalidering, oprettelse, 2.000 DKK ved
sæsonskift og genfinding i oversigten efter reload. Testbooking annulleres bagefter.
Frontend-unit: 59 består. Mock-browser: 19/19 består. Dette er browser/API-testbevis,
ikke Tableau-dashboardgodkendelse.
