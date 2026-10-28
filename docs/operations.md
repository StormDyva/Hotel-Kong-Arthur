# Drift lokalt med Docker Compose

## Start og adresser

Docker Desktop skal køre. Fra repository-roden:

```sh
docker compose up --build -d --wait
docker compose ps
```

Standarder: frontend 5500, API/Swagger 8000, MySQL 3307 på localhost.
Swagger: http://localhost:8000/docs. Frontendens /docs og /analytics fungerer også
via nginx. CORS tillader frontend-porten fra Compose, inklusive localhost/127.0.0.1.

Kopiér .env.example til .env for lokale værdier. MYSQL_DATABASE, MYSQL_USER,
MYSQL_PASSWORD og MYSQL_ROOT_PASSWORD bruges ved initialisering. MYSQL_PORT er
værtsporten; internt bruger API'et db:3306. API_PORT og FRONTEND_PORT er værtsporte.
Ændring af loginvariabler ændrer ikke allerede oprettede MySQL-brugere i en volume.
Brug de eksisterende credentials eller en eksplicit planlagt databaseændring.
.env må ikke committes. Eksempelpasswords er kun til lokal demo.

## Opstartsrækkefølge og opdatering

MySQL health → db-init (migrationer og seed) → API health → frontend health.
db-init afslutter med kode 0; det er forventet. Runtime-target starter uvicorn;
test-target starter pytest. Swagger JS/CSS er inkluderet i API-imaget.

Efter nye commits: `docker compose up --build -d --wait`. Nye migrations-/seedfiler
køres én gang og registreres i schema_migrations. Eksisterende seed genafspilles
ikke, så egne bookingændringer bevares. Ændr ikke en allerede anvendt migration;
tilføj en ny. Efter en ændring af nginx.conf kan frontend genstartes med
`docker compose restart frontend`, da en eksisterende nginx-proces cacher config.

## Stop og data

`docker compose down` stopper/fjerner containere og netværk, men bevarer mysql_data.
Sletning af volumenen fjerner data; brug ikke `down -v` på arbejdsinstallationen,
medmindre et bevidst reset er aftalt. Backup/restore til produktion er ikke valideret.
Historisk overskrevne kontaktoplysninger og rating-tilknytninger kræver autoritativ
kilde eller manuel kontrol; migrations forsøger ikke at opfinde mistede værdier.

## Tests og fejlsøgning

```sh
docker compose --profile test run --build --rm api-tests
docker compose logs --tail=100 db-init api frontend
```

Testprofilen har egen database, fixtures og test-image. App-volumenen bruges ikke.
Kundeimport kræver eksterne råfiler og kontrolleres særskilt, se customer-data-import.md.
Ved portkonflikt: vælg ledige porte i .env; intern MySQL-port forbliver 3306.
Ved migrationsfejl: inspicér db-init-loggen og databasens migrationstabel, ret med en
fremadrettet migration. Slet ikke arbejdsdata for at få en grøn healthcheck.

Tableau Public og den valgfrie Hyper-bro kører på værtsmaskinen, ikke i Compose.
Det manuelle dashboard og dets opdatering er fortsat en udestående leverance.

Testprofilen nulstiller altid hotel_kong_arthur_test på test-db før fixtures indlæses,
så tidligere importforsøg ikke påvirker testresultaterne. Appens database nulstilles
ikke. RESET_TEST_DATABASE må kun bruges med denne præcise testdatabase og host;
scriptet afviser andre kombinationer. Kør ikke flere test-runners samtidigt.
