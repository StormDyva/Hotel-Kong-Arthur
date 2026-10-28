# Contributing

## Branches

Brug en branch pr. task:

~~~text
feature/T-007-booking-api
fix/T-007-booking-validation
docs/project-documentation
~~~

## Arbejdsgang

~~~bash
git switch main
git pull --rebase origin main
git switch -c feature/<task-id>-<kort-navn>
~~~

Når tasken er færdig:

~~~bash
git diff --check
git add <filer>
git commit -m "<type>(<område>): <kort beskrivelse>"
git push -u origin <branch-navn>
~~~

Opret derefter en Pull Request. Mindst ét andet gruppemedlem skal reviewe den, før den merges.

## Commit-typer

- feat: ny funktion
- fix: fejlrettelse
- docs: dokumentation
- test: tests
- refactor: intern forbedring
- chore: værktøj eller konfiguration

## Konfliktregel

Ved konflikt i API, database, Docker eller analyseformler skal gruppen beslutte løsningen, før koden merges. Beslutningen dokumenteres i docs/decisions/.



## Verifikation før review

Start med README.md og docs/release-checklist.md. Kør containeriserede tests med
`docker compose --profile test run --build --rm api-tests`; frontend-unit-tests med
`npm --prefix frontend test`. Kontraktændringer kræver opdateret OpenAPI og specs.
API-, database- og Dockerændringer kræver mindst to reviewers før merge. Samlet
Tableau-accept kræver en konkret dashboard-demo; en bestået API-test er ikke nok.
