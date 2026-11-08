# Start her — Hotel Kong Arthur

## Aktuel status

Løsningen kører mod PostgreSQL 17. Compose indlæser automatisk demoens
1.000 + 100 datasæt, og analysefrontend samt ALOS er implementeret. Den seneste
status, testbeviser og kendte begrænsninger findes i
[`specs/converge-tillaeg-uge2.md`](specs/converge-tillaeg-uge2.md). PostgreSQL-
migrationsbevis findes i `docs/postgres-migration.md`.

Præsentationsversionen er sikret på GitHub som tag/branch
`v1-mysql-tableau`. Se README.md for checkout og start.

1. Læs PROJECT_GUIDE.md og AGENTS.md.
2. Følg README.md for `docker compose up --build -d` og testkommandoer.
3. Åbn http://localhost:8000/docs og brug docs/api-testing.md.
4. Læs specs/constitution.md, spec.md, clarify.md, plan.md, tasks.md og user-stories.md.
5. Læs den seneste samlede vurdering i `specs/converge-tillaeg-uge2.md`.
   `specs/converge-postgres-2026-11-03.md` og `specs/converge-api-2026-10-28.md`
   er historiske testbeviser.

Kravgrundlag: de to udleverede PDF'er E26 Tværfaglig Opgave Hotel Kong Arthur og
Tillægsspørgsmål_swa. De findes i den lokale hovedmappe uden for Git-repositoryet.
README beskriver implementeringen; spec.md er den kanoniske funktionelle spec.

## Før en ændring

Kontrollér git status; opret en afgrænset branch fra det aftalte udgangspunkt.
Slet aldrig ukendte ændringer. Knyt ændringen til task, story og acceptkriterier.
Ved API-/databaseændring opdateres specs og OpenAPI i samme PR. Implementér én
opgave ad gangen, kør relevante tests og git diff --check og dokumentér resultatet.

## Før accept

Kontrollér Compose-opstart, API-/kontrakttests og dokumentation. Et andet
medlem reviewer før merge; API-, database- og Docker-ændringer kræver to reviewers.
Accepter ikke det samlede Tableau-krav ud fra API-/eksporttests alene.
