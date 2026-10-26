# Hotel Kong Arthur – samlet projektguide

**Formål:** Fælles arbejdsmanual for gruppen og alle AI-agenter, der arbejder på projektet.

**Projekt:** Hotelanalyse med backend, REST API, MySQL, Docker, OpenAPI/Swagger og Tableau.

**Første leverancesprint:** Mandag 26. oktober 2026 til fredag 30. oktober 2026.

**Bemærk:** Opgavedokumentet nævner præsentation fredag 6. november kl. 12.30–15.45. Hvis den dato gælder, bruges perioden efter sprintet til ekstra test og præsentationstræning.

---

## 1. Sådan bruges guiden

Denne fil er projektets fælles sandhedskilde for:

- krav og afgrænsning
- teknisk arkitektur
- Spec Kit-workflow
- terminal- og GitHub-arbejde
- AI-agenternes arbejdsregler
- test og kvalitetssikring
- definition of done

Alle gruppemedlemmer og AI-agenter skal læse denne fil, før de ændrer arkitektur, datamodel, API-kontrakt eller samarbejdsstruktur.

Hvis en beslutning ændrer krav eller arkitektur, skal denne fil eller en relevant fil under `specs/` opdateres i samme Pull Request.

---

## 2. Obligatoriske krav fra opgaven

Systemet skal:

1. analysere og præsentere data fra hotellets drift
2. have backend med 3-lagsarkitektur
3. levere REST/JSON
4. have OpenAPI-specifikation og fungerende Swagger UI
5. bruge MySQL
6. kunne startes med `docker compose up`
7. beregne hotellets nøgletal
8. have interaktivt Tableau-dashboard
9. have browserprototype til at oprette, redigere og slette bookinger
10. have README, CONTRIBUTING og arkitekturdiagram
11. være udviklet spec-drevet med GitHub Spec Kit
12. vise bidrag fra alle tre gruppemedlemmer gennem Git commits

### Hotelanalyser

- gæster fordelt på lande
- samlet indtjening
- indtjening pr. værelsestype
- indtjening pr. sæson
- indtjening pr. land
- mest indbringende værelsestype
- mest indbringende land
- årets samlede indtjening
- mindst ét ekstra relevant nøgletal

### Cocktailbar

- Helene Christines samlede salg for året
- omsætning pr. drink
- procentfordeling mellem cocktails og kaffe

### Datagrundlag

Eksempeldata findes i:

`https://github.com/ITAKEA/hoteldata`

CSV/XSLT-filerne er historiske eksempler. Prototypen skal behandle databasen som den aktuelle datakilde, så nye data kan indlæses uden at ændre kode.

---

## 3. MVP og prioritering

### MVP skal indeholde

- booking-CRUD
- MySQL-schema og seed-data
- 3-lags backend
- REST API
- OpenAPI/Swagger
- Docker Compose
- analyse-endpoints
- cocktailbar-endpoints
- simpel booking-frontend
- Tableau-dashboard
- Spec Kit-artefakter
- tests
- README, CONTRIBUTING og arkitekturdiagram
- afsluttende Converge-check

### Funktioner der kan vente

- login
- avanceret frontend-design
- WebSockets og ægte event streaming
- produktionshosting
- avancerede Tableau-animationer
- funktioner uden relation til et krav eller en user story

---

## 4. Spec Kit-workflow

Projektet følger:

```
Constitution → Specify → Clarify → Plan → Tasks → Implement → Converge
```

### Constitution

Fastlæg ufravigelige principper:

- API-kontrakten dokumenteres i OpenAPI
- backend følger 3-lagsarkitektur
- forretningslogik ligger i service-laget
- databaseadgang ligger i repository-laget
- API-laget håndterer HTTP, input og output
- MySQL er autoritativ datakilde
- alt kan køres med Docker Compose
- alle user stories har acceptkriterier
- API- og databaseændringer kræver spec-opdatering
- secrets må aldrig committes

### Specify

Beskriv brugere, funktioner og succeskriterier. Brug formatet:

```
Som <rolle> ønsker jeg <mål>, så <værdi>.
```

Eksempel:

```
Som receptionist ønsker jeg at oprette en booking, så systemet viser den aktuelle belægning.
```

### Clarify

Dokumentér beslutninger om:

- definition af “live”
- sæsoner
- belægningsgrad
- årets periode
- annullerede bookinger
- faktisk eller estimeret pris
- manglende data
- dobbeltbookinger

### Plan

Beskriv:

- valgt sprog og framework
- komponenter
- datamodel
- API
- Docker-services
- teststrategi
- Tableau-dataflow

### Tasks

Hver task skal have:

- ID
- user story
- beskrivelse
- afhængigheder
- filer/områder
- acceptkriterier
- testkommando

### Implement

Agenten implementerer én afgrænset task ad gangen og rapporterer:

- hvad der blev ændret
- ændrede filer
- testresultater
- mangler og antagelser

### Converge

Sammenlign implementeringen med constitution, specs, plan, tasks, user stories og acceptkriterier. Mangler bliver til nye tasks.

---

## 5. Repository-struktur

```
hotel-kong-arthur/
├── .github/
│   ├── workflows/ci.yml
│   └── pull_request_template.md
├── backend/
│   ├── src/
│   │   ├── api/
│   │   ├── services/
│   │   ├── repositories/
│   │   ├── models/
│   │   └── config/
│   └── tests/
├── frontend/
├── database/
│   ├── migrations/
│   └── seed/
├── tableau/
├── specs/
│   ├── constitution.md
│   ├── specify.md
│   ├── clarify.md
│   ├── plan.md
│   ├── tasks.md
│   └── user-stories.md
├── docs/
│   ├── architecture.md
│   ├── data-dictionary.md
│   ├── api-usage.md
│   ├── testing.md
│   └── decisions/
├── openapi/openapi.yaml
├── docker-compose.yml
├── .env.example
├── .gitignore
├── AGENTS.md
├── CONTRIBUTING.md
├── README.md
└── PROJECT_GUIDE.md
```

---

## 6. Fordeling mellem tre personer/agenter

### Spor A – Backend og API

- API-routes/controllers
- services
- OpenAPI
- validering
- API-tests

### Spor B – Database og analyse

- MySQL-schema
- migrations og seed-data
- repositories
- analysequeries
- nøgletal og formler

### Spor C – Frontend, Tableau og dokumentation

- booking-frontend
- Tableau-dashboard
- arkitekturdiagram
- README og præsentation
- demo-dokumentation

### Regler for AI-agenter

Agenten skal:

1. læse `PROJECT_GUIDE.md`, `AGENTS.md` og relevante specs
2. kontrollere `git status`
3. arbejde i egen branch
4. løse én task ad gangen
5. ændre mindst muligt
6. køre tests
7. køre `git diff --check`
8. bruge en tydelig commit-besked
9. beskrive ændringer og resterende problemer

Agenten må ikke:

- committe secrets
- ændre API eller database uden spec-opdatering
- lave brede refactors uden task
- bruge `git reset --hard` eller `git checkout --`
- slette ukendte ændringer
- markere en task som færdig uden testbevis

---

## 7. GitHub-samarbejde uden konflikter

### Brancher

```
main
develop
feature/<task-id>-<kort-navn>
fix/<task-id>-<kort-navn>
docs/<kort-navn>
```

Eksempel:

```bash
git switch main
git pull --rebase origin main
git switch -c feature/T-007-booking-crud
```

### Før arbejdet starter

```bash
git status
git fetch origin
git pull --rebase origin main
```

### Efter arbejdet

```bash
git status
git diff --check
git add <filer>
git commit -m "feat(api): implement booking CRUD"
git push -u origin feature/T-007-booking-crud
```

Opret Pull Request mod `main` eller `develop` efter gruppens aftale.

### Pull Request skal indeholde

- task-ID
- beskrivelse
- ændrede filer
- testkommandoer og resultat
- databaseændringer
- API-ændringer
- screenshots ved frontend/Tableau
- kendte begrænsninger

Mindst ét andet gruppemedlem skal reviewe. API-, database- og Docker-ændringer skal reviewes af mindst to personer.

### Konfliktforebyggelse

- én person ændrer migrationsfiler ad gangen
- én person ejer den aktive OpenAPI-kontrakt ad gangen
- API-kontrakten aftales før frontend bygges
- Tableau bygger mod en dokumenteret datakilde
- merge ofte og hold PR’er små
- ingen direkte commits til `main`, medmindre gruppen udtrykkeligt aftaler det

Ved konflikt:

```bash
git status
git fetch origin
git rebase origin/main
```

Hvis konflikten ændrer en API-kontrakt, datamodel eller analyseformel, skal gruppen beslutte løsningen og dokumentere den i `docs/decisions/`.

---

## 8. Teknisk arkitektur

```
Frontend / Tableau
        │
        ▼
Presentation layer
REST endpoints, JSON, validation, HTTP status codes
        │
        ▼
Service layer
Business rules, calculations, season logic, analytics
        │
        ▼
Data access layer
Repositories, SQL queries, transactions
        │
        ▼
MySQL
```

Regler:

- controllers må ikke indeholde SQL
- repositories må ikke kende HTTP
- services skal kunne testes uden webserver
- beregninger skal være navngivne funktioner
- databaseforbindelse kommer fra miljøvariabler

### Docker

Minimumservices:

- `api`
- `db`
- `frontend`, hvis den kører separat

Krav:

- `docker compose up --build` starter systemet
- MySQL har persistent volume
- database healthcheck bruges
- secrets kommer fra `.env`
- `.env.example` indeholder kun eksempelværdier

Eksempel:

```env
MYSQL_DATABASE=hotel_kong_arthur
MYSQL_USER=hotel_app
MYSQL_PASSWORD=change_me_locally
MYSQL_ROOT_PASSWORD=change_me_locally
DATABASE_URL=mysql://hotel_app:change_me_locally@db:3306/hotel_kong_arthur
API_PORT=8000
```

---

## 9. Datamodel

### `room_types`

`id`, `name`, `capacity`, `base_price_low_season`, `base_price_mid_season`, `base_price_high_season`

### `rooms`

`id`, `room_number`, `room_type_id`, `active`

### `guests`

`id`, `country_code`, `country_name`

### `bookings`

`id`, `guest_id`, `room_id`, `check_in`, `check_out`, `guests_count`, `price_total`, `status`, `created_at`, `updated_at`

### `bar_products`

`id`, `name`, `category` (cocktail/coffee), `price`

### `bar_sales`

`id`, `product_id`, `sold_at`, `quantity`, `unit_price`, `employee_name`

Datakvalitet:

- checkout skal være efter check-in
- negative priser og antal afvises
- dobbeltbookinger afvises
- annullerede bookinger tæller ikke i analyser
- valuta er DKK
- seed-data skal kunne genskabe demoen

---

## 10. Nøgletal og formler

Implementér formlerne ét sted i service-laget og test dem.

### Belægningsgrad

```
belægningsgrad =
solgte værelsesnætter / tilgængelige værelsesnætter * 100
```

```
tilgængelige værelsesnætter =
aktive værelser * antal dage i perioden
```

Annullerede bookinger tæller ikke som solgte nætter.

### Hotelindtjening

```
indtjening =
sum(price_total for gyldige, ikke-annullerede bookinger)
```

### Cocktailbar

```
omsætning pr. produkt = sum(quantity * unit_price)
samlet barsalg = sum(quantity * unit_price)
cocktailandel = cocktailomsætning / samlet barsalg * 100
kaffeandel = kaffeomsætning / samlet barsalg * 100
```

Dokumentér altid periode, filtre og håndtering af manglende data.

---

## 11. API-kontrakt

Minimum-endpoints:

```
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
```

API’et skal:

- bruge JSON
- returnere korrekte HTTP-statuskoder
- validere request bodies
- have ensartede fejlresponser
- dokumentere filtre for dato, land, sæson og værelsestype
- være beskrevet i `openapi/openapi.yaml`

Forslag til fejlformat:

```json
{
  "error": "VALIDATION_ERROR",
  "message": "check_out must be after check_in",
  "details": []
}
```

---

## 12. User stories og acceptkriterier

### US-001 – Opret booking

Som receptionist ønsker jeg at oprette en booking, så systemet viser den aktuelle belægning.

Acceptkriterier:

- gyldige data gemmes
- ugyldige data giver forståelig fejl
- bookingen ses via `GET /bookings`
- bookingen påvirker analyser

### US-002 – Redigér booking

Som receptionist ønsker jeg at redigere en booking, så ændringer afspejles i systemet.

Acceptkriterier:

- eksisterende booking kan ændres
- ugyldige datoer afvises
- frontend og API viser ændringen
- analyser opdateres

### US-003 – Annullér booking

Som receptionist ønsker jeg at annullere en booking, så belægningen bliver korrekt.

Acceptkriterier:

- booking kan slettes eller markeres annulleret
- annulleret booking tæller ikke i belægning eller indtjening
- handlingen er dokumenteret

### US-004 – Se belægningsgrad

Som hoteladministrator ønsker jeg at se belægningsgraden, så jeg kan vurdere kapacitetsudnyttelsen.

Acceptkriterier:

- resultatet kan filtreres på periode
- formlen er dokumenteret
- resultatet kan genberegnes fra database-data

### US-005 – Analysér hotelindtjening

Som hoteladministrator ønsker jeg at se indtjening efter værelsestype, land og sæson, så jeg kan træffe bedre beslutninger.

Acceptkriterier:

- årets samlede indtjening vises
- indtjening pr. værelsestype vises
- indtjening pr. land vises
- mest indbringende kategori fremgår

### US-006 – Analysér cocktailbaren

Som hoteladministrator ønsker jeg at se barens salg, så jeg kan se hvilke produkter der skaber omsætning.

Acceptkriterier:

- samlet årligt salg vises
- omsætning pr. produkt vises
- cocktails og kaffe vises som procentfordeling

### US-007 – Brug Tableau-dashboard

Som beslutningstager ønsker jeg et interaktivt dashboard, så jeg kan undersøge data uden SQL.

Acceptkriterier:

- filtre virker
- KPI’er stemmer med API/database
- hotel- og baranalyse vises
- dashboardet kan demonstreres

---

## 13. Teststrategi

Før hvert commit:

```bash
git diff --check
```

Minimumstest:

- databaseforbindelse
- `GET /health`
- booking-CRUD
- datovalidering
- prisvalidering
- dobbeltbooking
- annullerede bookinger
- belægningsgrad
- hotelindtjening
- cocktailbar-beregninger
- OpenAPI-validering
- Docker Compose-opstart

Manuel smoke test:

```bash
docker compose up --build
```

Kontrollér:

1. Swagger UI åbner
2. `GET /health` svarer OK
3. booking kan oprettes
4. booking kan redigeres
5. booking kan annulleres eller slettes
6. analyse-endpoints returnerer data
7. frontend kalder API’et
8. Tableau viser forventede tal

---

## 14. Fem-dages plan

### Mandag – scope og fundament

- gennemgå krav
- opret Constitution, Specify og Clarify
- fastlæg antagelser
- vælg stack
- tegn arkitektur
- opret repository- og Docker-struktur

**Færdig når:** alle forstår scope, arkitektur og beslutninger.

### Tirsdag – database og backend

- MySQL-schema
- seed-data
- 3-lags backend
- booking-CRUD
- OpenAPI og Swagger

**Færdig når:** API og database kører i Docker.

### Onsdag – analyser, frontend og Tableau

- hotelnøgletal
- cocktailbar-analyse
- simpel booking-frontend
- Tableau-forbindelse
- dokumenterede formler

**Færdig når:** booking til analyse kan demonstreres.

### Torsdag – integration og kvalitet

- test alle flows
- sammenlign API, database og Tableau
- ret kritiske fejl
- gennemfør Converge
- opdatér dokumentation

**Færdig når:** alle obligatoriske user stories er vurderet.

### Fredag – aflevering og præsentation

- ren installation
- færdig README og CONTRIBUTING
- færdig præsentation
- demo-træning
- backup
- merge godkendte branches

**Færdig når:** projektet kan demonstreres uden manuel fejlfinding.

---

## 15. Standardprompt til en AI-agent

Kopiér dette ind, når en agent får en task:

```
Du arbejder på Hotel Kong Arthur-projektet.

Læs først PROJECT_GUIDE.md, AGENTS.md og relevante filer under specs/.

Arbejd kun på den angivne task og branch.

Før du ændrer kode:
1. Kontrollér git status.
2. Find acceptance criteria.
3. Find eksisterende mønstre.
4. Beskriv kort din plan.

Mens du arbejder:
- følg 3-lagsarkitekturen
- ændr ikke API eller database uden at opdatere specs og OpenAPI
- commit ikke secrets
- slet ikke ukendte ændringer
- lav den mindst mulige ændring

Efter ændringen:
1. Kør relevante tests.
2. Kør git diff --check.
3. Kontrollér at dokumentation og kode stemmer.
4. Rapportér ændrede filer.
5. Rapportér testkommandoer og resultater.
6. Rapportér kendte begrænsninger.

Markér ikke tasken som færdig, hvis acceptkriterierne ikke er testet.
```

---

## 16. Første terminalopsætning

Kør fra den mappe, hvor GitHub-repository’et skal ligge:

```bash
git clone <JERES_GITHUB_REPOSITORY_URL>
cd <REPOSITORY_MAPPE>
git switch main
git pull --rebase origin main
mkdir -p specs docs/decisions openapi database/migrations database/seed tableau
touch AGENTS.md CONTRIBUTING.md README.md
```

Kopiér denne fil til repository-roden som `PROJECT_GUIDE.md`.

Første commit:

```bash
git add PROJECT_GUIDE.md AGENTS.md CONTRIBUTING.md README.md specs docs openapi database tableau
git commit -m "docs: establish project guide and collaboration rules"
git push origin main
```

Hvis gruppen ikke ønsker direkte commit til `main`, skal committen laves på en branch og godkendes via Pull Request.

---

## 17. Første tasks

```
T-001 Afklar teknologistak og skriv constitution
T-002 Skriv specify, clarify og user stories
T-003 Opret Docker Compose og miljøkonfiguration
T-004 Design og implementér MySQL-schema
T-005 Indlæs seed-data
T-006 Opret backendens 3-lagsstruktur
T-007 Implementér booking CRUD
T-008 Skriv og valider OpenAPI-kontrakt
T-009 Implementér hotelanalyse-endpoints
T-010 Implementér cocktailbar-endpoints
T-011 Opret booking-frontend
T-012 Opret Tableau-dashboard
T-013 Skriv automatiske tests
T-014 Skriv README og arkitekturdiagram
T-015 Gennemfør Converge og luk mangler
T-016 Forbered og test præsentation
```

En task er først færdig, når acceptkriterierne er opfyldt og et andet gruppemedlem har reviewet resultatet.

---

## 18. Afsluttende Converge-checkliste

### Arkitektur

- [ ] 3-lagsarkitekturen kan forklares
- [ ] controllers indeholder ikke SQL
- [ ] services indeholder forretningslogik
- [ ] repositories håndterer databaseadgang
- [ ] MySQL bruges

### API

- [ ] booking CRUD virker
- [ ] analyse-endpoints virker
- [ ] OpenAPI stemmer med koden
- [ ] Swagger UI åbner
- [ ] fejlresponser er dokumenteret

### Data og analyse

- [ ] seed-data kan genskabes
- [ ] belægningsgrad er testet
- [ ] årets indtjening er testet
- [ ] indtjening pr. værelsestype er testet
- [ ] indtjening pr. land er testet
- [ ] cocktailbar er testet
- [ ] formler er dokumenteret

### Docker og drift

- [ ] `docker compose up --build` virker
- [ ] healthcheck virker
- [ ] `.env.example` findes
- [ ] ingen secrets er committet
- [ ] README kan følges fra ren checkout

### Samarbejde

- [ ] alle tre har commits
- [ ] alle branches er reviewet
- [ ] ingen uafklarede konflikter
- [ ] PR’er beskriver tests
- [ ] dokumentation er opdateret

### Præsentation

- [ ] demo er testet fra ren opstart
- [ ] præsentationen varer højst 10 minutter
- [ ] alle tre kan forklare deres del
- [ ] arkitekturdiagrammet er klart
- [ ] begrænsninger er dokumenteret

---

## 19. Beslutningslog

| Dato | Beslutning | Begrundelse | Påvirker | Ansvarlig |
|---|---|---|---|---|
| 2026-10-26 | MVP prioriteres først | Sikrer levering af obligatoriske krav | Hele projektet | Gruppen |
| 2026-10-26 | Spec Kit bruges som workflow | Krævet af opgaven og giver sporbarhed | specs, tasks, review | Gruppen |
| 2026-10-26 | Branches og Pull Requests bruges | Reducerer konflikter mellem tre udviklere/agenter | GitHub | Gruppen |

Tilføj nye beslutninger løbende.

---

## 20. Den vigtigste arbejdsregel

Byg ikke mere, før det eksisterende kan forklares, testes og dokumenteres.

Projektet er ikke færdigt, fordi koden kan køre. Det er færdigt, når krav, spec, kode, database, API, Tableau, tests, dokumentation og præsentation hænger sammen og kan demonstreres af hele gruppen.

