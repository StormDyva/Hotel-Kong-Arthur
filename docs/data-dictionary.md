# Data dictionary

## Status

Draft implementation reference for T-003. The migration is the executable schema; this document explains domain meaning and invariants.

## Global conventions

- Database: MySQL 8+, InnoDB, utf8mb4.
- Money: DECIMAL, currency DKK. Floating-point money is not allowed.
- Calendar dates: ISO 8601 YYYY-MM-DD in Europe/Copenhagen.
- Timestamps: stored by MySQL as UTC-compatible timestamps and converted for local display.
- IDs: unsigned numeric surrogate keys.
- Historical rows are retained. Booking cancellation is represented by status, not hard deletion.

## Tables and relations

### room_types

One room type has many rooms. There are eight expected hotel categories in the project domain; the exact distribution of 214 rooms belongs in seed data.

| Column | Type | Required | Meaning |
|---|---|---:|---|
| id | BIGINT UNSIGNED | Yes | Primary key |
| name | VARCHAR(120) | Yes | Unique room type name |
| capacity | TINYINT UNSIGNED | Yes | Maximum 1–4 guests |
| base_price_low_season | DECIMAL(10,2) | Yes | Reference price per night |
| base_price_mid_season | DECIMAL(10,2) | Yes | Reference price per night |
| base_price_high_season | DECIMAL(10,2) | Yes | Reference price per night |
| created_at, updated_at | TIMESTAMP | Yes | Audit timestamps |

Season prices are reference/list prices. They are not used to overwrite a booking’s actual price.

### rooms

Each room belongs to exactly one room type. A room can have many bookings over time but cannot have overlapping confirmed bookings.

| Column | Type | Required | Meaning |
|---|---|---:|---|
| id | BIGINT UNSIGNED | Yes | Primary key |
| room_number | VARCHAR(20) | Yes | Unique operational room number |
| room_type_id | BIGINT UNSIGNED | Yes | Foreign key to room_types |
| active | BOOLEAN | Yes | Whether room contributes to available capacity |
| created_at, updated_at | TIMESTAMP | Yes | Audit timestamps |

### guests

One guest record can have many bookings. Country code is the stable grouping key.

| Column | Type | Required | Meaning |
|---|---|---:|---|
| id | BIGINT UNSIGNED | Yes | Primary key |
| country_code | CHAR(2) | Yes | ISO-style country code |
| country_name | VARCHAR(120) | Yes | Display name |
| created_at, updated_at | TIMESTAMP | Yes | Audit timestamps |

### bookings

Each booking references exactly one guest and one room. A booking is an overnight interval: check_in is inclusive and check_out is exclusive.

| Column | Type | Required | Meaning |
|---|---|---:|---|
| id | BIGINT UNSIGNED | Yes | Primary key |
| guest_id | BIGINT UNSIGNED | Yes | Foreign key to guests |
| room_id | BIGINT UNSIGNED | Yes | Foreign key to rooms |
| check_in | DATE | Yes | First night boundary |
| check_out | DATE | Yes | Departure boundary, not a night |
| guests_count | TINYINT UNSIGNED | Yes | At least 1 and no more than room type capacity |
| price_total | DECIMAL(12,2) | Yes | Actual recorded booking price |
| currency | CHAR(3) | Yes | DKK only in MVP |
| status | ENUM | Yes | confirmed or cancelled |
| created_at, updated_at | TIMESTAMP | Yes | Audit timestamps |

Confirmed bookings participate in overlap checks and analysis. Cancelled bookings remain for history but participate in neither.

### bar_products

One product has many sales. Category is controlled so cocktail and coffee percentages are reproducible.

| Column | Type | Required | Meaning |
|---|---|---:|---|
| id | BIGINT UNSIGNED | Yes | Primary key |
| name | VARCHAR(160) | Yes | Unique product/drink name |
| category | ENUM | Yes | cocktail, coffee or other |
| price | DECIMAL(10,2) | Yes | Reference price |
| active | BOOLEAN | Yes | Current catalogue flag |
| created_at, updated_at | TIMESTAMP | Yes | Audit timestamps |

### bar_sales

Each sale references exactly one product. unit_price is the actual price at sale time and is authoritative for revenue.

| Column | Type | Required | Meaning |
|---|---|---:|---|
| id | BIGINT UNSIGNED | Yes | Primary key |
| product_id | BIGINT UNSIGNED | Yes | Foreign key to bar_products |
| sold_at | TIMESTAMP | Yes | Sale time |
| quantity | INT UNSIGNED | Yes | At least 1 |
| unit_price | DECIMAL(10,2) | Yes | Actual sale price |
| currency | CHAR(3) | Yes | DKK only in MVP |
| employee_name | VARCHAR(160) | Yes | Used for Helene Christine filter |
| created_at | TIMESTAMP | Yes | Import/audit timestamp |

## Integrity rules

1. check_out must be after check_in.
2. guests_count must be at least 1 and no greater than the referenced room type capacity.
3. Confirmed bookings for the same room overlap when new.check_in < existing.check_out and new.check_out > existing.check_in. The service/repository transaction must reject this; cancelled bookings are ignored.
4. Active rooms determine available room nights.
5. Prices and quantities cannot be negative; money is DKK.
6. Foreign keys prevent deleting referenced room types, rooms, guests or products.
7. The migration triggers enforce active-room and capacity checks. Overlap remains a transaction-level service rule because it spans booking rows.

## Kvalitetstjek

- Er schemaet entydigt? Ja, felter, relationer, status, valuta og tidsregler er beskrevet.
- Kan det implementeres? Ja, migrationen er vedlagt i database/migrations/001_initial_schema.sql.
- Kan det testes? Ja, med migration, constraint, trigger og overlap-tests.
- Er det dækket af user story/task? Ja, US-001–US-010 og T-003/T-004.
- Er der afhængigheder? Seed-data og overlapservice kommer i senere tasks.
