# Drift lokalt med Docker Compose

## Start og adresser

Docker Desktop skal køre. Fra repository-roden:

```sh
docker compose up --build -d --wait
docker compose ps
```

Standarder: frontend 5500, API/Swagger 8000, PostgreSQL 5433 på localhost.
Swagger: http://localhost:8000/docs. Frontendens /docs og /analytics fungerer også
via nginx. CORS tillader frontend-porten fra Compose, inklusive localhost/127.0.0.1.

Kopiér .env.example til .env for lokale værdier. POSTGRES_DB, POSTGRES_USER, POSTGRES_PASSWORD samt
POSTGRES_ADMIN_USER/POSTGRES_ADMIN_PASSWORD bruges ved initialisering. POSTGRES_PORT er
værtsporten; internt bruger API'et db:5432. API_PORT og FRONTEND_PORT er værtsporte.
Ændring af loginvariabler ændrer ikke allerede oprettede PostgreSQL-brugere i en volume.
Brug de eksisterende credentials eller en eksplicit planlagt databaseændring.
.env må ikke committes. Eksempelpasswords er kun til lokal demo.

## Opstartsrækkefølge og opdatering

PostgreSQL health → db-init (schema/seed) → demo-init (1.000 + 100 skoleophold i
2026) → API health → frontend health. db-init og demo-init afslutter med kode 0;
det er forventet. Eksisterende volumes opgraderes uden reset. Demo-versionen
gemmes atomisk i import_batches, så genstart ikke tilføjer dubletter. Runtime-target starter uvicorn;
test-target starter pytest. Swagger JS/CSS er inkluderet i API-imaget.

Efter nye commits: `docker compose up --build -d --wait`. Nye migrations-/seedfiler
køres én gang og registreres i schema_migrations. Eksisterende seed genafspilles
ikke, så egne bookingændringer bevares. Ændr ikke en allerede anvendt migration;
tilføj en ny. Efter en ændring af nginx.conf kan frontend genstartes med
`docker compose restart frontend`, da en eksisterende nginx-proces cacher config.

## Stop og data

`docker compose down` stopper/fjerner containere og netværk, men bevarer postgres_data (og den gamle mysql_data).
Sletning af volumenen fjerner data; brug ikke `down -v` på arbejdsinstallationen,
medmindre et bevidst reset er aftalt. Backup/restore til produktion er ikke valideret.
Historisk overskrevne kontaktoplysninger og rating-tilknytninger kræver autoritativ
kilde eller manuel kontrol; migrations forsøger ikke at opfinde mistede værdier.

## Tests og fejlsøgning

```sh
docker compose --profile test run --build --rm api-tests
docker compose logs --tail=100 db-init demo-init api frontend
```

Testprofilen har egen database, fixtures og test-image. App-volumenen bruges ikke.
Kundeimport kræver eksterne råfiler og kontrolleres særskilt, se customer-data-import.md.
Ved portkonflikt: vælg ledige porte i .env; intern PostgreSQL-port forbliver 5432.
Ved migrationsfejl: inspicér db-init-loggen og databasens migrationstabel, ret med en
fremadrettet migration. Slet ikke arbejdsdata for at få en grøn healthcheck.

Tableau Desktop bruger REST API Connector mod localhost:8000. Connectoren
bruger extracts; opdatér med Data → Refresh All Extracts. Den gamle Hyper-bro
er historisk og bruges ikke.
Det manuelle dashboard og dets opdatering er fortsat en udestående leverance.

Testprofilen nulstiller altid hotel_kong_arthur_test på test-db før fixtures indlæses,
så tidligere importforsøg ikke påvirker testresultaterne. Appens database nulstilles
ikke. RESET_TEST_DATABASE må kun bruges med denne præcise testdatabase og host;
scriptet afviser andre kombinationer. Kør ikke flere test-runners samtidigt.

Den gamle MySQL-volume bruges ikke på denne branch. Se postgres-migration.md.
