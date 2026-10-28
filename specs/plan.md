# Teknisk plan — gældende implementering

Revision 2026-10-28, gennem T-024. Funktioner/acceptkriterier: spec.md;
regler/antagelser: clarify.md; aktuel teststatus: converge-api-2026-10-28.md.

## Teknologistak og lag

Python/FastAPI, SQLAlchemy/PyMySQL, MySQL 8 og HTML/CSS/vanilla JavaScript.
api/ ejer HTTP, schemas og fejl. services/ ejer validering, sæsonpriser,
indtjeningsgruppering, belægning, ADR og tilfredshed. repositories/ ejer SQL og
persistence. OpenAPI YAML valideres og sammenlignes med den genererede kontrakt.
Swagger UI serveres lokalt fra API-containeren.

## Data og transaktioner

Room types → rooms/prices; seasons → perioder/prices; bookings → price lines/review.
Hver ny booking har gæstesnapshot; kontaktrettelser bruger copy-on-write, uændret
PUT bevarer ID. Import-idempotens har eksplicit kilde-ID, ikke navn/land.
Rum låses i ID-rækkefølge før bookinglåsen. Overlap og skriveresultat er i samme
transaktion, der committes før HTTP-svaret. DELETE annullerer, ikke hårdsletter.
Bedømte ophold låser navn/land, rum, datoer og antal; email/telefon kan rettes.

Historiske natpriser bevares; prisændringer omskriver ikke eksisterende ophold.
Indtjening, sæsonfordeling og periodeklip sker i backendens services. De to flade
/analytics/revenue endpoints returnerer JSON-tal, inklusive 24 nuludfyldte type/
sæson-kombinationer. Øvrige /api-responser bruger Decimal-strenge som dokumenteret.
Rating 1–5 gemmes én gang pr. afsluttet confirmed booking. Gennemsnit/svarprocent
beregnes fra faktisk indsendte bedømmelser, aldrig syntetiske scores.

## Live data og Tableau

Browser/hotelklient → REST → services → repositories → MySQL. Næste GET læser
aktuelle data. Kundens historiske filer er import/staging, ikke levende bookinger.
Tableau skal vise API-beregnede rækker; et direkte MySQL-flow er ikke løsningen.
Valgfri API → CSV/Hyper-bro kører på værtsmaskinen. Det manuelle dashboard og en
booking → opdateret Tableau-demo er stadig udestående. Ingen WebSocket-/push-garanti.

## Docker

Compose: db → db-init → api → frontend, styret af healthchecks og completed-successfully.
Persistent mysql_data-volume. Hostadresser bindes til localhost, porte kommer fra
.env.example. API bruger internt db:3306, uanset hostport. Frontend-proxyen dækker
/api, /analytics, health, Swagger og assets. CORS følger FRONTEND_PORT.
Dockerfile-target runtime indeholder applikationsafhængigheder; target test indeholder
pytest/kontraktværktøjer. Testprofilen bruger egen test-db og init før api-tests.

## Verifikation og review

`docker compose --profile test run --build --rm api-tests` kører MySQL-, regression-
og OpenAPI-tests. Frontend: npm test; isoleret Chrome-smoke er separat. Compose
verificeres på en ren, separat testinstallation, inklusive genoprettelse med samme
volume. Se docs/operations.md og docs/release-checklist.md. Intet merges uden
menneskeligt review; samlet Tableau-accept vurderes særskilt.
