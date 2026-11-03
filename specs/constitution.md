# Constitution

## Status

Gældende projektprincipper. Tillægsopgave uge 2 er under specifikation og er endnu
ikke implementeret. MySQL-udgaven er bevaret som v1 i tagget `v1-mysql-tableau`.

## Autoritativt grundlag

PDF-opgaven, tillægsopgaven og PROJECT_GUIDE.md er kravgrundlag. Constitution
fastlægger principper; spec.md beskriver hvad, Clarify beslutninger og åbne
spørgsmål, Plan hvordan, og Tasks leverancer og verifikation.

## Ufravigelige principper

1. **3 lag.** API/presentation håndterer HTTP, JSON, validering og statuskoder.
   Service-laget håndterer forretningsregler, perioder, sæsoner og beregninger.
   Repository-laget håndterer SQLAlchemy, SQL, transaktioner og persistence.
2. **REST/JSON.** API’et er integrationsgrænsefladen. Request, response, fejl og
   statuskoder dokumenteres i OpenAPI.
3. **OpenAPI som kontrakt.** `openapi/openapi.yaml` er den normative, reviewede
   API-kontrakt. FastAPI-koden skal implementere den; Swagger UI er runtime-
   dokumentation.
4. **PostgreSQL.** PostgreSQL er måldatabasen for tillægsopgaven. Den relationelle
   model genbruges, SQLAlchemy er allerede i brug, og API-kontrakten bevares.
   MySQL var v1 og kan genskabes fra tagget `v1-mysql-tableau`.
5. **Kørbarhed.** Hele MVP’en skal kunne startes med én `docker compose up --build`.
   Services, Swagger UI og database skal være containeriserede.
6. **Live/opdaterbare data.** Nye og ændrede bookingdata skal kunne komme ind via
   booking-API’et og lagres i PostgreSQL uden kodeændring. Næste API-request ser
   ændringen; MVP’en kræver ikke WebSockets eller push.
7. **Dataintegritet.** Check-out er efter check-in, antal og priser valideres,
   gæsteantal må ikke overstige værelsestypens kapacitet, og aktive bookinger må
   ikke overlappe samme værelse.
8. **Analysebarhed.** Analyser beregnes i backend og eksponeres via REST/JSON.
   Tableau og frontend er kun forbrugere af API'et. Formler, perioder, sæsoner,
   valuta, annullering og manglende data defineres ét sted i service-laget.
9. **Kontraktstabilitet.** Skift af database må ikke ændre API-kontrakten.
   Eksisterende endpoints, felter og fejlkoder bevares.
10. **Sporbarhed.** Hvert krav spores til spec, user story, task og test i
    `specs/traceability.md`.
11. **Sikkerhed og samarbejde.** Secrets og lokale `.env`-filer må aldrig
    committes. Én branch løser én task, ændringer reviewes, og ukendte ændringer
    slettes ikke.
12. **Kvalitet før merge.** Relevante tests, OpenAPI-validering,
    `git diff --check`, Docker-smoketest og Converge-vurdering dokumenteres.

## MVP-afgrænsning

- Login, roller, betaling, WebSockets, produktionshosting og avancerede
  frontend-animationer er ikke MVP-krav.
- Kundetilfredshed er aktiveret ved brugerbeslutning 2026-10-28: rating 1–5 pr.
  afsluttet booking, gennemsnit og svarprocent. Ingen opdigtede scores.
- Tableau læser analyser fra API'et. Om dashboard fortsat er en obligatorisk
  leverance efter tillægsopgaven står åbent i `clarify.md`.
- Selvvalgt nøgletal er ikke valgt; beslutningen blokerer dets implementering.

## Leverancekontrol

Converge er en projektleverance, ikke en brugerstory. Den kommende Converge efter
tillægsopgaven skal vurdere alle sporbarhedsrækker som implementeret, delvist
implementeret eller mangler og dokumentere testbevis og resterende arbejde.
