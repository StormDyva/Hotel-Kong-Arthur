# Instruktioner til AI-agenter

Læs altid START_HER.md og PROJECT_GUIDE.md, før du arbejder.

## Arbejdsregler

1. Arbejd kun på den task, du har fået.
2. Kontrollér git status, før du ændrer noget.
3. Arbejd i en separat branch.
4. Følg 3-lagsarkitekturen.
5. Ændr ikke API- eller databasekontrakter uden at opdatere specs/ og OpenAPI.
6. Commit aldrig secrets, tokens eller lokale .env-filer.
7. Slet ikke ukendte ændringer.
8. Kør relevante tests og git diff --check.
9. Beskriv ændrede filer, tests og kendte begrænsninger i Pull Requesten.
10. Markér ikke en task som færdig uden testbevis.

## Rapportformat

Efter arbejdet skal agenten rapportere:

- Task-ID
- hvad der blev implementeret
- ændrede filer
- testkommandoer og resultater
- eventuelle beslutninger
- resterende problemer

