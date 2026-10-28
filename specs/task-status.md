# Aktuel status — T-026

API: 27 operationer; 26 backend-/kontrakttests og 59 frontendtests.
Compose har runtime-/test-targets, separat testdatabase, sundhedstjek og lokal proxy.
Gæstesnapshots, låste bedømte ophold, import_key og korrekt gæsteeksport er gældende.
Aktuel verifikation: [Converge](converge-api-2026-10-28.md) og
[release-checkliste](../docs/release-checklist.md). Tableau-dashboardet er ikke samlet godkendt.

---

## Historisk tasklog (tidligere status, ikke aktuel acceptvurdering)

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

## Integration update — 2026-10-28

Branch: feature/T-009-live-api-tableau. Backend/API/MySQL and browser integration,
analytics, OpenAPI/Swagger, Tableau extracts/workbook and handoff documentation
have been added. Canonical specification: spec.md; specify.md is a pointer.
See converge-2026-10-28.md for verified commands and outstanding requirements.
The assignment is not marked complete: Tableau interaction QA, inventory fidelity,
additional filters and satisfaction scope remain open.

## T-020 — API færdiggørelse, 2026-10-28

API og Swagger er prioriteret; Tableau bygges manuelt senere.
På daværende tidspunkt: 25 operationer, fulde filtre/rapporter, 1–5-bedømmelser og referenceinventar er
implementeret. Swagger: http://localhost:8000/docs, lokale assets, Try it out testet.
Se converge-api-2026-10-28.md for den aktuelle API-status og testbevis.

## T-022 — færdige Tableau-rækker, 2026-10-28

Implementeret: /analytics/revenue/by-room-type-season og /analytics/revenue/by-country.
Logiklaget beregner og grupperer historisk natpris × nætter. Første endpoint giver
alle 24 kombinationer, andet giver flade landerækker. Begge returnerer JSON-tal.
23 backend-/kontrakttests bestået, heraf fem nye målrettede tests i test_revenue_rows.py.

T-025: Enkel bookingprototype med reelt opret/reload/oversigts-flow verificeret.

T-026: API er klar til Tableau-integration; handoff i docs/tableau-api-handoff.md.
Testprofil nulstiller kun sin egen database før fixtures (host/navn kontrolleres).
26 containeriserede tests og 59 frontendtests består. Dashboardet er senere manuelt
arbejde og blokerer ikke API-PR-review. PR markeres ready, uden automatisk merge.
