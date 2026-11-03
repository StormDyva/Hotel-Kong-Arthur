# Funktionel specifikation — Hotel Kong Arthur API

Revision: tillægsopgave uge 2, specifikationsudkast. Kilder: E26 Tværfaglig
Opgave Hotel Kong Arthur, Tillægsspørgsmål_swa og tillægsopgave uge 2. Dette
kravudkast er ikke implementeret eller godkendt endnu. MySQL nævnes kun som den
historiske v1, bevaret i tagget `v1-mysql-tableau`.

## Principper og roller

Receptionisten opretter, læser, ændrer og annullerer bookinger. Hotellets egne
klienter kan bruge samme REST/JSON-kontrakt som browserprototypen. Administratoren
henter aktuelle hotel-, bar- og tilfredshedsanalyser fra PostgreSQL via API'et.
Frontend og et eventuelt Tableau-dashboard henter beregninger fra API'et; de
beregner ikke selv og læser ikke direkte fra databasen.

Backend har tre lag: HTTP/schemas i api, regler/beregninger i services og SQL i
repositories. PostgreSQL er måldatakilden. Databaseskiftet må ikke ændre
API-kontrakten. OpenAPI i openapi/openapi.yaml skal
stemme med /openapi.json og kunne testes gennem Swagger på /docs. Applikationen,
PostgreSQL og Swagger startes med `docker compose up --build`.

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
  første mellemrum til first_name/last_name. Hver ny booking får et selvstændigt
  gæstesnapshot. Kontaktrettelser opretter et nyt snapshot, så andre bookinger
  ikke ændres. Uændret PUT genbruger det aktuelle snapshot.
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
  price_total, gennemsnitlig price_per_night, status, data_origin og UTC-timestamps.
- Imported customer-stay rows are exposed as read-only synthetic bookings so clients
  can query the complete dataset. Their dates, room assignment and party size are
  generated; source room category, country, season, stay length and total are retained.
  `data_origin=synthetic_import` identifies them; API responses anonymize guest names
  and omit contact details. Only operational bookings can be edited or cancelled.
  See [decision record](../docs/decisions/synthetic-import-bookings.md).

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
produktprisen som snapshot. `sold_at` er et tidszonebevidst tidspunkt, der lagres
i UTC. Salg lagres UTC; ingen syntetiske salg opfindes.

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
| dashboard | samlet JSON til API-forbrugere |

Disse beregninger leveres af backend og er datakilde for frontendens
analysevisninger og et eventuelt Tableau-dashboard. Endpoint- og warning-detaljer
for nye/ændrede operationer kræver afklaring; eksisterende endpoints bevares.

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
- ADR = indtjening / solgte nætter findes allerede som API-beregning. Det er ikke
  valgt som tillægsopgavens selvvalgte nøgletal; C-013 er fortsat åben.
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
Transaktionen committes før svaret sendes. Senere GET/analyse læser aktuelle
PostgreSQL-data. Live betyder REST-opdatering og friske værdier ved næste GET; push
er ikke et krav.

Acceptbevis: PostgreSQL-integrationstests, samtidighedstest, grænse-/formeltests,
OpenAPI 3.1-validering, kontraktlighed, Compose-smoke og Swagger Try it out i browser.
Frontend-analysevisninger og eventuel Tableau-rendering afstemmes mod API-tal.

## Ikke-funktionelle krav — tillægsopgave uge 2

- Runtime-databasen er PostgreSQL. CSV/XLSX seed/import genskaber demodata; der
  migreres ikke eksisterende rækker fra MySQL v1.
- Databaseskiftet bevarer API-kontrakten: samme eksisterende endpoints, felter,
  statuskoder og fejlkoder. SQL-dialekt og driver er repositorydetaljer.
- Backend beregner alle KPI'er og eksponerer dem via REST/JSON. Frontend og
  Tableau forbruger API'et; frontend beregner ikke KPI'er og bruger ikke SQL.
- Løsningen startes med én `docker compose up --build`.
- Det selvvalgte KPI er åbent og må ikke implementeres før C-013 er afklaret.

## Frontendens analysevisninger

Frontendprototypen skal vise belægning, hotelindtjening, gæster pr. land,
barsalg og kundetilfredshed med data hentet fra analyse-endpoints. Periodevalg og
eventuelle godkendte land-/værelsesfiltre opdaterer API-kald. Tomme data og fejl
vises tydeligt. Hentemåde ved sidevisning eller manuel opdatering afventer C-015.

## Artefakter

constitution.md → spec.md → clarify.md → plan.md → tasks.md → implementering →
converge-api-2026-10-28.md. Stories/acceptkriterier: user-stories.md; sporbarhed:
traceability.md. specify.md er en henvisning til denne kanoniske specifikation.

## T-022 — færdige flade indtjeningsrækker til Tableau

- GET `/analytics/revenue/by-room-type-season` → `[{roomType,season,revenue}]`.
  Alle otte database-typer (også inaktive historiske typer) krydses med alle tre
  sæsoner. Dermed returneres altid 24 rækker i referenceinventaret, også uden data.
  Sæsonlabels er Lav, Mellem og Høj; typer bruger databasens navne.
- GET `/analytics/revenue/by-country` → `[{country,revenue}]`. Lande med omsætning
  grupperes efter landekode og vises med dansk label, fx Sverige. Ukendte labels
  bruger databasens country_name eller koden. Tom periode returnerer [].
- Begge endpoints bruger year eller from/to (default 2026, eksklusiv to), uden wrapper.
  Penge returneres her som JSON-tal i DKK for direkte numerisk brug i Tableau.
- Service-laget summerer gemte natpriser × quantity for periodens faktiske
  overnatninger. Ens priser svarer til natpris × antal nætter; ved sæsonskift deles
  opholdet på de historiske natpriser. Annullerede bookinger tæller ikke med.
- Disse to specifikt ønskede URLs har ikke `/api`-præfiks. Eksisterende endpoints
  bevarer deres kontrakt. Tableau skal vise disse færdige beløb uden prisberegning.

## T-023 — integritetsrettelser

Navn/land identificerer aldrig automatisk samme person. API'et bruger separate
gæstesnapshots pr. booking. distinct_bookers tæller profiler/snapshots, ikke sikkert
identificerede tilbagevendende personer. Import-idempotens bygger på kildefilens
SHA-256 og rækkenummer via guests.import_key. Tidligere sammenblandede oplysninger
kan ikke rekonstrueres automatisk; eksisterende historik bevares.

På bedømte bookinger er navn, land, værelse, datoer og gæsteantal låst (409 ved
ændring). Kun email/telefonrettelser tillades; ratingen forbliver på samme ophold.
Eksportens guests-datasæt bruger booking_guests. Hele selskabet henføres til
bookinggæstens land, da øvrige nationaliteter ikke registreres. Samlet Tableau-
dashboard og opdateringsdemonstration er fortsat uden endelig godkendelse.

## T-025 — enkel bookingfrontend

Browserprototypen på localhost:5500 søger ledighed, viser et forslag pr. type
(mulighed for typefilter/alle rum), modtager gæstekontakt og opretter via API'et.
Tilbuds- og bekræftelsesprisen kommer fra backend. Serverfeltfejl vises i formularen.
Efter bekræftelse kan man gå direkte til oversigten. Et rigtigt browserflow
verificerede MySQL-persistens i den nuværende runtime efter reload; testbookingen
annulleres til sidst. Det er ikke PostgreSQL-acceptbevis.

## T-027 — importerede ophold og RevPAR (ændringer fra main)

### Importerede ophold

De 1.000 kundestays vises i `/api/bookings` som anonymiserede, skrivebeskyttede
bookinger med `data_origin=synthetic_import`. Datoer, værelser og gæsteantal er
genereret; relevante kildefelter for kategori, land, sæson, opholdslængde og beløb
bevares. Ingen importerede gæstenavne eller kontaktdata vises i API'et.

### RevPAR

RevPAR = værelsesomsætning / tilgængelige værelsesnætter (DKK). Barsalg indgår
ikke. Endpointet `GET /api/analytics/revpar` returnerer samlet tal og månedlige
rækker med periodens klipning; alle periodens måneder medtages, også uden salg.
Nulkapacitet giver 0 med warning. Land filtrerer kun omsætningen; type/sæson
filtrerer også kapaciteten. RevPAR findes nu i backend, men er ikke valgt som
tillægsopgavens selvvalgte KPI (C-013).

## T-028 — CSV-demodata

Loaderen bevarer de 1.000 CSV-rækker i lokal `csv_source_rows`-JSON med batchhash,
rækkenummer og bookingrelation. Eksisterende anonymiserede kildebookinger genbruges;
der oprettes ikke dubletter. Genererede værelser/datoer placerer opholdene i 2026
med matchende kilde-sæson og uden overlap. Kategori, land, nætter og total fra CSV
bevares. En særskilt mock-batch tilføjer 100 tydeligt markerede bookinger.
Loaderen er transaktionel og idempotent; rå CSV og navne committes ikke. Se
`docs/customer-data-import.md`.

## PostgreSQL-implementeringsstatus — 2026-11-03

T-031/T-032 bruger PostgreSQL 17, psycopg 3, separat postgres_data-volume,
IDENTITY/CHECK og PostgreSQL-triggers. CSV genindlæses fra kildefilen, ikke fra
MySQL. API-kontrakten er uændret og kontrolleres mod OpenAPI. Se
[implementeringsbevis](../docs/postgres-migration.md). Legacygeneratorer er endnu
ikke PostgreSQL-porteret; øvrige uge 2-opgaver er ikke afsluttet af denne migration.
