# Converge — tillægsopgave uge 2

**Dato:** 2026-11-06. **Udgangspunkt:** `main` efter PR #20 (`481242d`) plus
T-047 på `feature/T-047-converge-and-analytics-gaps`.
**Scope:** US-001, US-002, US-005 og US-006 (C-018). Opgavens øvrige krav fra
E26-opgaven og tillægsopgaven vurderes særskilt nedenfor.

Den historiske vurdering fra 2026-10-28 ligger i `converge-api-2026-10-28.md` og
`converge-2026-10-28.md`; PostgreSQL-migrationen i `converge-postgres-2026-11-03.md`.

## Testbevis

| Kontrol | Kommando | Resultat |
|---|---|---|
| Backend/API mod isoleret PostgreSQL | `docker compose --profile test run --build --rm api-tests` | 41 passed (inkl. OpenAPI-lighed, concurrency og 3 nye ALOS-tests) |
| Frontend-enhedstests | `npm --prefix frontend test` | 70/70 passed |
| Browser-smoke (headless Chrome) | `npm --prefix frontend run smoke` | 19/19 checks bestået |
| Kørende Compose-stak | `docker compose ps`, `/health`, `/docs`, frontend | db, api, frontend healthy; health `ok`; Swagger og frontend svarer 200 |
| Visuel kontrol | Analysefanen ved 1440 px og 390 px mod live API | Ingen konsolfejl og ingen vandret scroll |

## Vurdering pr. user story

| Story | Status | Bevis | Resterende |
|---|---|---|---|
| US-001 — håndtér bookinger | **Implementeret** | API-tests: 201/409/404, idempotent PUT, soft-cancel, paginering/filtre, concurrency. Browser-smoke: opret, redigér, annullér, genbook | Redigér/Annullér vises også på skrivebeskyttede importrækker (API afviser korrekt) |
| US-002 — aktuelle data | **Implementeret** | API-tests: mutation ses i næste GET/analyse; idempotent import; `synthetic_import` skrivebeskyttet; samme kontrakt efter PostgreSQL | Ingen push; opdatering sker ved næste læsning (C-001) |
| US-005 — cocktailbaren | **Implementeret** | `bar-sales` og dashboard: total, omsætning pr. drink, cocktail/kaffe beløb og procent, nævner 0 → advarsel. Vist i analysefanen | Barsalg følger ikke hotelfiltre (bevidst, spec) |
| US-006 — kundetilfredshed | **Implementeret** | API-tests: rating 1–5, gentagen PUT, afvisning af ugyldige/fremtidige/annullerede; gennemsnit, svarprocent, antal, fordeling; null + advarsel uden ratings. Vist i analysefanen (T-047) | — |

## Opgavekrav uden for de fire stories

| Krav (kilde) | Status | Bemærkning |
|---|---|---|
| 3-lagsarkitektur, REST/JSON (E26) | Implementeret | `api/` → `services/` → `repositories/` |
| OpenAPI + Swagger UI i container (E26) | Implementeret | `openapi/openapi.yaml` = `app.openapi()` (test); Swagger på `/docs` |
| Én `docker compose up` (E26) | Implementeret | db → db-init → demo-init → api → frontend |
| Ny database i stedet for MySQL (tillæg) | Implementeret | PostgreSQL 17; v1 i tagget `v1-mysql-tableau` |
| Analyser læses direkte i API'et (tillæg) | Implementeret | `/api/analytics/*` og `/analytics/*` |
| Frontend viser analyserne fra API'et (tillæg) | Implementeret | Belægning, indtjening (år/type/sæson/land), top værelser/lande, gæster pr. land, ALOS, kundetilfredshed og barsalg |
| Selvvalgt nøgletal (E26, C-013) | Implementeret | ALOS i API, test og frontend; i Tableau ifølge gruppen |
| Interaktivt Tableau-dashboard via REST API (E26) | Udført manuelt af gruppen | Ikke verificeret af automatiske tests; workbook vedligeholdes i Tableau Desktop |
| README med arkitekturdiagram, CONTRIBUTE.md (E26) | Implementeret | Diagram opdateret til PostgreSQL, nginx, init-containere og analysefane |
| Spec-artefakter og user stories med acceptkriterier (E26) | Implementeret | `specs/`; C-018 begrænser stories til fire |

## Kendte begrænsninger

- Hotelanalyser, belægning, ALOS og Tableau har ingen user story efter C-018;
  de er implementeret, men accepteres ikke via story-acceptkriterier.
- Demodata giver lav belægning (7,28 %) og en uregelmæssig sæsonprofil; formlerne
  er korrekte, men tallene er ikke realistiske for et rigtigt hotel.
- ALOS følger kun periodefilteret, ikke land/værelsestype/sæson.
- `sold_at` begrænses stadig til MySQL TIMESTAMP-intervallet for at bevare kontrakten.
- Ingen autentifikation, audit-log eller automatisk Tableau-refresh (lokal MVP).
