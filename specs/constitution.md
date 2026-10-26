# Constitution

## Status

Approved as working agreement – 2026-10-26. Dette dokument er den fælles ramme for projektet.

## Autoritativt grundlag

PDF-opgaven og PROJECT_GUIDE.md er kravgrundlag. Constitution fastlægger principper; Specify beskriver hvad, Clarify beslutninger og antagelser, Plan hvordan, og Tasks leverancer og verifikation.

## Ufravigelige principper

1. **3 lag.** API/presentation håndterer HTTP, JSON, validering og statuskoder. Service-laget håndterer forretningsregler, perioder, sæsoner og beregninger. Repository-laget håndterer SQLAlchemy, SQL, transaktioner og persistence.
2. **REST/JSON.** API’et er integrationsgrænsefladen. Request, response, fejl og statuskoder dokumenteres i OpenAPI.
3. **OpenAPI som kontrakt.** openapi/openapi.yaml er den normative, reviewede API-kontrakt. FastAPI-koden skal implementere den; Swagger UI er runtime-dokumentation.
4. **MySQL.** MySQL er autoritativ runtime-datakilde. CSV/XSLT må bruges til seed/import, men ikke som eneste live-datakilde.
5. **Kørbarhed.** Hele MVP’en skal kunne startes med docker compose up eller docker compose up --build. Services, Swagger UI og database skal være containeriserede.
6. **Live/opdaterbare data.** Nye og ændrede bookingdata skal kunne komme ind via booking-API’et og lagres i MySQL uden kodeændring. MVP’en kræver ikke WebSockets eller event streaming.
7. **Dataintegritet.** Check-out er efter check-in, antal og priser valideres, gæsteantal må ikke overstige værelsestypens kapacitet, og aktive bookinger må ikke overlappe samme værelse.
8. **Analysebarhed.** Belægning, indtjening, sæsoner, perioder, valuta, annullering og manglende data defineres ét sted i service-laget og testes.
9. **Sporbarhed.** Hvert PDF-krav spores til spec, user story, task og test i specs/traceability.md.
10. **Sikkerhed og samarbejde.** Secrets og lokale .env-filer må aldrig committes. Én branch løser én task, ændringer reviewes, og ukendte ændringer slettes ikke.
11. **Kvalitet før merge.** Relevante tests, OpenAPI-validering, git diff --check, Docker-smoketest og Converge-vurdering dokumenteres.

## MVP-afgrænsning

- Login, roller, betaling, WebSockets, produktionshosting og avancerede frontend-animationer er ikke MVP-krav.
- Kundetilfredshed nævnes i PDF’en, men PDF’en giver ingen datakilde, skala eller formel. Det er derfor en eksplicit MVP-afgrænsning, indtil gruppen eller underviseren godkender definition og data. Se C-009.
- Tableau skal vise godkendte KPI’er og dokumentere refresh; ægte push-refresh er ikke et MVP-krav.

## Kvalitetstjek

- Er kravet entydigt? Ja, med kundetilfredshed som eksplicit afgrænset beslutning.
- Kan det implementeres? Ja, beslutningerne er godkendt som arbejdsgrundlag.
- Kan det testes? Ja, via lag-, API-, data-, analyse-, Docker- og Converge-tests.
- Er det dækket af user stories og tasks? Ja, se user-stories.md, tasks.md og traceability.md.
- Er der afhængigheder? Ja: Clarify skal godkendes før schema, API og analyser.
