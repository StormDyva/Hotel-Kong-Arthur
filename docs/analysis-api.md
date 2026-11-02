# Analyse-API — forbrugervejledning

Dette dokument beskriver det eksisterende analyse-API, som skal genbruges af
frontendens nye analysevisninger og, hvis gruppen bekræfter det, Tableau.
Endpoints er verificeret i `backend/app/api/main.py` og
`openapi/openapi.yaml`; de kører endnu på v1-databasen. PostgreSQL-migreringen og
frontendvisningerne er ikke implementeret. Se Swagger på `/docs` for den
aktuelle kontrakt.

## Fælles periodeparametre

Brug enten `year` eller intervallet `from`/`to`, aldrig begge. `to` er eksklusiv.
Hotelanalyser understøtter også `country_code`, `room_type_id` og `season`;
barsalg understøtter `employee_name` (standard Helene Christine). Land/type/sæson
filtrerer ikke barsalg.

```sh
curl 'http://localhost:8000/api/analytics/occupancy?from=2026-01-01&to=2027-01-01'
curl 'http://localhost:8000/api/analytics/revenue-by-room-type?year=2026'
curl 'http://localhost:8000/api/analytics/guests-by-country?year=2026'
curl 'http://localhost:8000/api/analytics/bar-sales?year=2026&employee_name=Helene%20Christine'
curl 'http://localhost:8000/api/analytics/customer-satisfaction?year=2026'
```

## Eksisterende analysepaths

- `/api/analytics/occupancy`, `/revenue`, `/revenue-by-room`,
  `/revenue-by-room-type`, `/revenue-by-country`, `/revenue-by-season`,
  `/revenue-by-room-type-season`, `/guests-by-country`, `/top-performers`,
  `/bar-sales`, `/customer-satisfaction` og `/dashboard`.
- De flade Tableau-exports er fortsat `/analytics/revenue/by-room-type-season`
  og `/analytics/revenue/by-country` uden `/api`-præfiks.
- Selvvalgt nøgletal, endpoint/warning-detaljer og eventuelle API-ændringer
  afventer beslutningerne i `specs/clarify.md`.

Alle beregninger skal forblive i backend. Frontend og Tableau må kun vise de
returnerede data. Brug `docs/api-testing.md` for booking- og analyseeksempler.
