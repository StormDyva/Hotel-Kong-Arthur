# Task status og handoff

## Senest opdateret

2026-10-26

## Nuværende status

T-003 – MySQL-schema og datadictionary er implementeret, testet lokalt og pushet til GitHub.

Branch:

feature/T-003-database-schema

Commit:

c9cf186 – feat(db): add initial MySQL schema

Pull Request:

https://github.com/StormDyva/Hotel-Kong-Arthur/pull/new/feature/T-003-database-schema

## Implementeret i dag

- Oprettet MySQL-tabellerne room_types, rooms, guests, bookings, bar_products og bar_sales.
- Tilføjet foreign keys, indeks og datavaliderende constraints.
- Tilføjet bookingstatusserne confirmed og cancelled.
- Tilføjet DKK-valuta og timestamp-felter.
- Tilføjet triggers, der sikrer at guests_count ikke overstiger værelsestypens kapacitet.
- Dokumenteret datamodellen i docs/data-dictionary.md.

## Testbevis

- Migrationen database/migrations/001_initial_schema.sql kørte uden fejl i MySQL 8.0.
- SHOW TABLES viste alle seks tabeller.
- SHOW TRIGGERS viste begge capacity-triggers.
- git diff --check lykkedes.

## Afslutning for dagen

- Pull Request skal reviewes af mindst ét andet gruppemedlem.
- Pull Request må merges til main efter godkendelse.
- T-003 må først markeres endeligt færdig efter review og merge.

## Nuværende task

T-004 – Booking-databasegrundlag og deterministisk seed er implementeret på
branch `feature/T-004-booking-database-foundation` og afventer review.

Målet er opfyldt for databasegrundlaget: en ren MySQL-database kan køre schema,
seed og read-only kontroller og få et reproducerbart datasæt til booking-API og
senere analyser.

## Implementeret i T-004

- Tilføjet migration 002 med gæsteoplysninger, room-status, seasons,
  season_periods, room_type_prices, booking_price_lines og cancelled_at.
- Opdateret bookingtriggers, så kun aktive værelser med status `available` og
  aktive room types kan bruges, og kapacitetsreglen fortsat håndhæves.
- Tilføjet deterministisk, genkørbar seed med otte room types, 16 rooms, fire
  gæster, tre seasons/priser, fire bookings samt barprodukter og bar_sales.
- Tilføjet read-only databasekontroller og opdateret data dictionary/specs.

## Plan for næste arbejdsdag

1. Review og merge T-004 efter gruppens branch-strategi.
2. Opret eller review T-005 – import af kundedata.
3. Implementér FastAPI health endpoint og repository/service-lag.
4. Implementér booking-flowets transaktionelle overlapkontrol.
5. Implementér booking CRUD og endpoint for ledige værelser.

Startkommandoer:

    /usr/bin/git switch main
    /usr/bin/git pull --rebase origin main
    /usr/bin/git switch -c feature/T-005-docker-environment

## Arbejdsregler

- Arbejd kun på én task pr. branch.
- Kør git diff --check før commit.
- Commit ikke secrets eller lokale .env-filer.
- Markér ikke en task færdig uden testbevis og review.
