# Start her — Hotel Kong Arthur

## Aktuel status

v1 har API, MySQL, bookingfrontend og lokal Swagger. Tillægsopgave uge 2 er nu
specifikationsudkast: PostgreSQL og analysevisninger i frontend er planlagt, men
ikke implementeret. Alle KPI-beregninger skal fortsat ligge i backendens
service-lag. Tableau-status afventer Clarify. Referenceinventar og salg er
syntetiske demodata.

Præsentationsversionen er sikret på GitHub som tag/branch
`v1-mysql-tableau`. Se README.md for checkout og start.

1. Læs PROJECT_GUIDE.md og AGENTS.md.
2. Følg README.md for `docker compose up --build -d` og testkommandoer.
3. Åbn http://localhost:8000/docs og brug docs/api-testing.md.
4. Læs specs/constitution.md, spec.md, clarify.md, plan.md, tasks.md og user-stories.md.
5. Aktuel v1-status/testbevis: specs/converge-api-2026-10-28.md. Rapporten er
   historisk og dokumenterer ikke PostgreSQL-kravene.

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
