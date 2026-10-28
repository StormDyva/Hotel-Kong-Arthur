# Funktionel specifikation — Hotel Kong Arthur API

Revision: 2026-10-28, T-020. Kilder: E26 Tværfaglig Opgave Hotel Kong Arthur og
Tillægsspørgsmål_swa. Brugeren har prioriteret API og Swagger; Tableau-dashboard
bygges manuelt senere. Kundetilfredshed 1–5 pr. booking er valgt af brugeren.

## Principper og roller

Receptionisten opretter, læser, ændrer og annullerer bookinger. Hotellets egne
klienter kan bruge samme REST/JSON-kontrakt som browserprototypen. Administratoren
henter aktuelle hotel-, bar- og tilfredshedsanalyser fra MySQL via API'et.

Backend har tre lag: HTTP/schemas i api, regler/beregninger i services og SQL i
repositories. MySQL er runtime-datakilden. OpenAPI i openapi/openapi.yaml skal
stemme med /openapi.json og kunne testes gennem Swagger på /docs. Applikationen,
MySQL og Swagger startes med docker compose up --build.

## Booking

- POST /api/bookings → 201, Location-header og gemt resource.
- GET /api/bookings/{id} → 200 eller 404.
- GET /api/bookings → items, total, page, page_size, applied_filters.
- Filtre: status, room_id, guest_id, from og to. Datoer vælger ophold, der overlapper
  [from,to). page >= 1, page_size 1–100 (default 100).
- PUT /api/bookings/{id} → 200. Hele request-modellen er påkrævet inklusive status.
  Samme payload er idempotent. Datoer, værelse og gæstekontakt kan ændres.
- DELETE /api/bookings/{id} → 204. Soft-cancel, historik bevares; gentagelse er sikker.
- Guest indeholder name, email, phone og country_code. Kontaktens navn opdeles på
  første mellemrum til first_name/last_name. Navn/land er gæstens eksisterende
  identitetsnøgle, så kontaktændringer deles mellem bookinger på samme gæst.
- Checkout er eksklusiv. Ophold varer 1–366 nætter, antal gæster 1–4 og højst rummets
  kapacitet. Kun aktive, disponible værelser og typer kan bookes.
- Confirmed ophold må ikke overlappe. Involverede værelser låses i ID-rækkefølge
  før bookinglåsen; transaktionen indeholder overlapkontrol, booking og prislinjer.
- Lavsæson: januar–marts og 1. november–19. december. Mellemsæson: april–maj og
  september–oktober. Højsæson: juni–august og 20.–31. december (julegrænser er
  projektets dokumenterede antagelse; PDF angiver kun juletid).
- Prisen beregnes pr. nat efter sæson og gemmes som historiske prislinjer.
  Klientens price_total accepteres som kompatibilitetsfelt, men bestemmer aldrig prisen.
  Uændret værelse/datoer bevarer pris; ændret ophold genberegnes. Valuta er DKK.
- Svar indeholder bl.a. guest_id, guest, room_id/number/type/capacity, datoer, antal,
  price_total, gennemsnitlig price_per_night, status og UTC-timestamps.

## Inventar og barsalg

GET /api/rooms viser inventaret, evt. filtreret på room_type_id.
GET /api/rooms/availability kræver check_in, check_out og guests_count.
GET /api/room-types viser kategorier og kapacitet.

Referenceinventaret er syntetisk: 214 værelser, 428 kapacitetspladser og opgavens
otte kategorier (Standard enkelt, Grand lit, Standard dobbelt, Superior dobbelt,
Junior suite, Spa executive, Suite og LOFT suite). Typefordeling og værelse-ID'er
påstår ikke at være hotellets faktiske. Priser følger opgavens intervaller.

GET /api/bar-products viser aktive produkter og priser. Referencekataloget indeholder
20 cocktails og 10 kaffeprodukter; det er demodata, ikke hotellets faktiske menu.
POST /api/bar-sales → 201 registrerer product_id, sold_at med tidszone, positivt
quantity, employee_name og evt. faktisk unit_price >= 0. Udeladt unit_price bruger
produktprisen som snapshot. sold_at skal passe i MySQL TIMESTAMP-intervallet
1970-01-01T00:00:01Z til 2038-01-19T03:14:07Z; øvrige afvises med 422. Salg lagres UTC; ingen syntetiske salg opfindes.

## Analyser

Alle nedenstående GET-endpoints har selvstændige schemas og beskrivelser i Swagger:

| Endpoint under /api/analytics/ | Resultat |
|---|---|
| occupancy | solgte/tilgængelige nætter, procent, ADR |
| revenue | samlet/årlig hotelindtjening |
| revenue-by-room | omsætning pr. fysisk værelse |
| revenue-by-room-type | omsætning pr. kategori |
| revenue-by-country | omsætning pr. bookinggæstens land |
| revenue-by-season | omsætning pr. sæson |
| revenue-by-room-type-season | krydstabel kategori × sæson |
| guests-by-country | selskabsstørrelser, unikke bookinggæster og gæstenætter |
| top-performers | mest indbringende værelse, type og land |
| bar-sales | medarbejdertotal, salg pr. drink og kategoriandele |
| customer-satisfaction | gennemsnit, svarprocent og ratingfordeling |
| dashboard | samlet JSON til senere dashboardarbejde |

Filtre: enten year (1900–9998) eller from/to; de må ikke kombineres. Default er
[2026-01-01,2027-01-01). Perioden er 1–3660 dage. Land (country_code), type
(room_type_id) og season (low/mid/high) filtrerer hoteldata. employee_name filtrerer
baren og er default Helene Christine. Hotel-filtre påvirker ikke barsalg, som ingen
bookingrelation har; dette fremgår af hotel_filters_apply_to_bar=false.

- Indtjening = sum af faktiske prislinjer i perioden for ikke-annullerede bookinger.
  Tværsæson-/årsophold fordeles nøjagtigt efter natlige snapshots.
- Belægning = solgte nætter / (aktive værelser i valgt type × valgte sæsonnætter) × 100.
  Landefilter ændrer kun tælleren. Inventarets aktuelle aktive status bruges, da der
  ikke findes historiske inventar-snapshots. Over 100 % giver datakvalitets-warning.
- ADR = indtjening / solgte nætter; dette er projektets ekstra nøgletal.
- Gæster pr. land: booking_guests tæller selskabet én gang pr. matchende booking;
  distinct_bookers tæller gæsteprofiler; guest_nights tæller antal × opholdsnætter.
  Hele selskabets land antages at være bookinggæstens land, fordi øvrige nationaliteter
  ikke er registreret.
- Top-resultater sorteres på omsætning faldende, label stigende ved lighed.
- Baromsætning = quantity × unit_price. Kategoriandele er omsætning / samlet valgt
  medarbejders omsætning × 100, inklusive evt. øvrige kategorier i nævneren.
- Datoafgrænset barsalg bruger Europe/Copenhagen kalenderdage konverteret til UTC.
- Standardsvar indeholder period, applied_filters, generated_at, currency, data,
  warnings og hotel_filters_apply_to_bar. Dashboard beholder også sin samlede form.
- Ingen data giver tomme grupper/null topresultater og warnings. Nævner 0 giver
  procent/ADR 0. Penge og Decimal-værdier serialiseres som JSON-strenge for præcision.

## Kundetilfredshed

PUT /api/bookings/{id}/review med rating heltal 1–5 opretter/erstatter én bedømmelse.
GET på samme URL henter bedømmelsen eller 404. Kun confirmed bookinger med checkout
senest i dag (Europe/Copenhagen) kan bedømmes; øvrige giver 409.

Analysekohorten er afsluttede confirmed bookinger med checkout i [from,to).
Svarprocent = antal med rating / antal i kohorten × 100. average_rating er gennemsnit
af indsendte ratings, null uden ratings. Fordelingen viser antal for hver score 1–5.
Land/type filtrerer kohorten; sæson vælger bookinger med mindst én nat i sæsonen.
Ingen kundetilfredshedstal indlæses som opdigtede demoresultater.

## Fejl, live data og accept

Fejl har error, message og details. Ugyldige input giver 422, ukendt resource 404,
overlap/ikke-tilladt operation 409, databasefejl 503 og uventet fejl 500. SQL og
serverdetaljer udleveres ikke. Request-/response-validering dokumenteres i OpenAPI.
Transaktionen committes før svaret sendes. Senere GET/analyse læser aktuelle MySQL-data.

Acceptbevis: MySQL-integrationstests, samtidighedstest, grænse-/formeltests,
OpenAPI 3.1-validering, kontraktlighed, Compose-smoke og Swagger Try it out i browser.
Tableau-rendering er uden for denne API-task.

## Artefakter

constitution.md → spec.md → clarify.md → plan.md → tasks.md → implementering →
converge-api-2026-10-28.md. Stories/acceptkriterier: user-stories.md; sporbarhed:
traceability.md. specify.md er en henvisning til denne kanoniske specifikation.
