# Tableau — REST API Connector

[Endpoint- og JSONPath-guide](../docs/tableau-rest-endpoints.md): kopierbare URLs,
JSONPath, felter, pagination og forklaring af tre lande i et nyt 2026-seed.

Brugeren har 2026-11-03 bekræftet REST API Connector som den aktive forbindelse.
Tableau læser JSON fra API'et; backend beregner priser, summer og KPI'er.
Ingen direkte databaseforbindelse, CSV-bro eller workbook-generator bruges.

1. Start `docker compose up --build -d --wait` fra repository-roden.
2. Konfigurér REST API Connector i Tableau Desktop med `http://localhost:8000`.
3. Tilføj de nødvendige endpoints som tabeller. Se
   [API-handoff](../docs/tableau-api-handoff.md) for kontrakter og felter.
4. De flade revenue-arrays bruger JSONPath `$[*]`; wrapper-svar med rækker i
   `data` bruger `$.data[*]`. Kontrollér altid connectorens datapreview.
5. Relatér kun tabeller med fælles nøgler og kompatibelt detaljeringsniveau.
   Samlede KPI'er må ikke joines til bookingrækker og summeres.
6. Efter bookingændringer: Data → Refresh All Extracts i Tableau.

Connectoren er extract-only, ikke en live-forbindelse. Se
[connectorens dokumentation](https://exchange.tableau.com/products/1111).
Den konkrete installation og dashboardets end-to-end-opdatering er endnu ikke
verificeret her. API-testbevis er ikke Tableau-testbevis.

`refresh.py`, `build_workbook.py` og eksisterende TWB/TWBX-/CSV-/Hyper-filer er
historiske v1-prototyper. De skal ikke porteres for PostgreSQL-migrationen og
bruges ikke i det aktive workflow.
