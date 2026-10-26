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

