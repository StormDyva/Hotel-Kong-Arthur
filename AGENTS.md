# Instruktioner til AI-agenter

Læs altid START_HER.md og PROJECT_GUIDE.md, før du arbejder.

## Arbejdsregler

1. Arbejd kun på den task, du har fået.
2. Kontrollér git status, før du ændrer noget.
3. Arbejd i en separat branch.
4. Følg 3-lagsarkitekturen. PostgreSQL er måldatabasen efter tillægsopgave uge 2;
   MySQL-versionen er historisk v1 i tagget `v1-mysql-tableau`.
5. Analyser beregnes i backend og eksponeres via REST/JSON. Frontend og Tableau
   forbruger API'et; frontend læser ikke databasen og beregner ikke KPI'er.
6. Databaseskift må ikke ændre API-kontrakten. Ændr ikke API- eller
   databasekontrakter uden at opdatere specs/ og OpenAPI.
7. Commit aldrig secrets, tokens eller lokale .env-filer.
8. Slet ikke ukendte ændringer.
9. Kør relevante tests og git diff --check.
10. Beskriv ændrede filer, tests og kendte begrænsninger i Pull Requesten.
11. Markér ikke en task som færdig uden testbevis.

## Rapportformat

Efter arbejdet skal agenten rapportere:

- Task-ID
- hvad der blev implementeret
- ændrede filer
- testkommandoer og resultater
- eventuelle beslutninger
- resterende problemer

