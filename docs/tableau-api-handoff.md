# API-handoff til manuelt Tableau-dashboard

## PR-omfang

Denne PR leverer den MySQL-baserede API, bookingprototypen og datagrundlaget til
Tableau. Dashboardet opbygges manuelt af gruppen senere. Et færdigt Tableau-dashboard
er derfor ikke en acceptbetingelse for denne API-PR, men er stadig et afleveringskrav.
Menneskeligt API-/database-/Dockerreview kræves før merge.

Start: `docker compose up --build -d --wait`.
Base-URL: http://localhost:8000. Swagger: http://localhost:8000/docs.
Kontrakt: /openapi.json og openapi/openapi.yaml i Git. API kræver ikke login i denne
lokale prototype. Adressen er lokal og kan ikke læses af en ekstern Tableau-server.

## Datasæt og færdigberegnede felter

| Visning | GET-endpoint | Rækker/felter |
|---|---|---|
| Type × sæson | /analytics/revenue/by-room-type-season | Root-array: roomType, season, revenue; alle 24 kombinationer inkl. 0 |
| Indtjening pr. land | /analytics/revenue/by-country | Root-array: country, revenue |
| Gæster pr. land | /api/analytics/guests-by-country | data-array: label, booking_guests, guest_nights, distinct_bookers |
| Belægning og ekstra KPI | /api/analytics/occupancy | data-objekt: occupancy_percent, room_nights, available_room_nights, adr |
| Årsindtjening | /api/analytics/revenue | data.revenue |
| Mest indbringende | /api/analytics/top-performers | data.top_room, top_room_type, top_country; label og revenue |
| Fysiske værelser | /api/analytics/revenue-by-room | data-array: label, revenue |
| Helene, total | /api/analytics/bar-sales | data.total_revenue; employee_name default Helene Christine |
| Omsætning pr. drink | /api/analytics/bar-sales | data.products-array: product, category, quantity, revenue |
| Cocktail/kaffeandele | /api/analytics/bar-sales | data.categories-array: category, revenue, percent |
| Kundetilfredshed | /api/analytics/customer-satisfaction | data.average_rating, response_percent, rated_bookings, eligible_bookings, distribution |

Pris × nætter, summer, sæsonfordeling, belægning, ADR, ratinggennemsnit og procenter
beregnes af backenden. Tableau skal vise beløbene og andelene og ikke implementere
reglerne igen. De to root-arrays har numerisk revenue. Decimalfelter i øvrige JSON-
svar er strenge af præcisionshensyn; eksportbroen konverterer dem til numeriske felter.
Penge er DKK. Null ratinggennemsnit betyder ingen bedømmelser, ikke nul tilfredshed.

## Periode og filtre

Brug `?year=2026` eller `?from=2026-01-01&to=2027-01-01`, aldrig begge.
Slutdato og checkout er eksklusive. Default er kalender 2026. Svar med wrapper har
period, applied_filters, generated_at og warnings; root-arrays dokumenteres i Swagger.

De to flade revenue-endpoints bruger kun periode/år. Øvrige analyser understøtter
country_code, room_type_id, season og employee_name som beskrevet i Swagger.
Land/type/sæson filtrerer hoteldata; medarbejder filtrerer baren. Hoteldata kan ikke
filtrere barsalg, der ikke har en bookingrelation. Annullerede bookinger udelades.
Hele selskabets land sættes til bookinggæstens land; øvrige nationaliteter er ukendte.
distinct_bookers er gæsteprofiler/snapshots, ikke identificerede tilbagevendende personer.

## Praktisk lokal indlæsning og refresh

API'et leverer JSON over HTTP. Den eksisterende valgfrie eksportbro kan hente ét
aktuelt API-snapshot og skrive CSV/Hyper til den manuelt byggede Tableau-fil:

```sh
uv venv backend/.venv
uv pip install --python backend/.venv/bin/python -r tableau/requirements.txt
backend/.venv/bin/python tableau/refresh.py --from 2026-01-01 --to 2027-01-01
```

Brug de genererede datafiler under tableau/data i Tableau. Efter bookingændringer:
kør eksporten igen og genindlæs filerne/åbn workbook på ny for at undgå cachede
extracts. Det er manuel snapshot-refresh, ikke kontinuerligt push til Tableau Public.
Gruppen kan også bygge sin egen API-import ud fra ovenstående endpoints og Swagger.
De tidligere TWB/TWBX-prototyper er ikke et færdigverificeret dashboard.

## Afstemning før den senere dashboardaflevering

Uberørt syntetisk 2026-seed: 12.700 DKK hotelomsætning, seks solgte nætter,
78.110 tilgængelige, 0,01 % belægning og ADR 2.116,67 DKK. Helene: 575 DKK,
cocktails 43,48 %, kaffe 56,52 %. Sammenlign altid med et aktuelt API-kald, hvis
I har ændret bookinger/salg. Ratings er ikke seedet.

Demonstrér senere: opret en booking i frontend → genhent API-tal → opdatér
Tableau-datakilden → se det ændrede beløb og belægning. Test dashboardfiltre og
oplysninger om periode/refresh. Dette er gruppens manuelle dashboardopgave.

## RevPAR (T-027)

GET `/api/analytics/revpar?year=2026`: data.revpar er periodens værelsesomsætning pr.
tilgængelig værelsesnat. data.monthly har færdige month/revpar-rækker til en kurve,
samt revenue og available_room_nights til forklaring. Ingen pris-/procentberegning
kræves i Tableau. Decimalfelterne returneres som strenge ligesom øvrige /api-tal;
konverter datatypen ved import. Eksportbroens summary indeholder også revpar.
Brug samlet data.revpar for hele perioden; det er ikke gennemsnittet af månedstallene.
