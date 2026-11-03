# Test API'et gennem Swagger

## Status for tillægsopgave uge 2

PostgreSQL-runtime er implementeret på migrationsbranchen. 35 API-/database-
og kontrakttests består mod PostgreSQL 17; frontendens nye analysevisninger mangler.
Se [migrationsstatus](postgres-migration.md) og [analyse-API](analysis-api.md).

Start fra repository-roden:

```sh
docker compose up --build -d
```

Åbn http://localhost:8000/docs. Swagger og dets CSS/JavaScript serveres af
API-containeren, uden en ekstern CDN. OpenAPI-kontrakten ligger på /openapi.json
og i repositoryets openapi/openapi.yaml.

## Booking fra start til slut

1. Inventory → GET /api/rooms/availability: angiv datoer og antal gæster.
2. Bookings → POST /api/bookings: tryk Try it out, brug room_id fra søgningen.
3. Eksempel på request (datoer og værelses-ID kan ændres):

```json
{
  "room_id": 101,
  "check_in": "2026-11-20",
  "check_out": "2026-11-23",
  "guests_count": 1,
  "guest": {
    "name": "Test Gæst",
    "email": "test@example.com",
    "phone": "+45 12345678",
    "country_code": "DK"
  },
  "currency": "DKK",
  "status": "confirmed"
}
```

Svaret skal være 201 og indeholde ID og serverberegnet pris. Gentag samme POST
for at se 409 ved overlap. GET /api/bookings/{id} viser den gemte booking.
GET /api/bookings indeholder også anonymiserede kildeophold med
`data_origin: synthetic_import`; deres datoer, værelser og gæsteantal er
syntetiske, og rækkerne kan ikke redigeres eller annulleres.
GET /api/bookings returnerer også importerede ophold markeret med
`data_origin: synthetic_import`. De har opfundne datoer/værelser og kan ikke
redigeres eller annulleres; deres gæstenavne er anonymiserede.
PUT bruger samme requestfelter inklusive status; ændr checkout eller værelse.
DELETE annullerer og returnerer 204. Gentaget DELETE giver også 204.
GET-listen understøtter status, room_id, guest_id, from/to og paginering.
Bookingsvar indeholder guest_id til filtrering.

## Analyser

- GET /api/analytics/revenue med year=2026: årsindtjening.
- GET /api/analytics/occupancy: periodens tæller, nævner, belægning og ADR.
- revenue-by-room, revenue-by-room-type, revenue-by-country, revenue-by-season
  og revenue-by-room-type-season: grupperinger.
- top-performers: mest indbringende værelse, type og land.
- guests-by-country: selskabsstørrelser, unikke bookinggæster og gæstenætter.
- bar-sales: Helene Christine er default; total, produktomsætning og kategoriandele.
- customer-satisfaction: gennemsnit, svarprocent og ratingfordeling.

Brug enten year eller from/to, aldrig begge. `to` og checkout er eksklusive.
Land/type/sæson gælder hoteldata; medarbejder gælder baren. Rapporten dokumenterer
filtrene. Beløbene er DKK og decimaler returneres som JSON-strenge.

## Registrer barsalg

GET /api/bar-products viser produkt-ID'er. POST /api/bar-sales eksempel:

```json
{
  "product_id": 1,
  "sold_at": "2026-10-28T17:30:00+01:00",
  "quantity": 2,
  "employee_name": "Helene Christine"
}
```

Udeladt unit_price bruger produktets aktuelle pris som snapshot. Angiv unit_price
for en anden faktisk salgspris. Tidszone er påkrævet; årsfilteret bruger danske
kalenderdage, selvom database-timestamps lagres UTC.

## Kundetilfredshed

En afsluttet confirmed booking, fx demo-booking 1001, kan bedømmes via
PUT /api/bookings/1001/review med `{"rating": 4}`. GET viser bedømmelsen.
Gentaget PUT opdaterer samme række. 0, 6 og brøker afvises. Annullerede eller endnu
ikke afsluttede bookinger giver 409. Ingen ratings giver null gennemsnit.
Bedømmelsen påvirker næste analyse-request; eksempelopkald er rigtige databaseændringer.

## Reproducerbar verifikation

I den nuværende kodebase: kør `docker compose --profile test run --build --rm api-tests`
fra roden. Det kører 35 tests i et separat test-image mod en isoleret
PostgreSQL-testdatabase.
Swagger-browser-smoke køres på værtsmaskinen. Alternativ lokal Python-opsætning:

```sh
uv venv backend/.venv
uv pip install --python backend/.venv/bin/python -r backend/requirements-dev.txt
node backend/tests/swagger-smoke.mjs
```

Python-tests køres via Compose ovenfor; peg ikke tests på den importerede arbejdsdatabase.

Swagger-smoke kræver Node 22+ og Chrome på macOS; den åbner en isoleret headless
browser, tæller operationerne og udfører et rigtigt Swagger GET mod PostgreSQL-databasen.
Testene bruger syntetisk reference- og CSV-demodata; mutationer rulles tilbage.
Samtidighedstesten opretter og rydder sine egne testdata.

## Færdige indtjeningsrækker til Tableau (T-022)

Dette afsnit dokumenterer den nuværende v1-kontrakt. Fremtidig Tableau- og
frontendforbrug skal fortsat ske via disse API-værdier, ikke via databaseadgang.

Under Swagger-gruppen **Tableau revenue** findes:

- `GET /analytics/revenue/by-room-type-season?year=2026`: 24 flade rækker med
  roomType, season (Lav/Mellem/Høj) og revenue som tal, inklusive nul-kombinationer.
- `GET /analytics/revenue/by-country?year=2026`: flade country/revenue-rækker med
  navne som Danmark, Sverige og Tyskland. Lande uden omsætning udelades.

Begge understøtter også from/to i stedet for year. Backenden beregner og summerer
natpris × antal nætter i logiklaget ud fra historiske prislinjer. Tableau bruger
revenue direkte som et numerisk mål; valutaen er DKK.

RevPAR beregnes i backend via `/api/analytics/revpar` som værelsesomsætning /
disponible værelsesnætter. Svaret indeholder periode- og månedsrækker.
RevPAR er implementeret, men gruppen har ikke afklaret, om det er det selvvalgte
nøgletal i tillægsopgaven (C-013).

RevPAR beregnes nu i backenden: /api/analytics/revpar, med periodens tal og
månedlige rækker til Tableau. Omsætning / tilgængelige værelsesnætter, DKK.
