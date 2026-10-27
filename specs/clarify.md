# Clarify

## Status

Approved as working agreement – 2026-10-26. Beslutningerne følger den anbefalede MVP-retning og anvendes som gruppens implementeringsgrundlag.

### C-001 – Live data og opdateringsmekanisme

- **Beslutning:** Live betyder aktuelle MySQL-data læst ved hvert API-request. POST, PUT og DELETE på booking-API’et er primær MVP-mekanisme.
- **Begrundelse:** PDF’en kræver løbende opdaterbare og live data, men ikke event streaming.
- **Konsekvens:** Næste API-request ser ændringen. Frontend genindlæser efter mutation. Tableau opdateres ved manuel eller planlagt refresh. Ingen WebSockets eller push.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-002 – CSV/XSLT

- **Beslutning:** CSV/XSLT fra ITAKEA/hoteldata bruges til reproducerbar seed/import og historisk demo-data. Importen skriver til MySQL og er ikke runtime-kilde.
- **Begrundelse:** PDF’en beskriver filerne som statiske og historiske.
- **Konsekvens:** Nye live-bookinger kommer via API’et. Importjob skal være idempotent eller have dokumenteret reset-strategi.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-003 – Standardår og periode

- **Beslutning:** Året er kalenderåret 1. januar–31. december. Alle analyser kan angive from og to. Standardåret er 2026, fordi det er projektets aktuelle kalenderår.
- **Begrundelse:** Kalenderåret er entydigt.
- **Konsekvens:** Datoer er ISO 8601-kalenderdatoer i Europe/Copenhagen; timestamps lagres i UTC.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

### C-004 – Sæsondefinition

- **Beslutning:** Lavsæson: 1/1–31/3 og 1/11–31/12. Mellemsæson: 1/4–31/5 og 1/9–31/10. Højsæson: 1/6–31/8.
- **Begrundelse:** Reproducerbar tre-sæson-model, der passer til sæsonpriser.
- **Konsekvens:** Sæson bestemmes pr. overnatningsnat. Helligdage og juletid håndteres ikke særskilt i MVP.
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

- **Beslutning:** Kundetilfredshed afgrænses fra MVP, fordi PDF’en ikke angiver data, skala, formel, endpoint eller Tableau-visning.
- **Begrundelse:** Et tal uden autoritativ datakilde ville være ikke-verificerbart. Der opfindes ikke et mål.
- **Konsekvens:** Ingen customer-satisfaction-model i MVP. Hvis gruppen/underviser leverer definition og data, tilføjes model, import, API, analyse, Tableau-view, story, task og tests.
- **Ejer:** Projektgruppen. **Dato:** 2026-10-26.

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
| CSV/XSLT-import | Approved | Projektgruppen | 2026-10-26 |
| Standardår 2026 | Approved | Projektgruppen | 2026-10-26 |
| Sæsonkalender | Approved | Projektgruppen | 2026-10-26 |
| Belægningsgrad | Approved | Projektgruppen | 2026-10-26 |
| DELETE som soft-cancel | Approved | Projektgruppen | 2026-10-26 |
| Faktisk bookingpris | Approved | Projektgruppen | 2026-10-26 |
| Helene-filter | Approved | Projektgruppen | 2026-10-26 |
| Kundetilfredshed uden for MVP | Approved | Projektgruppen | 2026-10-26 |
| Manglende data | Approved | Projektgruppen | 2026-10-26 |
| Dobbeltbooking/kapacitet | Approved | Projektgruppen | 2026-10-26 |

## Kvalitetstjek

- Er kravene entydige? Ja; beslutningerne er godkendt som arbejdsgrundlag.
- Kan de implementeres og testes? Ja, med de angivne konsekvenser og acceptance tests.
- Er de dækket af stories/tasks? Ja, se traceability.md og tasks.md.
- Åbne afhængigheder: ingen kravbeslutninger. Eventuelle ændringer skal opdatere denne fil og traceability-matrixen.
