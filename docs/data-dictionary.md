# Data dictionary

## Status

Databasegrundlaget er udvidet i T-004 med migrationen
`database/migrations/002_booking_database_foundation.sql`.
`database/seed/001_booking_foundation_seed.sql` er et lille deterministisk
udviklingsdatasæt. Det er ikke historiske hoteldata fra ITAKEA/hoteldata.

## Globale konventioner

- Database: MySQL 8+, InnoDB, utf8mb4.
- Penge: `DECIMAL`, altid DKK i MVP. Floating point bruges ikke til penge.
- Datoer: ISO 8601 (`YYYY-MM-DD`) i Europe/Copenhagen.
- Check-in er inkluderet; check-out er eksklusiv og tæller ikke som overnatning.
- Historiske rækker bevares. Annullering er soft-cancel via status.

## Booking- og prisflow

En booking refererer til én hovedgæst og ét konkret værelse. Den endelige pris
beregnes senere i service-laget som summen af én prislinje pr. overnatningsnat:

`price_total = SUM(booking_price_lines.line_total)`

Prisen slås op via værelsets type, nattens sæson og `room_type_prices`.
`bookings.price_total` og prislinjerne gemmes som snapshot, så en senere
prisændring ikke ændrer historiske bookinger.

## Tabeller og relationer

### `room_types`

En værelsestype har mange konkrete værelser. De gamle
`base_price_*_season`-kolonner fra migration 001 bevares af hensyn til
bagudkompatibilitet, men den nye prismodel i `room_type_prices` er den
autoritative model for nye bookinger.

| Kolonne | Type | Betydning |
|---|---|---|
| `id` | BIGINT UNSIGNED | Primærnøgle |
| `name` | VARCHAR(120) | Unikt navn |
| `description` | VARCHAR(500) | Valgfri beskrivelse |
| `capacity` | TINYINT UNSIGNED | Maksimalt antal gæster, 1–4 |
| `active` | BOOLEAN | Om typen må bruges til nye bookinger |
| `base_price_low_season` etc. | DECIMAL(10,2) | Legacy/referencefelter fra migration 001 |

### `rooms`

| Kolonne | Type | Betydning |
|---|---|---|
| `id` | BIGINT UNSIGNED | Primærnøgle |
| `room_number` | VARCHAR(20) | Unikt fysisk værelsesnummer |
| `room_type_id` | BIGINT UNSIGNED | Foreign key til `room_types` |
| `status` | ENUM | `available`, `maintenance` eller `inactive` |
| `active` | BOOLEAN | Om værelset indgår i kapacitet |

Værelser med status `maintenance` eller `inactive` må ikke vælges til nye
bookinger. En senere API/service skal kontrollere både `active` og `status`.

### `guests`

En gæst kan have mange bookinger. Land bruges som stabil analysekategori.

| Kolonne | Type | Betydning |
|---|---|---|
| `id` | BIGINT UNSIGNED | Primærnøgle |
| `first_name` | VARCHAR(120) | Fornavn; nullable for legacy-rækker |
| `last_name` | VARCHAR(120) | Efternavn; nullable for legacy-rækker |
| `email` | VARCHAR(254) | Kontaktmail; nullable |
| `phone` | VARCHAR(40) | Telefonnummer; nullable |
| `country_code` | CHAR(2) | ISO-lignende landekode |
| `country_name` | VARCHAR(120) | Visningsnavn for land |
| `created_at`, `updated_at` | TIMESTAMP | Auditfelter |

Den gamle unikke constraint på land er fjernet, så flere gæster fra samme
land kan gemmes. Email er ikke gjort unik, fordi et hotel kan have gentagne
eller delte kontaktadresser.

### `seasons` og `season_periods`

`seasons` indeholder den logiske sæson og `season_periods` dens tilbagevendende
kalenderintervaller. Den todelte lavsæson kan derfor have én pris med to
kalenderperioder.

Godkendt MVP-kalender:

- `low`: 1/1–31/3 og 1/11–31/12
- `mid`: 1/4–31/5 og 1/9–31/10
- `high`: 1/6–31/8

### `room_type_prices`

Én aktiv pris pr. værelsestype og sæson. `(room_type_id, season_id)` er unik.

| Kolonne | Type | Betydning |
|---|---|---|
| `room_type_id` | BIGINT UNSIGNED | Foreign key til `room_types` |
| `season_id` | BIGINT UNSIGNED | Foreign key til `seasons` |
| `price_per_night` | DECIMAL(10,2) | Pris for én nat |
| `currency` | CHAR(3) | DKK i MVP |
| `active` | BOOLEAN | Om prisen kan bruges |

### `bookings`

| Kolonne | Type | Betydning |
|---|---|---|
| `id` | BIGINT UNSIGNED | Primærnøgle |
| `guest_id` | BIGINT UNSIGNED | Hovedgæst |
| `room_id` | BIGINT UNSIGNED | Konkret værelse |
| `check_in` | DATE | Første nat, inkluderet |
| `check_out` | DATE | Afrejsedag, eksklusiv |
| `guests_count` | TINYINT UNSIGNED | Mindst 1, højst kapacitet |
| `price_total` | DECIMAL(12,2) | Gemte faktiske bookingpris |
| `currency` | CHAR(3) | DKK i MVP |
| `status` | ENUM | `confirmed` eller `cancelled` |
| `cancelled_at` | TIMESTAMP | Hvornår booking blev annulleret |
| `created_at`, `updated_at` | TIMESTAMP | Auditfelter |

### `booking_price_lines`

Én række pr. overnatningsnat. `UNIQUE(booking_id, night_date)` forhindrer
duplikerede prislinjer for samme bookingnat.

| Kolonne | Type | Betydning |
|---|---|---|
| `booking_id` | BIGINT UNSIGNED | Foreign key til `bookings` |
| `night_date` | DATE | Den konkrete overnatningsnat |
| `season_id` | BIGINT UNSIGNED | Sæson brugt ved beregning |
| `price_per_night` | DECIMAL(10,2) | Snapshot af natprisen |
| `quantity` | TINYINT UNSIGNED | MVP er 1 pr. nat |
| `line_total` | DECIMAL(12,2) | `price_per_night * quantity` |
| `currency` | CHAR(3) | DKK i MVP |

### `bar_products` og `bar_sales`

Disse tabeller er genbrugt fra migration 001. `bar_sales.unit_price` er den
faktiske historiske salgspris, mens `bar_products.price` er katalog/referencepris.
`employee_name` bevares til Helene Christine-filteret og senere Tableau-KPI’er.

## Integritetsregler

1. Foreign keys beskytter relationerne mellem tabellerne.
2. `check_out` skal være efter `check_in`.
3. `guests_count` må ikke overstige værelsestypens kapacitet; migration 001’s
   triggers håndhæver dette ved insert/update.
4. Værelset skal være aktivt og have status `available` ved booking.
5. Annullerede bookinger blokerer ikke værelset og tæller ikke i analyser.
6. To bekræftede bookinger på samme værelse overlapper, når:

   `new.check_in < existing.check_out AND new.check_out > existing.check_in`

   MySQL `CHECK` kan ikke sammenligne rækker. Den senere bookingtransaktion
   skal derfor låse værelsesrækken (`SELECT ... FOR UPDATE`) og kontrollere
   overlap, før den skriver booking og prislinjer.
7. Booking og alle prislinjer skal gemmes atomisk i én transaktion.
8. `price_total` skal stemme med summen af `line_total`.
9. Penge og mængder må ikke være negative; valuta er DKK i MVP.

## Seed og kildedata

Der findes ingen CSV/XSLT-kildedata i dette repository. Seed-filen er derfor
et lille, deterministisk testdatasæt med otte værelsestyper, 16 værelser,
fire gæster, tre sæsoner, sæsonpriser, bookinger samt barprodukter og salg.
Den må ikke præsenteres som hotellets historiske produktionsdata.
