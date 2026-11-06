# Kommende Converge — tillægsopgave uge 2

**Status:** Skabelon/plan. Converge er ikke udført. Denne fil må først udfyldes
efter implementering og faktisk verifikation.

Den historiske vurdering fra 2026-10-28 ligger i
`converge-api-2026-10-28.md` og `converge-2026-10-28.md`; de filer omskrives ikke.
Deres MySQL-resultater gælder alene v1 og er ikke PostgreSQL-testbevis.

## Vurdering efter implementering

| Story/krav | Status (implementeret/delvist/mangler) | Testbevis eller manuel kontrol | Resterende arbejde |
|---|---|---|---|
| US-001 — bookingflow | Ikke vurderet | Afventer T-035 | Afventer implementering |
| US-002 — live data og PostgreSQL | Ikke vurderet | Afventer T-029, T-030, T-035 | Afventer implementering |
| US-005 — baranalyse | Ikke vurderet | Afventer T-035 | Afventer implementering |
| US-006 — kundetilfredshed | Ikke vurderet | Afventer T-035 | Afventer implementering |

Converge skal også kontrollere OpenAPI-kontraktlighed, testreset-spærrer,
concurrency, Compose-start/persistens, dokumentation og kendte begrænsninger.
