# User stories

## Status

Godkendte user stories for tillægsopgave uge 2. Hver story beskriver et
brugerbehov og konkrete acceptkriterier. Implementeringsstatus og testbevis står
i `converge-tillaeg-uge2.md`.

## Scope

Projektet omfatter fire user stories: US-001, US-002, US-005 og US-006.
Gruppen besluttede 2026-11-06 at fjerne US-003 (belægningsgrad), US-004
(hotellets indtjening og gæster), US-007 (Tableau-dashboard) og US-008
(nøgletal i frontend) fra projektets user stories; se C-018 i `clarify.md`.
Numrene bevares, så henvisninger i tasks, commits og PR'er stadig passer.
Eksisterende kode og API-endpoints for de fjernede stories er ikke slettet.

## US-001 – Håndtér bookinger

Som receptionist ønsker jeg at oprette, finde, redigere og annullere bookinger i
en browser-frontend, så hotellets belægning og indtjening altid er korrekt.

Acceptkriterier:

- Frontend har formular til oprettelse og redigering med validering og viser
  succes eller fejl.
- POST `/api/bookings` returnerer 201. PUT kræver en komplet, gyldig resource og
  er idempotent.
- Datoer (ISO), gæsteantal i forhold til værelsestypens kapacitet og overlap med
  en confirmed booking valideres. Overlap giver 409.
- DELETE sætter status til cancelled (rækken bevares) og er idempotent. Et
  annulleret værelse kan bookes igen.
- GET `/api/bookings` har paginering (max `page_size` 100) og filtre på status,
  dato og værelse. Ukendt id giver 404.

## US-002 – Se aktuelle data

Som hoteladministrator ønsker jeg, at nøgletal bygger på de seneste bookinger og
ikke kun på historiske filer, så mine beslutninger er baseret på aktuel drift.

Acceptkriterier:

- Ændringer via POST/PUT/DELETE ses i næste GET og i analyse-endpoints uden
  genimport.
- CSV/XLSX bruges kun til reproducerbar seed/import i PostgreSQL, ændrer ikke
  API-kontrakten og håndterer genkørsel uden dubletter.
- Importerede historiske rækker er markeret `synthetic_import` og
  skrivebeskyttede.
- Definitionen af live (REST-opdatering, ingen push) er dokumenteret.
- Databaseskiftet ændrer ikke API-kontrakten (samme endpoints, felter og
  fejlkoder), og eksisterende API-tests består mod PostgreSQL.

## US-005 – Analysér cocktailbaren

Som hoteladministrator ønsker jeg at se Helene Christines salg i baren, så jeg
kan vurdere barens omsætning og produktmix.

Acceptkriterier:

- Samlet årsomsætning for Helene Christine vises.
- Omsætning pr. drink = `quantity × unit_price`.
- Cocktails og kaffe vises med beløb og procent af Helenes samlede omsætning.
- Nævner 0 giver 0 med en advarsel.
- Beregningen er tilgængelig som dokumenteret GET-endpoint i OpenAPI/Swagger og
  returnerer JSON med de samme tal som dashboardet.

## US-006 – Vurder kundetilfredshed

Som hoteladministrator ønsker jeg at se gæsternes bedømmelser og svarprocent, så
jeg kan vurdere tilfredsheden og hvor pålidelig målingen er.

Acceptkriterier:

- En afsluttet, ikke-annulleret booking kan få præcis én rating på 1–5. Gentagen
  PUT opdaterer samme rating.
- Ugyldig score, fremtidige og annullerede bookinger afvises.
- Analysen viser gennemsnit, svarprocent, antal besvarelser og fordeling pr.
  score.
- Uden ratings er gennemsnittet null med en advarsel, ikke et opdigtet tal.
- Beregningen er tilgængelig som dokumenteret GET-endpoint i OpenAPI/Swagger og
  returnerer JSON med de samme tal som dashboardet.

## Mapping fra tidligere stories

| Tidligere id | Nyt id | Bemærkning |
|---|---|---|
| US-001–US-004 | US-001 | Booking-CRUD og browserflow samlet |
| US-005 og US-010 | US-002 | Live-data og import samlet |
| US-006 | — | Var US-003 (belægning); fjernet 2026-11-06 |
| US-007 | — | Var US-004 (indtjening og gæster); fjernet 2026-11-06 |
| US-008 | US-005 | Baranalyse |
| US-011 | US-006 | Kundetilfredshed |
| US-009 | — | Var US-007 (Tableau); fjernet 2026-11-06 |
| US-012 | — | Fjernet som brugerstory; Converge er projektleverance og spores i tasks/constitution |

## Kvalitetstjek (INVEST)

- **Uafhængige:** delvist; US-002 afhænger af seed/import, og analyse-stories
  bruger den fælles backend og database.
- **Forhandlingsbare:** beslutninger og endpointdetaljer er afklaret i
  `clarify.md` og den godkendte OpenAPI-kontrakt.
- **Værdifulde:** formuleret ud fra receptionistens og hoteladministratorens mål.
- **Estimerbare:** opdelt i tasks; se `tasks.md`.
- **Små:** US-002 er bredest, fordi den samler dataflow og seed.
- **Testbare:** kriterier er observerbare.
