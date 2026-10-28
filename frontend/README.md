# Bookingfrontend

Start hele applikationen fra repository-roden med `docker compose up --build -d`.
Åbn http://localhost:5500. HTML/CSS/vanilla JavaScript serveres af nginx uden build.
Frontend bruger den rigtige API som standard. nginx videresender `/api/`,
`/analytics/`, `/health`, `/docs`, `/openapi.json` og Swagger-assets til API-containeren.

Flow: søg ledige værelser → vælg værelse → indtast gæst → opret → se/redigér/annullér.
Frontendens service-lag er js/services/booking-service.js; HTTP-kontrakten findes i
../openapi/openapi.yaml og Swagger på http://localhost:8000/docs.

API'et beregner prisen. Redigeringsformularens pris er et estimat; det gemte svar
indeholder den endelige sæsonpris. Frontend kan ikke skifte værelse ved redigering,
selvom API'et understøtter det. På bedømte bookinger tillades kun email/telefon.

## Isoleret mock-demo

Brug `?mock=true` i URL'en. De syv mockværelser og tre mockbookinger er kun en UI-
demo i browserhukommelsen og nulstilles ved reload. De er ikke MySQL-referenceinventaret.

Alternativ statisk server: `npm start` fra frontend-mappen kræver Python 3.
Brug da `?mock=true`, eller `?mock=false&api=http://localhost:8000` for MySQL-API'et.

## Tests

`npm test` kræver Node 22+ og kører 59 unit-tests.
`npm run smoke` kører det isolerede mock-flow i Chrome (19 checks).
CHROME_PATH, SMOKE_PORT og SMOKE_DEBUG_PORT kan overskrive browser/porte.
Den containeriserede MySQL-/API-test findes i repositoryets README.
