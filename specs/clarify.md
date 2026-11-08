# Clarify

## Status

Beslutningerne fra 2026-10-26/28 er den godkendte v1-baseline. Uge 2-beslutningerne
C-012–C-018 er afklaret. C-016's manuelle Tableau-refresh er ikke automatisk
verificeret; denne begrænsning beskrives i den seneste Converge.

### C-001 – Live data og opdateringsmekanisme (opdateret for uge 2)

- **Beslutning:** Live betyder aktuelle data fra runtime-databasen læst ved hvert
  API-request. Runtime-målet er nu PostgreSQL (C-012). POST, PUT og DELETE på
  booking-API’et er primær MVP-mekanisme.
- **Begrundelse:** PDF’en kræver løbende opdaterbare og live data, men ikke event streaming.
- **Konsekvens:** Næste API-request ser ændringen. Frontend henter analysen igen
  efter valgt opdateringsmåde (C-015). Hvis Tableau fortsat bruges, opdateres det
  via API ved manuel/planlagt refresh. Ingen WebSockets eller push.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-002 – CSV/XLSX seed/import (opdateret for uge 2)

- **Beslutning:** CSV/XLSX fra ITAKEA/hoteldata bruges til reproducerbar
  seed/import og historisk demo-data. Importen skriver til PostgreSQL og er ikke
  runtime-klient eller API-kontrakt.
- **Begrundelse:** PDF’en beskriver filerne som statiske og historiske.
- **Konsekvens:** Nye live-bookinger kommer via API’et. Importjob skal være idempotent eller have dokumenteret reset-strategi.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-003 – Standardår og periode

- **Beslutning:** Året er kalenderåret 1. januar–31. december. Alle analyser kan angive from og to. Standardåret er 2026, fordi det er projektets aktuelle kalenderår.
- **Begrundelse:** Kalenderåret er entydigt.
- **Konsekvens:** Datoer er ISO 8601-kalenderdatoer i Europe/Copenhagen; timestamps lagres i UTC.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-004 – Sæsondefinition

- **Beslutning:** Lavsæson: 1/1–31/3 og 1/11–19/12. Mellemsæson: 1/4–31/5 og 1/9–31/10. Højsæson: 1/6–31/8 og 20/12–31/12.
- **Begrundelse:** Reproducerbar tre-sæson-model, der passer til sæsonpriser.
- **Konsekvens:** Sæson bestemmes pr. overnatningsnat. Julegrænserne 20.–31. december er en projektantagelse.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-005 – Belægningsgrad

- **Beslutning:** Belægningsgrad = solgte værelsesnætter / tilgængelige værelsesnætter * 100. Solgte nætter er aktive, ikke-annullerede bookings overlappende perioden. Tilgængelige nætter = aktive værelser * kalenderdage i perioden. Check-out-dag tæller ikke.
- **Begrundelse:** Entydig kapacitetsformel.
- **Konsekvens:** Division med nul giver 0 og warning metadata. Resultat over 100 % er datakvalitetsfejl, som skal rapporteres.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-006 – Annullering versus DELETE

- **Beslutning:** DELETE er soft delete: status sættes til cancelled, rækken bevares, og booking tæller ikke i overlap, belægning eller indtjening. Hård sletning er ikke normal API-operation.
- **Begrundelse:** Historik bevares og værelset frigives.
- **Konsekvens:** Gentaget DELETE er idempotent og returnerer samme resource eller 204.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-007 – Prisberegning

- **Beslutning:** Sæsonpriser ligger i room_type_prices og slås op pr. overnatningsnat. bookings.price_total er den gemte faktiske bookingpris, og booking_price_lines dokumenterer prisberegningen.
- **Begrundelse:** Booking-flowet skal kunne beregne en reproducerbar pris ud fra værelsestype, dato/sæson og antal nætter, samtidig med at historiske priser bevares som snapshots.
- **Konsekvens:** Ved oprettelse beregnes price_total som summen af prislinjer. Valuta er DKK, price_total >= 0, og frontend/API-klienten sender ikke den endelige pris som autoritativ værdi. Rabatter, morgenmad, skatter, weekendtillæg og dynamiske priser er uden for MVP.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-008 – Helene Christine-filter

- **Beslutning:** employee_name = Helene Christine er filter for baranalysen. Årsrapporten for Helene omfatter kun hendes salg.
- **Begrundelse:** PDF’en spørger specifikt efter Helene Christines samlede salg.
- **Konsekvens:** API’et understøtter employee_name. Samlet barrapport kan være ekstra, men erstatter ikke Helene-rapporten.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-009 – Kundetilfredshed

Brugerbeslutning 2026-10-28: aktiv 1–5-rating pr. afsluttet confirmed booking.
Gennemsnit og svarprocent beregnes for checkout-kohorten. Ingen syntetiske ratings.
Bedømte ophold låser gæst/ophold; kun email/telefon må rettes. Tidligere fravalg er
ophævet. Se den daterede beslutning nedenfor.

### C-010 – Manglende data og division med nul

- **Beslutning:** Manglende obligatoriske input afvises. Ingen matching data returnerer tomme grupper og metadata. Nævner 0 returnerer procent 0 og warning.
- **Begrundelse:** Resultater skal være ærlige og maskinlæsbare.
- **Konsekvens:** Frontend/Tableau viser Ingen data tydeligt.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-011 – Dobbeltbooking og kapacitet

- **Beslutning:** Aktive bookings overlapper, hvis new.check_in < existing.check_out og new.check_out > existing.check_in. Cancelled ignoreres. guests_count <= room_type.capacity er obligatorisk.
- **Begrundelse:** Check-out-dagen er fri, og værelseskapacitet må ikke overskrides.
- **Konsekvens:** Regler håndhæves i service-laget og beskyttes transaktionelt ved samtidige requests.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

## Godkendt beslutningsoversigt

| Beslutning | Status | Ejer | Dato |
|---|---|---|---|
| Live-dataflow | Approved | Projektgruppen | 2026-10-26 |
| CSV/XSLT-import til v1 | Historisk godkendt; ændret uge 2 | Projektgruppen | 2026-10-26 |
| Standardår 2026 | Approved | Projektgruppen | 2026-10-26 |
| Sæsonkalender | Approved | Projektgruppen | 2026-10-26 |
| Belægningsgrad | Approved | Projektgruppen | 2026-10-26 |
| DELETE som soft-cancel | Approved | Projektgruppen | 2026-10-26 |
| Faktisk bookingpris | Approved | Projektgruppen | 2026-10-26 |
| Helene-filter | Approved | Projektgruppen | 2026-10-26 |
| Kundetilfredshed 1–5 pr. booking | Brugerbeslutning | Brugeren | 2026-10-28 |
| Manglende data | Approved | Projektgruppen | 2026-10-26 |
| Dobbeltbooking/kapacitet | Approved | Projektgruppen | 2026-10-26 |
| PostgreSQL som måldatabase | Afklaret | Projektgruppen | Tillægsopgave uge 2 |
| Selvvalgt nøgletal | Afklaret: gennemsnitlig opholdslængde (ALOS) | Brugeren | 2026-11-05 |
| Analysekontrakt og warnings | Afklaret | Projektgruppen | 2026-11-06 |
| Frontend-opdatering | Afklaret: hent ved åbning af analysefanen | Projektgruppen | 2026-11-08 |
| Tableau som forbruger/leverance | Afklaret: API-forbruger, ikke aktiv user story | Projektgruppen | 2026-11-06 |

## Kvalitetstjek — oprindelig v1-afklaring

- Er kravene entydige? Ja; beslutningerne er godkendt som arbejdsgrundlag.
- Kan de implementeres og testes? Ja, med de angivne konsekvenser og acceptance tests.
- Er de dækket af stories/tasks? Ja, se traceability.md og tasks.md.
- Denne kontrol beskriver kun den oprindelige v1-afklaring. Nye åbne punkter for
  uge 2 står i C-013–C-016 nedenfor og i den aktuelle traceability-matrix.

## C-009 ændret ved brugerbeslutning — 2026-10-28

Kundetilfredshed aktiveres: 1–5 stjerner pr. booking, bekræftet af brugeren i chatten.
Højst én bedømmelse pr. booking (idempotent PUT). Kun confirmed bookinger med
check_out <= dags dato i Europe/Copenhagen kan bedømmes. Rapportens kohorte er
checkout-dato i [from,to); gennemsnit på bedømte og svarprocent over afsluttede.
Rating følger bookingens historik; annulleret booking indgår ikke i rapporten.

## API-præciseringer — T-020

Analyseperioder bruger [from,to); `year` vælger kalenderår og kan ikke kombineres
med from/to. Standard er 2026. Land/type/sæson filtrerer hoteldata; employee_name
filtrerer barsalg (default Helene Christine). Land/type/sæson filtrerer ikke baren,
som ikke har relation til bookinger. Metadata viser dette eksplicit.
Belægningsnævner: aktive værelser i valgt type × nætter i valgt sæson/periode.
Landefilter ændrer tælleren, ikke hotelkapaciteten. Nationalitet for hele selskabet
antages lig bookinggæstens land; distinct_bookers vises separat.
Testinventar kan være syntetisk; antal og kategorier skal passe til opgaven uden at
påstå at typefordeling og værelsesnumre er hotellets faktiske inventar.

## C-004 revideret — juletid i højsæson (T-020)

PDF-opgaven angiver sommer og juletid som højsæson. Tidligere lavsæson hele
december erstattes af lavsæson til og med 19/12 og højsæson 20/12–31/12. De
præcise juledatoer er en implementeringsantagelse, ikke en oplysning fra hotellet.
Eksisterende prislinjer bevares som historiske snapshots.

## Tillægsopgave uge 2 — beslutninger

Beslutningerne nedenfor blev afklaret under arbejdet med tillægsopgaven.
Implementeringsstatus og testbevis fremgår af `converge-tillaeg-uge2.md`.

### C-012 — Databasetype

- **Status: AFKLARET.** Databasen skiftes til PostgreSQL. Gruppen har afklaret, at
  PostgreSQL tæller som en anden databasetype end MySQL i tillægsopgaven.
- **Begrundelse:** Den relationelle model kan genbruges, SQLAlchemy er allerede i
  brug, og API-kontrakten forbliver uændret.
- **Konsekvens:** MySQL-versionen bevares historisk under tagget
  `v1-mysql-tableau`. Data genindlæses fra CSV/XLSX seed/import; der planlægges
  ikke datamigrering fra MySQL.

### C-013 — Selvvalgt nøgletal

- **Status: AFKLARET 2026-11-05.** Brugeren valgte gennemsnitlig opholdslængde
  (Average Length of Stay, ALOS) som selvvalgt nøgletal. Afbestillingsprocenten
  blev fravalgt, fordi demoens kohorte kun havde én afbestilt booking.
- **Formel:** Sum af hele opholdsnætter divideret med antal bekræftede bookinger.
  En booking tilhører perioden/måneden for sin check-in; alle nætterne i det
  ophold tæller med, også hvis checkout ligger uden for perioden.
- **Tomt datasæt:** `bookings=0`, `room_nights=0` og `average_stay_nights=null`.
- **Opdeling:** samlet, check-in-måned, værelsestype og bookinggæstens land.
  Averages og ratios beregnes i backend og returneres numerisk.
- **Nuværende implementation:** RevPAR findes som eksisterende API-KPI.
- **Afgrænsning:** ALOS er valgt, og dens kohorte, formel, periodefiltre og
  tom-data-adfærd er defineret ovenfor. Tidligere kandidatovervejelser styrer
  ikke den aktuelle løsning.

### C-014 — Analysekontrakt

- **Status: AFKLARET 2026-11-06.** Eksisterende analyse-endpoints og OpenAPI-
  schemas er den godkendte kontrakt; PostgreSQL-skiftet ændrede ikke kontrakten.
  Detaljer og operationer står i `spec.md` og `openapi/openapi.yaml`.
- **Belægningsnævner:** Aktive værelser i det valgte inventar × periodens
  tilgængelige nætter; type- og sæsonfiltre ændrer nævneren. 214 er størrelsen på
  det aktuelle syntetiske referenceinventar, ikke en fast API-konstant.
- **Fejl og warnings:** Følger de eksisterende API-schemas og beskrivelser i
  OpenAPI; KPI'er beregnes i backend.

### C-015 — Frontend-opdatering

- **Status: AFKLARET 2026-11-08.** Analysefanen henter friske værdier, når
  brugeren åbner fanen. Der er ingen periodisk opdatering eller push.
- **Konsekvens:** Efter en booking skal brugeren åbne analysefanen for at hente
  værdier fra næste API-request. Tableau opdateres ved connectorens refresh.

### C-016 — Tableau som leverance

- **Forbindelse afklaret 2026-11-03:** Brugeren anvender kun REST API Connector.
  CSV-/Hyper-bro og workbook-generator er ude af aktivt scope og skal ikke porteres.
  Connectoren bruger extracts; end-to-end refresh er endnu ikke verificeret.

- **Status: AFKLARET 2026-11-06 (C-018).** Tableau er ikke længere en user story
  i projektet. Tableau-endpoints og `tableau/` bevares, men accepteres ikke som
  story-leverance.
- **Fast krav:** Hvis Tableau bruges, læser det beregninger fra REST API'et og
  ikke direkte fra databasen.

### C-017 — Seed ved databaseskift

- **Status: AFKLARET.** Eksisterende data genskabes ved reproducerbar CSV/XLSX
  seed/import i PostgreSQL; der udføres ingen datamigrering fra MySQL.
- **Verificeret:** Mapping af kildefelter, `synthetic_import`-markering,
  skrivebeskyttelse og idempotent import er implementeret; testbevis står i
  `converge-tillaeg-uge2.md`.

### C-018 — Reduceret story-scope

- **Status: AFKLARET 2026-11-06.** Gruppen beholder kun US-001 (bookinger),
  US-002 (aktuelle data), US-005 (cocktailbaren) og US-006 (kundetilfredshed).
  US-003 (belægning), US-004 (hotellets indtjening og gæster), US-007 (Tableau)
  og US-008 (nøgletal i frontend) er fjernet fra `user-stories.md`.
- **Konsekvens:** Kun dokumentationen er ændret. Koden, API-endpoints, OpenAPI
  og analysefanen er bevaret, men hotelanalyser, belægning, det selvvalgte
  nøgletal (C-013) og Tableau spores ikke længere som story-acceptkriterier.
  Story-numrene bevares.
