# User stories

## Status

Approved as working agreement – 2026-10-26. Stories er implementerings- og testgrundlag for MVP’en.

## US-001 – Opret booking

Som receptionist ønsker jeg at oprette en booking, så hotellets kapacitet og indtjening kan opdateres.

Acceptkriterier:

- POST /api/bookings returnerer 201 og JSON-resource.
- Obligatoriske felter, ISO-datoer, DKK, pris, gæsteantal og status valideres.
- guests_count overstiger ikke værelsestypens capacity.
- Overlappende confirmed booking afvises med ensartet fejl.
- Data kan genfindes via GET /api/bookings og MySQL.

## US-002 – Se og filtrér bookinger

Som receptionist ønsker jeg at se og filtrere bookinger, så jeg kan finde reservationer.

Acceptkriterier:

- GET /api/bookings har page/page_size og dokumenterede status-, dato-, room- og guest-filtre.
- page_size afvises over 100.
- GET /api/bookings/{id} returnerer booking eller 404.
- Frontend viser liste, tomt resultat og fejl.

## US-003 – Redigér booking

Som receptionist ønsker jeg at redigere en booking, så ændringer afspejles i driftstallene.

Acceptkriterier:

- PUT accepterer komplet gyldig resource og er idempotent.
- Dato, kapacitet, pris og overlap valideres igen.
- Ændringen ses i API, MySQL og relevante analyser.

## US-004 – Annullér booking

Som receptionist ønsker jeg at annullere en booking, så værelset frigives uden at historikken går tabt.

Acceptkriterier:

- DELETE ændrer status til cancelled og er idempotent.
- Rækken bevares; cancelled tæller ikke i overlap, belægning eller indtjening.
- Samme værelse kan bookes igen efter annullering.
- Frontend viser handlingens resultat.

## US-005 – Opdatér live bookingdata

Som hotelklient ønsker jeg at skrive bookingændringer til API’et, så MySQL indeholder den aktuelle drift.

Acceptkriterier:

- POST/PUT/DELETE er dokumenteret som primær MVP-opdateringsmekanisme.
- Næste GET-request afspejler ændringen.
- CSV/XSLT bruges kun til seed/import og ændrer ikke runtime-data direkte.
- Begrænsningen ingen WebSockets/push er dokumenteret.
- Imported customer rows exposed as generated booking data are marked
  `synthetic_import` and remain read-only.

## US-006 – Se belægningsgrad

Som hoteladministrator ønsker jeg belægningsgrad for en periode, så jeg kan vurdere kapacitetsudnyttelsen.

Acceptkriterier:

- from og to er obligatoriske eller har dokumenteret default.
- Formlen, tæller, nævner og eksklusiv check-out er dokumenteret.
- Perioder klipper bookingnætter korrekt, og cancelled ignoreres.
- Nævner 0 giver 0 med warning.

## US-007 – Analysér hotelindtjening

Som hoteladministrator ønsker jeg indtjening efter værelsestype, sæson og land, så jeg kan træffe beslutninger.

Acceptkriterier:

- Års- og valgt periodes total vises.
- Faktisk price_total bruges; cancelled filtreres fra.
- Tværsæson-bookinger fordeles pr. nat efter godkendt regel.
- Mest indbringende værelsestype og land betyder størst samlet omsætning i perioden.
- Ingen data håndteres eksplicit.

## US-008 – Analysér cocktailbaren

Som hoteladministrator ønsker jeg Helene Christines barsalg pr. produkt og kategori.

Acceptkriterier:

- employee_name-filteret er Helene Christine i årsrapporten.
- Omsætning pr. produkt = quantity * unit_price.
- Cocktails og kaffe viser beløb og procent af samlet Helene-omsætning.
- Nævner 0 giver 0 med warning.

## US-009 – Brug Tableau-dashboard

Som beslutningstager ønsker jeg et interaktivt Tableau-dashboard uden SQL.

Acceptkriterier:

- Dashboard viser alle godkendte hotel- og bar-KPI’er.
- Relevante periode-, land-, værelsestype-, sæson- og medarbejderfiltre virker.
- Refresh-procedure og datakilde er dokumenteret.
- Dashboard-tal afstemmes mod API/MySQL på kendt datasæt.

## US-010 – Brug dokumenteret dataimport

Som dataansvarlig ønsker jeg at importere CSV/XSLT-eksempeldata til MySQL, så demoen kan genskabes.

Acceptkriterier:

- Import/seed er reproducerbar og dokumenterer mapping.
- Importen ændrer ikke API-kontrakten.
- Dubletter og genkørsel håndteres efter godkendt strategi.

## US-011 – Vurder kundetilfredshed

Som hoteladministrator ønsker jeg gæstebedømmelser og svarprocent, så jeg kan
vurdere tilfredshed og hvor repræsentativt datagrundlaget er.

Acceptkriterier:

- En afsluttet, ikke-annulleret booking kan få præcis én rating 1–5 via PUT.
- Gentagen PUT opdaterer samme rating; GET viser resultatet.
- Ugyldig score afvises; fremtidige/annullerede bookinger kan ikke bedømmes.
- Analyse viser gennemsnit, svarprocent, kohortestørrelse og fordeling.
- Ingen ratings giver null gennemsnit og warning, ikke et opdigtet tal.

## US-012 – Kontroller system og Converge

Som projektgruppe ønsker jeg at sammenholde implementeringen med specs, så afleveringens mangler opdages.

Acceptkriterier:

- Converge vurderer alle traceability-rækker.
- Implementeret, delvist implementeret og mangler rapporteres.
- README, CONTRIBUTING/CONTRIBUTE, arkitekturdiagram, Swagger og Docker-smoke-test er kontrolleret.

## Kvalitetstjek

- Er hver story entydig? Ja, hver story har én rolle, ét mål og en værdi.
- Kan den implementeres? Ja, når Clarify-beslutningerne er godkendt.
- Kan den testes? Ja, alle stories har konkrete, observerbare acceptkriterier.
- Er den dækket af en task? Ja, mappingen findes i traceability.md og tasks.md.
- Er der afhængigheder eller åbne beslutninger? Ja, de er markeret i Clarify og taskafhængighederne.
