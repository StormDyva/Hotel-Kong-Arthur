# START HER – Hotel Kong Arthur

Denne fil forklarer hele projektforløbet fra første dag til aflevering. Alle tre gruppemedlemmer og alle AI-agenter skal begynde her.

## Målet

Vi skal levere en fungerende MVP med:

- 3-lags backend
- REST/JSON API
- OpenAPI og Swagger UI
- MySQL
- Docker Compose
- booking-CRUD
- hotel- og cocktailbar-analyser
- Tableau-dashboard
- dokumentation
- Spec Kit-artefakter
- færdig præsentation

Projektet skal kunne startes af en ny person ved at følge README’en.

## Fase 0 – Fælles start

Før nogen skriver kode, skal gruppen:

1. vælge ét GitHub-repository
2. beslutte hvem der arbejder med hvilket spor
3. læse PROJECT_GUIDE.md
4. aftale programmeringssprog og framework
5. aftale branchestrategi
6. oprette de første Spec Kit-filer

Alle skal være enige om:

- hvad “live data” betyder
- hvordan sæsoner defineres
- hvordan belægningsgrad beregnes
- hvordan annullerede bookinger håndteres
- hvordan årets indtjening beregnes
- hvilken dato/årperiode analyserne bruger

## Fase 1 – Klon repository’et

Hver person arbejder med sin egen lokale kopi.

~~~
git clone <JERES_GITHUB_REPOSITORY_URL>
cd <REPOSITORY_MAPPE>
git switch main
git pull --rebase origin main
git status
~~~

Der må ikke være ukendte ændringer i working tree, før man begynder på en task.

Kopiér PROJECT_GUIDE.md ind i repository-roden. Den skal ligge sådan:

~~~
repository/
├── PROJECT_GUIDE.md
├── README.md
├── AGENTS.md
└── ...
~~~

## Fase 2 – Opret dokumentationen

Opret:

~~~
mkdir -p specs docs/decisions openapi database/migrations database/seed tableau frontend backend
touch AGENTS.md CONTRIBUTING.md README.md
~~~

Opret derefter under specs/:

~~~
constitution.md
specify.md
clarify.md
plan.md
tasks.md
user-stories.md
~~~

Indholdet skal beskrive projektet, før AI-agenten implementerer det.

## Fase 3 – Constitution, Specify og Clarify

### Constitution

Beskriv de faste principper:

- 3-lagsarkitektur
- REST/JSON
- OpenAPI
- MySQL
- Docker Compose
- test før merge
- ingen secrets i Git
- API- og databaseændringer kræver dokumentation

### Specify

Beskriv:

- receptionistens bookingfunktioner
- administratorens analyser
- Tableau-dashboardet
- cocktailbarens analyse
- systemets succeskriterier

### Clarify

Skriv beslutninger om:

- belægningsgradsformel
- sæsoner
- “live”
- årets periode
- annullerede bookinger
- prisberegning
- manglende data
- dobbeltbookinger

Disse tre filer skal godkendes af hele gruppen.

## Fase 4 – Fordel arbejdet

### Spor A – Backend og API

- REST endpoints
- services
- validering
- OpenAPI
- API-tests

### Spor B – Database og analyser

- MySQL-schema
- migrations
- seed-data
- repositories
- analysequeries
- nøgletal

### Spor C – Frontend, Tableau og dokumentation

- browserfrontend
- Tableau-dashboard
- README
- arkitekturdiagram
- præsentation

Hver person og agent arbejder i sin egen branch.

## Fase 5 – Git branches

Branch-navne:

~~~
feature/T-004-database
feature/T-007-booking-api
feature/T-011-frontend
feature/T-012-tableau
docs/project-documentation
~~~

Opret en branch:

~~~
git switch main
git pull --rebase origin main
git switch -c feature/T-007-booking-api
~~~

En branch skal løse én afgrænset task.

## Fase 6 – Byg fundamentet først

Implementér i denne rækkefølge:

1. Docker Compose
2. MySQL
3. database-schema
4. seed-data
5. backendens 3 lag
6. health endpoint
7. booking CRUD
8. OpenAPI og Swagger
9. analyse-services
10. frontend
11. Tableau
12. tests og dokumentation

Byg ikke Tableau eller frontend på en API-kontrakt, som stadig ændrer sig.

## Fase 7 – Database

Minimumstabeller:

- room_types
- rooms
- guests
- bookings
- bar_products
- bar_sales

Databasearbejdet skal indeholde migrations, seed-data, constraints, relevante indeks, datadictionary og mulighed for at genskabe demo-data.

## Fase 8 – Backend og API

Minimum-endpoints:

~~~
GET    /health
GET    /bookings
GET    /bookings/{id}
POST   /bookings
PUT    /bookings/{id}
DELETE /bookings/{id}
GET    /room-types
GET    /analytics/occupancy
GET    /analytics/revenue
GET    /analytics/revenue-by-room-type
GET    /analytics/revenue-by-country
GET    /analytics/bar-sales
~~~

Regler:

- controllers håndterer HTTP
- services håndterer forretningsregler
- repositories håndterer SQL
- OpenAPI opdateres sammen med API-koden
- fejl skal være ensartede og forståelige

## Fase 9 – Frontend og Tableau

Frontend skal kunne:

- vise bookinger
- oprette booking
- redigere booking
- slette eller annullere booking
- vise fejl
- hente data fra API’et

Tableau skal vise:

- årets indtjening
- belægningsgrad
- gæster pr. land
- indtjening pr. værelsestype
- indtjening pr. sæson
- indtjening pr. land
- cocktailbarens omsætning
- procentfordeling mellem cocktails og kaffe
- mindst ét ekstra nøgletal

Alle Tableau-tal skal kunne forklares ud fra API’et eller databasen.

## Fase 10 – Tests

Før en task kan merges, skal den testes.

Minimum:

- booking CRUD
- ugyldige datoer
- negative priser
- dobbeltbooking
- annulleret booking
- belægningsgrad
- hotelindtjening
- cocktailbar
- API-statuskoder
- OpenAPI
- Docker-opstart

Kør altid:

~~~
git diff --check
~~~

## Fase 11 – Pull Request

Når tasken er færdig:

~~~
git status
git diff --check
git add <filer>
git commit -m "feat(api): implement booking CRUD"
git push -u origin feature/T-007-booking-api
~~~

Pull Request skal indeholde task-ID, ændringer, testkommandoer, resultater, screenshots hvis relevant og begrænsninger.

Et andet gruppemedlem reviewer. Først derefter merges PR’en.

## Fase 12 – Hold lokale kopier opdaterede

Efter en merge:

~~~
git switch main
git pull --rebase origin main
~~~

Opret derefter en ny branch fra den opdaterede main.

## Fase 13 – Converge

Sammenlign krav, specs, plan, tasks, user stories, kode, tests, Tableau og dokumentation.

Alt, der mangler, skrives som en ny task. Intet markeres som færdigt uden acceptkriterier og testbevis.

## Fase 14 – Aflevering

README skal forklare:

- projektets formål
- teknologistak
- installation
- docker compose up
- Swagger URL
- database
- Tableau
- API-eksempler
- arkitektur
- test
- kendte begrænsninger

Præsentationen skal indeholde:

1. problem og formål
2. arkitektur
3. booking-demo
4. Tableau-dashboard
5. brug af Spec Kit og AI
6. begrænsninger og videre arbejde

## Hvem gør hvad nu?

Første møde:

1. Person 1 kloner repository og opretter grundstruktur.
2. Person 2 skriver datamodel og Clarify-beslutninger.
3. Person 3 skriver user stories, acceptkriterier og README-start.
4. Gruppen samler ændringerne i én Pull Request.
5. Gruppen godkender Constitution, Specify og Clarify.
6. Først derefter starter implementeringen.

## Den vigtigste regel

Ingen agent må bare bygge løs. Hver ændring skal være knyttet til en task, en user story og et acceptkriterium.

