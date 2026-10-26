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

## Næste task

T-004 – Seed-data og CSV/XSLT-import.

Målet er at kunne oprette en ren MySQL-database, køre schema og seed og få et reproducerbart datasæt til API og analyser.

## Plan for næste arbejdsdag

1. Review og merge T-003.
2. Opdatér lokal main fra origin.
3. Opret branch feature/T-004-seed-import.
4. Find og dokumentér CSV/XSLT-datakilder fra ITAKEA/hoteldata.
5. Map data til de seks tabeller.
6. Opret reproducerbare seed/import-filer.
7. Test import mod en ren MySQL-container.
8. Dokumentér genkørsel og håndtering af dubletter.

Startkommandoer:

    /usr/bin/git switch main
    /usr/bin/git pull --rebase origin main
    /usr/bin/git switch -c feature/T-004-seed-import

## Arbejdsregler

- Arbejd kun på én task pr. branch.
- Kør git diff --check før commit.
- Commit ikke secrets eller lokale .env-filer.
- Markér ikke en task færdig uden testbevis og review.
