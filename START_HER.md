# Start her — Hotel Kong Arthur

## Aktuel status

API, MySQL, bookingfrontend og lokal Swagger er implementeret. Alle priser og
nøgletal beregnes i backendens service-lag. Tableau-dashboardet bygges manuelt
senere og er ikke samlet godkendt. Referenceinventar og salg er syntetiske demodata.

1. Læs PROJECT_GUIDE.md og AGENTS.md.
2. Følg README.md for `docker compose up --build -d` og testkommandoer.
3. Åbn http://localhost:8000/docs og brug docs/api-testing.md.
4. Læs specs/constitution.md, spec.md, clarify.md, plan.md, tasks.md og user-stories.md.
5. Aktuel status/testbevis: specs/converge-api-2026-10-28.md.

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
