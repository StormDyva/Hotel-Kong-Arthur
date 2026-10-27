# Specify

## Status

Approved as working agreement – 2026-10-26. Kravene er afledt af PDF-opgaven og PROJECT_GUIDE.md.

## Formål og roller

Systemet skal analysere og præsentere data fra Hotel Kong Arthurs drift for beslutningstagere. Receptionisten vedligeholder bookinger gennem browserfrontend og REST API. Hoteladministratoren ser hotel- og baranalyser. Beslutningstageren bruger et interaktivt Tableau-dashboard uden SQL.

## Funktionelle krav

### Booking og live-opdatering

- Frontend skal kunne oprette, se, redigere og annullere bookinger.
- API’et skal kunne modtage POST, PUT og DELETE-bookingændringer og gemme dem i MySQL.
- Ændringer skal valideres og være synlige ved næste API-request eller Tableau-refresh.
- CSV/XSLT fra ITAKEA/hoteldata er historisk eksempeldata til seed/import, ikke primær live-opdateringsmekanisme.

### Hotelanalyse

Systemet skal vise gæster pr. land, samlet og årlig indtjening, indtjening pr. værelsestype, sæson og land, mest indbringende værelsestype og land, belægningsgrad samt mindst ét ekstra nøgletal. Det foreslåede ekstra nøgletal er gennemsnitlig indtjening pr. ikke-annulleret booking.

### Cocktailbar

Systemet skal vise Helene Christines samlede salg for året, omsætning pr. drink/produkt og procentfordeling mellem cocktails og kaffe for Helene Christine. Helene Christine håndteres som employee_name-filter, indtil andet er godkendt.

### Tableau

Dashboardet skal være interaktivt og vise hotel- og bar-KPI’er med relevante periode-, land-, værelsestype-, sæson- og medarbejderfiltre. KPI-definitioner og refresh-procedure skal dokumenteres.

### Kundetilfredshed

PDF’en nævner kundetilfredshed blandt mulige nøgletal, men specificerer ikke data, skala, beregning eller visualisering. MVP’en implementerer derfor ikke kundetilfredshed uden godkendt datakilde og definition. Hvis beslutningen ændres, aktiveres de ekstra story/task-spor i Clarify og Tasks.

## API-overflade

| Metode | Endpoint | Formål |
|---|---|---|
| GET | /health | API- og databasehealth |
| GET | /bookings | Paginering og filtreret bookingliste |
| GET | /bookings/{id} | Hent én booking |
| POST | /bookings | Opret booking, HTTP 201 |
| PUT | /bookings/{id} | Fuld idempotent opdatering |
| DELETE | /bookings/{id} | Soft-cancel booking, HTTP 200 eller 204 efter OpenAPI |
| GET | /room-types | Hent værelsestyper og kapacitet |
| GET | /analytics/occupancy | Belægningsgrad for periode |
| GET | /analytics/revenue | Samlet indtjening |
| GET | /analytics/revenue-by-room-type | Indtjening pr. værelsestype og sæson |
| GET | /analytics/revenue-by-country | Indtjening pr. land |
| GET | /analytics/bar-sales | Helene-filter, produktsalg og kategoriandele |

Alle responses er JSON. Fejl følger error, message og details. Analyse-endpoints understøtter from og to samt relevante country_code, room_type_id, season og employee_name. GET /bookings understøtter page, page_size med maksimum 100 samt status-, room-, guest- og datofiltre.

## Request- og response-schemas

### BookingCreate og BookingUpdate

| Felt | Type | Create | Update | Regel |
|---|---|---|---|---|
| guest_id | integer | Påkrævet | Påkrævet | Eksisterende guest |
| room_id | integer | Påkrævet | Påkrævet | Eksisterende aktivt room |
| check_in | date | Påkrævet | Påkrævet | ISO 8601, lokal kalenderdato |
| check_out | date | Påkrævet | Påkrævet | Efter check_in, eksklusiv overnatning |
| guests_count | integer | Påkrævet | Påkrævet | Minimum 1, højst room_type.capacity |
| price_total | decimal | Beregnes af systemet | Beregnes af systemet | DKK, mindst 0, sum af prislinjer |
| currency | string | Valgfrit | Valgfrit | Default DKK; andre valutaer afvises i MVP |
| status | enum | Valgfrit | Påkrævet ved fuld PUT | confirmed eller cancelled; default confirmed ved POST |

BookingResponse indeholder desuden id, created_at og updated_at. En booking må ikke referere til slettet/inaktivt room. POST returnerer 201; PUT returnerer 200; GET returnerer 200 eller 404; DELETE returnerer 200 med cancelled resource eller 204 efter den godkendte OpenAPI-kontrakt.

### BookingListResponse

Liste-responsen indeholder items, page, page_size, total og applied_filters. items er BookingResponse-objekter. page er mindst 1, page_size er 1–100, og default page_size skal dokumenteres i OpenAPI.

### ErrorResponse

Fejl har formen error (stabil kode), message (læselig forklaring) og details (liste med felt/kode/årsag). Forventede statuskoder er 400/422 ved inputfejl, 404 ved ukendt resource, 409 ved overlap eller konflikt, 503 ved utilgængelig database og 500 kun ved uventet fejl.

### AnalyticsResponse

Analyse-responser indeholder period, applied_filters, generated_at, data og warnings. data indeholder de relevante grupperinger og totaler. Ingen data returneres som tom data med forklarende metadata; division med nul returnerer 0 og warning.

### Idempotens og opdateringsregler

PUT med samme gyldige payload giver samme resource-state. DELETE på allerede cancelled booking giver samme state uden ny historikrække. POST er ikke idempotent uden en senere godkendt idempotency-key; dubletbeskyttelse håndteres af validering og eventuelle klientnøgler skal beskrives i OpenAPI.

## Datamodel på domæneniveau

Hotellet har 214 værelser og 8 værelsestyper. Værelsestyper har kapacitet 1–4 personer og sæsonpriser. Præcise antal pr. type skal komme fra seed-data eller godkendt beslutning.

- room_types: id, name, description, capacity, active.
- seasons/season_periods: sæsonnavn, aktive kalenderperioder og gentagelsesregler.
- room_type_prices: room_type_id, season_id, price_per_night, currency, active.
- rooms: id, room_number, room_type_id, active.
- guests: id, country_code, country_name.
- bookings: id, guest_id, room_id, check_in, check_out, guests_count, price_total, currency, status, cancelled_at, created_at, updated_at.
- booking_price_lines: booking_id, night_date, season_id, price_per_night, quantity, line_total, currency.
- bar_products: id, name, category (cocktail, coffee eller anden godkendt kategori), price, active.
- bar_sales: id, product_id, sold_at, quantity, unit_price, currency, employee_name.

Relationer er: én room_type har mange rooms; én guest har mange bookings; ét room har mange bookings over tid; ét bar_product har mange bar_sales. Obligatoriske relationer er room_type_id, guest_id, room_id og product_id. country_name kan være afledt/denormaliseret, men country_code er den stabile analysekode. created_at, updated_at og sold_at er timestamps; check_in/check_out er datoer.

## Kvalitetstjek

- Er kravet entydigt? Delvist; åbne valg står i Clarify.
- Kan det implementeres? Ja efter godkendelse af API, status, sæson og kundetilfredshed.
- Kan det testes? Ja, via stories og tasks.
- Er det dækket af stories og tasks? Ja, se user-stories.md, tasks.md og traceability.md.
- Er der afhængigheder? Ja: T-001/T-002 før implementation og T-008 før klienter.
