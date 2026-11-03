# Teknisk plan — tillægsopgave uge 2

Status 2026-11-03: PostgreSQL-runtime implementeret på migrationsbranchen; analysefrontend udestår.
T-031/T-032-testbevis og konkrete valg: docs/postgres-migration.md.
Nedenstående planpunkter bevares som planens baggrund.
Nyere RevPAR- og CSV-demodatafunktioner fra main er med i denne branch, fortsat
mod MySQL. Databasevalget PostgreSQL er afklaret i C-012.
Specifikationen og åbne beslutninger findes i `spec.md` og `clarify.md`.

## Analyse af eksisterende MySQL-specifikke konstruktioner

Søgningen er læst som inventar til migreringsarbejdet; ingen kode eller SQL er
ændret i denne opgave.

| Fil(er) | Fund | Foreslået PostgreSQL-erstatning |
|---|---|---|
| `database/migrations/001_initial_schema.sql`, `002_booking_database_foundation.sql`, `003_customer_import_metadata.sql` | `AUTO_INCREMENT` på id-kolonner | `GENERATED ... AS IDENTITY` |
| `database/migrations/001_initial_schema.sql`, `002_booking_database_foundation.sql`, `004_cancel_unavailable_room.sql`, `005_booking_reviews.sql` | `TINYINT UNSIGNED` | `SMALLINT`/`INTEGER` med tilsvarende `CHECK`-grænser |
| `database/migrations/001_initial_schema.sql`, `002_booking_database_foundation.sql`, `003_customer_import_metadata.sql`, `008_booking_data_origin.sql` | `ENUM` | `CHECK`-constraint eller PostgreSQL enum-type; valg pr. felt skal dokumenteres under implementering |
| Seed 001–005, `database/import/import_customer_data.py`, `build_anonymized_customer_seed.py`, `build_synthetic_bookings_seed.py`, `load_school_csv.py`, `backend/app/repositories/database.py` | `ON DUPLICATE KEY UPDATE` og MySQL `VALUES(...)` | `ON CONFLICT (...) DO UPDATE SET ... EXCLUDED...`; alle seed-/importgeneratorer skal følge samme strategi |
| `database/migrations/`, `database/seed/`, `database/import/`, `backend/app/repositories/` | `DATEDIFF`, `IFNULL`, `INSERT IGNORE`, `DATE_ADD`, `GROUP_CONCAT` og backtick-quoted identifiers blev ikke fundet | Ingen konkrete forekomster at omskrive; ved nyt fund brug dato-aritmetik, `COALESCE`, `ON CONFLICT DO NOTHING`, PostgreSQL dato-aritmetik, `string_agg` og dobbelte citationstegn |

## Teknologistak og lag

Python/FastAPI, SQLAlchemy, PostgreSQL via psycopg 3 og HTML/CSS/vanilla
JavaScript. Forbindelsen konfigureres via `DATABASE_URL` med driverformatet
`postgresql+psycopg://<user>:<password>@<host>:5432/<database>`; konkrete
værdier kommer fra miljøvariabler og committes ikke. API-laget ejer HTTP,
schemas og statuskoder. Services ejer bookingregler og KPI-beregninger.
Repositories ejer SQL og persistence. Databaseskiftet må ikke ændre API-kontrakten.

## Analyse-endpoints: nuværende dækning

Inventaret er kontrolleret i `backend/app/api/main.py` og
`openapi/openapi.yaml`. “Findes allerede” beskriver nuværende kode/API mod MySQL;
det er ikke bevis for PostgreSQL-kompatibilitet. API'et beholder de eksisterende
paths. Ny kontrakt for frontendens brug og eventuelle ændringer afklares i C-014.

| Endpoint | Parametre i nuværende API | Respons | Story | Status |
|---|---|---|---|---|
| `GET /api/analytics/occupancy` | `year` eller `from`/`to`; land, type, sæson | summary: solgte/disponible nætter, belægning, ADR | US-003 | Findes allerede |
| `GET /api/analytics/revenue` | samme periode- og hotel-filtre | summary med indtjening | US-004 | Findes allerede |
| `GET /api/analytics/revenue-by-room` | samme | grupper pr. fysisk værelse | US-004 | Findes allerede |
| `GET /api/analytics/revenue-by-room-type` | samme | grupper pr. værelsestype | US-004 | Findes allerede |
| `GET /api/analytics/revenue-by-country` | samme | grupper pr. bookinggæstens land | US-004 | Findes allerede |
| `GET /api/analytics/revenue-by-season` | samme | grupper pr. sæson | US-004 | Findes allerede |
| `GET /api/analytics/revenue-by-room-type-season` | samme | grupper pr. type og sæson | US-004 | Findes allerede |
| `GET /api/analytics/guests-by-country` | samme | selskaber, bookingprofiler og gæstenætter pr. land | US-004 | Findes allerede |
| `GET /api/analytics/top-performers` | samme | top værelse, type og land | US-004 | Findes allerede |
| `GET /api/analytics/bar-sales` | periode, `employee_name` | total, produkter og kategoriandele | US-005 | Findes allerede |
| `GET /api/analytics/customer-satisfaction` | periode samt hotelkohortefiltre | rating, svarprocent, kohorte og fordeling | US-006 | Findes allerede |
| `GET /api/analytics/revpar` | samme periode- og hotel-filtre | samlet RevPAR og månedlige rækker | US-004, US-007, US-008 | Findes allerede i main; om det er selvvalgt KPI er åbent |
| `GET /api/analytics/dashboard` | samme som analysefilter | samlet analysepayload | US-003–007 | Findes allerede; Tableau-/frontendforbrug skal verificeres |
| `GET /analytics/revenue/by-room-type-season` | `year` eller `from`/`to` | flade 24 type/sæson-rækker | US-004, US-007 | Findes allerede; ældre Tableau-path uden `/api` bevares |
| `GET /analytics/revenue/by-country` | `year` eller `from`/`to` | flade land/omsætning-rækker | US-004, US-007 | Findes allerede; ældre Tableau-path uden `/api` bevares |
| Selvvalgt nøgletal, endnu ikke valgt | afventer C-013 | RevPAR findes som kandidat; andet valg kan kræve ny API-operation | US-004, US-007, US-008 | Implementering af valgte KPI-blokke afventer gruppens valg |

Der er således allerede endpoints for de navngivne analyseområder. Ingen
grundlæggende analyse-GET er identificeret som manglende i API'et; den nye
frontendvisning mangler, PostgreSQL-runtime mangler, og eventuelle KPI-specifikke
API-ændringer afventer Clarify-review. Hvis gruppen vælger RevPAR, findes dens
endpoint allerede i main; dette er ikke i sig selv beslutning om selvvalgt KPI.

## PostgreSQL-skift

- Driver og connection string: psycopg 3 og `DATABASE_URL`; konkret URL og
  afhængigheder implementeres senere.
- Compose-mål: PostgreSQL-image, intern port 5432, foreslået lokal port 5433
  (skal kontrolleres mod andre services før vedtagelse), `pg_isready`-healthcheck,
  ny named volume og bevaret db-init-flow. Én `docker compose up --build` skal
  starte applikationen. Compose-filen ændres ikke i denne specifikationsopgave.
- Schema: `AUTO_INCREMENT` → `IDENTITY`; `TINYINT(1)` → `BOOLEAN`; MySQL `ENUM`
  → `CHECK` eller PostgreSQL enum-type. Bevar præcise værdigrænser.
- Repository/import SQL: backticks → dobbelte citationstegn; `INSERT IGNORE` /
  `ON DUPLICATE KEY UPDATE` → `ON CONFLICT`; `IFNULL` → `COALESCE`;
  `DATEDIFF`/`DATE_ADD` → PostgreSQL dato-aritmetik; `GROUP_CONCAT` →
  `string_agg`. Parameterbinding bevares.
- Case: PostgreSQL sammenligner tekst case-sensitivt som standard, i modsætning
  til MySQLs almindelige collation. Landekoder normaliseres/valideres som
  uppercase ISO-koder; medarbejdernavn sammenlignes efter trimning og en
  eksplicit case-insensitiv strategi (fx `lower(...)` på begge sider). Den
  konkrete strategi skal bruges ens i API og datamigrerings-/seedflow.
- Transaktioner: `SELECT ... FOR UPDATE` for værelseslås bevares. Låsning af
  værelser i ID-rækkefølge, overlapkontrol og booking commit forbliver atomiske;
  concurrency-testen skal fortsat bestå.
- Testreset: `RESET_TEST_DATABASE` omskrives til PostgreSQL og bevarer de
  eksisterende præcise sikkerhedsspærringer for database og host.
- `.env.example` dokumenterer PostgreSQL-indstillinger og `DATABASE_URL`; ingen
  secrets lægges i Git.
- Data: re-import fra CSV/XLSX med idempotent seed/import. Ingen MySQL-rækkedata
  kopieres. `synthetic_import`-rækker skal være tydeligt markeret og skrivebeskyttede.

## API-kontrakt og frontend

API-/servicekontraktens endpoints, felter, status- og fejlkoder bevares gennem
databaseskiftet. Nye endpoints er ikke besluttet; analyse-endpointernes
parametre/fejl/warnings afventer C-014. Kontrakten skal først ændres i en senere
implementering efter godkendelse og samtidig opdatering af OpenAPI.

Frontendens aktuelle README beskriver bookingflowet. Planlagt analysevisning:

| Visning | API-kald (nyttige eksisterende paths) | Story | Status |
|---|---|---|---|
| Belægning | `/api/analytics/occupancy` | US-003, US-008 | API findes; frontendvisning mangler |
| Hotelindtjening, type/sæson/land og topresultater | `/api/analytics/revenue`, `/api/analytics/revenue-by-*`, `/api/analytics/top-performers` | US-004, US-008 | API findes; frontendvisning mangler |
| Gæster pr. land | `/api/analytics/guests-by-country` | US-004, US-008 | API findes; frontendvisning mangler |
| Barsalg | `/api/analytics/bar-sales` | US-005, US-008 | API findes; frontendvisning mangler |
| Kundetilfredshed | `/api/analytics/customer-satisfaction` | US-006, US-008 | API findes; frontendvisning mangler |
| Selvvalgt nøgletal | `/api/analytics/revpar` findes, hvis RevPAR vælges; ellers afventer C-013 | US-004, US-007, US-008 | RevPAR er kandidat; valg åbent |

Frontend kalder kun REST API, implementerer ingen formler og har tydelige loading-,
tom- og fejltilstande. Om kald foretages automatisk ved sidevisning eller via
manuel opdatering afventer C-015.

## Tableau

Hvis Tableau fortsat er krævet (C-016), er det en ren API-forbruger. Det må ikke
læse direkte fra PostgreSQL. Eksisterende flade revenue-exports og deres ældre
paths dokumenteres; samlet workbook, filtre og refresh afstemmes mod API-tal.

## Arkitektur

```mermaid
flowchart LR
    Browser[Frontend: booking og analyser] -->|REST/JSON| API[FastAPI / Swagger]
    Tableau[Tableau, hvis stadig krævet] -->|REST/JSON| API
    API --> Services[Service-lag: regler og beregninger]
    Services --> Repositories[Repository-lag: SQLAlchemy]
    Repositories --> PostgreSQL[(PostgreSQL)]
    Import[CSV/XLSX seed/import] --> PostgreSQL
```

## Eksisterende main-funktioner, som indgår i baseline

- RevPAR beregnes som omsætning / tilgængelige værelsesnætter. Månedsrækker
  klipper omsætning og kapacitet til valgt periode; periodens RevPAR beregnes ikke
  som gennemsnit af afrundede månedsværdier. Det er endnu ikke afklaret, om RevPAR
  er tillægsopgavens selvvalgte KPI.
- CSV-loaderen bevarer 1.000 kilderækker som JSON i `csv_source_rows`, med batch-
  hash, linjenummer og bookingrelation. Den genbruger anonymiserede kildebookinger,
  genererer 2026-datoer/værelser uden overlap og tilføjer særskilt 100 mock-
  bookinger. Genkørsel er idempotent; rå CSV/navne er ikke i Git.

## Verifikation og kommende Converge

PostgreSQL-implementationen skal verificere eksisterende API- og OpenAPI-tests,
bookingconcurrency, import-idempotens, database-resetspærrer, frontendens rigtige
API-flow, Swagger og Compose-health. Main indeholder aktuelt 29 MySQL-baserede
API-tests; de er ikke PostgreSQL-testbevis. Historisk Converge fra 2026-10-28
omskrives ikke.

2026-11-03: Tableau-forbindelsen er REST API Connector. Portering af den historiske CSV/Hyper-bro er ikke del af PostgreSQL-migrationen.
