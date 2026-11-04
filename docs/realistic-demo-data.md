# Realistiske demoanalyser for 2026 — T-042

## Kortlægning før ændringer

Optællingen blev foretaget på den eksisterende Compose-volume, før T-042
ændrede indlæsningen. Den volume havde én ekstra operationel booking (ID 2105),
så tallet for bookinger/gæster er én højere end en frisk volume. Kilderne nedenfor
er seed-/loaderkilder, ikke nødvendigvis den seneste ændring af hver række.

| Tabel | Før: rækker | Kilde | Vurdering |
|---|---:|---|---|
| `bar_products` | 57 | Seeds 001, 002 og accepterede produktdata fra 004 | Referencedata, komplet katalog (39 cocktails, 18 kaffeprodukter) |
| `bar_sales` | 4 | Seed 001 | Kun håndskrevne eksempel-/testrækker; udvides fra accepterede aggregater |
| `booking_price_lines` | 5.690 | Seed 001, seed 005 og `school_demo.py` | Reelle demoophold og historiske prissnapshots; ikke kun testrækker |
| `booking_reviews` | 0 | API | Tom; udfyldes normalt via API, genereres nu for demoophold |
| `bookings` | 1.105 | Seed 001, seed 005, `school_demo.py` samt én lokal operationel booking | 1.100 importerede demoophold + 5 operationelle rækker; baselineeksemplerne er adskilt via oprindelse/ID, men har 2026-datoer |
| `csv_source_rows` | 0 | Kun `load_school_csv.py` | Tom; skal fortsat kun komme fra den valgfrie CSV-loader |
| `customer_bar_sales_aggregates` | 30 | Seed 004 | Accepterede kundekildeaggregater; bevaret som kildedata |
| `customer_stay_records` | 1.000 | Seed 004 | Accepterede anonymiserede kundekildeophold |
| `guests` | 1.105 | Seed 001, seed 005 og `school_demo.py` | Demo-/anonymiserede gæster plus lokal operationel gæst |
| `import_batches` | 4 | Seed 004/005 og `school_demo.py` | Importmarkører, komplet som metadata |
| `room_type_prices` | 24 | Seeds 001/002 | Referencetariffer, komplet som den er |
| `room_types` | 8 | Seeds 001/002 | Referencedata, komplet som den er |
| `rooms` | 214 | Seeds 001/002 | Referencedata, komplet som den er |
| `season_periods` | 6 | Seeds 001/003 | Sæsonreferencer inkl. jul, komplet som den er |
| `seasons` | 3 | Seed 001 | Referencedata, komplet som den er |

Forventningen om fire barsalgsrækker, ingen anmeldelser og tomme
`csv_source_rows` stemte. De fire baselinebookingeksempler er ikke udeladt fra
2026-analyserne: de ligger i 2026 og tæller derfor med, selvom de er operationelle
eksempler. Der var nul kapacitetsbrud og ingen eksisterende anmeldelser på
annullerede/fremtidige bookinger. Der var 803 bekræftede ophold med afsluttet
checkout pr. 4. november 2026.

## Implementering og valg

`database/import/realistic_demo_data.py` genererer de daterede salg og anmeldelser
deterministisk med seed `20261104`. To stabile markører i `import_batches`
forhindrer dubletter og gør eksisterende installationsvolumes opgraderbare.
`bar_sales` har ikke en oprindelseskolonne eller batch-FK; genererede salg får
derfor det faste `created_at`-stempel `2026-11-04 00:00:00`, som kontrolleres mod
bar-salgsmarkøren. Anmeldelser får almindelige FK'er til bookinger.

- Alle 179.958 accepterede enheder fra de 30 aggregater fordeles på salg med
  samme produkt, katalogpris og DKK-valuta. På den rene volume blev der dannet
  119.200 syntetiske transaktioner. De fire oprindelige seedrækker indeholder
  yderligere 10 enheder for 710 DKK, så tabellen i alt har 119.204 rækker og
  179.968 enheder. Mængder 1–2 er langt mest almindelige; 3–6 forekommer sjældent.
- Datoer vægtes efter gæstenætter, weekend og den konfigurerede sæsonkalender,
  inklusive jul. Kaffe tidsstemples 07–11 og 14–16; cocktails 17–01 lokal tid.
- Fem fiktive medarbejdernavne bruges: Helene Christine og fire tydeligt
  syntetiske Demo-navne. Helene får 42 % af de vægtede vagter i begge kategorier
  og er dermed central for US-005.
- 40 % af bekræftede bookinger med checkout før 2026-11-04 udvælges deterministisk
  til anmeldelser. Karaktererne hælder mod 4–5, med små variationer efter
  værelsestype/sæson. Anmeldelsestidspunktet ligger 1–4 dage efter checkout,
  højst på skæringsdatoen.
- De 1.000 kildeopholds historiske prislinjer ændres ikke, selvom 5.369 af de
  5.688 bekræftede linjer på den oprindelige volume ikke matcher de aktuelle
  `room_type_prices`. De er importerede snapshots af kildens totalsummer; at
  omprissætte dem ville ændre importerede omsætningstal. Nye mockbookinger bruger
  de aktuelle sæsonpriser. Dette er en eksisterende kildeprisforskel, ikke en ny
  skemafejl.

## Verifikation

På en ny, isoleret Compose-volume (`hka-realistic-demo-verified`) sås alle
runtime-containere sunde efter opstart. Friske antal: `bar_sales` 119.204,
`booking_reviews` 317, `bookings`/`guests` 1.104, `booking_price_lines` 5.687,
`csv_source_rows` 0, aggregater 30, kildeophold 1.000, `import_batches` 6,
produkter 57, tariffer 24, room types 8, rooms 214, sæsonperioder 6 og sæsoner 3.
Den anden `docker compose up --build -d --wait` gav uændrede 119.204 salg,
317 anmeldelser og 1.104 bookinger; begge nye importmarkører fandtes, og
produktmængderne havde nul afvigelser mod aggregaterne.

API-kald på den volume:

- `GET /api/analytics/bar-sales?year=2026`: Helene-filterets omsætning var
  5.651.287,53 DKK. Endpointet returnerer medarbejderens salg som standardfilter.
- `GET /api/analytics/customer-satisfaction?year=2026`: 317 bedømte ophold,
  803 kvalificerede ophold, svarprocent 39,48 %, gennemsnitskarakter 3,97;
  ratingfordeling 8×1, 14×2, 47×3, 157×4 og 91×5.
- Hele barens summer over alle medarbejdere, inklusive de fire seedrækker, var
  179.968 enheder og 13.449.350,34 DKK: cocktails 62.080 enheder /
  7.105.140,43 DKK; kaffe 117.888 enheder / 6.344.209,91 DKK. De genererede
  rækker alene afstemmes til 179.958 enheder / 13.448.640,34 DKK.

`docker compose --profile test run --build --rm api-tests`: 38 bestået, én
Starlette/httpx-deprecationsadvarsel. `foundation_checks.sql` køres også af
`load_demo_data.py` efter indlæsning og indeholder afstemnings-, periode-,
anmeldelses-, FK/CHECK-, medarbejder-, tidsvindue- og belægningskontroller.
`git diff --check` bestod. Der er ikke udført manuel Tableau UI-test.
