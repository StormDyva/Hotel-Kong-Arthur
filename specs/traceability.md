# Traceability matrix

## Status

Approved as working agreement – 2026-10-26. Status viser specifikationsdækning, ikke implementeringsstatus. Implementeringsstatus fastlægges først i T-018 Converge.

| PDF-krav | Spec | User story | Task | Test/verifikation | Status |
|---|---|---|---|---|---|
| 3-lagsarkitektur | constitution, plan | US-012 | T-006 | lag-review, pytest | Dækket |
| REST/JSON API | specify, plan | US-001–US-005 | T-007–T-009 | OpenAPI/API-tests | Dækket |
| OpenAPI-kontrakt og Swagger UI | constitution, specify | US-012 | T-007 | validator, Swagger smoke | Dækket |
| MySQL | constitution, specify, plan | US-005 | T-003–T-006 | migration/integration | Dækket |
| Docker Compose | constitution, plan | US-012 | T-005-Docker | compose config/smoke | Dækket |
| Live/opdaterbare data | specify, clarify | US-005 | T-009 | POST/PUT/DELETE → GET | Dækket |
| CSV/XSLT seed/import | specify, clarify | US-010 | T-004 | import smoke/re-run | Dækket |
| ITAKEA kundedata-import | specify, clarify | US-005, US-008, US-010 | T-005 | mapping/import/idempotency tests | Dækket |
| Booking CRUD frontend | specify | US-001–US-004 | T-014 | browser smoke | Dækket |
| Belægningsgrad | clarify, plan | US-006 | T-010–T-011 | formel/golden tests | Dækket |
| Hotelindtjening | specify, plan | US-007 | T-011 | golden dataset | Dækket |
| Indtjening pr. room type/sæson/land | specify, clarify | US-007 | T-010–T-011 | filter/period tests | Dækket |
| Mest indbringende room type/land | specify | US-007 | T-011 | ranking test | Dækket |
| Cocktailbar-analyse | specify | US-008 | T-012 | bar golden dataset | Dækket |
| Helene Christine-filter | specify, clarify | US-008 | T-012 | employee filter test | Dækket |
| Omsætning pr. produkt | specify, plan | US-008 | T-012 | quantity × price test | Dækket |
| Cocktail/kaffe-procent | specify, clarify | US-008 | T-012 | percentage/zero test | Dækket |
| Tableau-dashboard | specify, plan | US-009 | T-015 | KPI/refresh review | Dækket |
| Live Tableau-refresh | clarify, plan | US-009 | T-015 | refresh verification | Dækket |
| README.md | constitution, tasks | US-012 | T-016 | clean-checkout walkthrough | Dækket |
| CONTRIBUTING.md / PDF-navn CONTRIBUTE.md | specify, tasks | US-012 | T-016 | file-name review | Dækket |
| Arkitekturdiagram | constitution, tasks | US-012 | T-016 | README review | Dækket |
| User stories med acceptkriterier | constitution, user-stories | alle | T-001/T-002 | story review | Dækket |
| Afsluttende Converge-vurdering | constitution, tasks | US-012 | T-018 | Converge report | Dækket |
| Kundetilfredshed | constitution, clarify, specify | US-011 | T-013 | scope decision or activation tests | Delvist dækket |

## Kendte afklaringspunkter

- PDF’en bruger filnavnet CONTRIBUTE.md, mens repositoryets eksisterende projektguide bruger CONTRIBUTING.md. Projektet bruger den eksisterende CONTRIBUTING.md som bidragsguide; README skal nævne denne navneafvigelse.
- Kundetilfredshed er et PDF-nævnt KPI-område uden specifikation eller datagrundlag. Det er ikke implementeringsklart og er derfor ikke et aktivt MVP-krav endnu.
- Standardår, sæsonkalender, DELETE-semantik og Helene-filter er godkendt i Clarify som arbejdsgrundlag.

## Kvalitetstjek

- Er hvert PDF-krav mappet? Ja, med to markerede delvise krav.
- Kan matrixen testes? Ja, gennem task-verifikationerne.
- Er implementeringsstatus blandet sammen med spec-status? Nej; implementation vurderes først i Converge.
- Er der mangler? Kun de eksplicit markerede PDF-navne- og kundetilfredshedspunkter.

## Integration evidence — 2026-10-28

The canonical requirement document is [spec.md](spec.md). Current implementation,
test evidence and remaining requirements are recorded in
[converge-2026-10-28.md](converge-2026-10-28.md). This dated audit supersedes older
completion assumptions, including direct MySQL-to-Tableau access and API paths
without the `/api` prefix. Remaining work is tracked as T-019, T-020 and T-021.

## T-020 — API-fokus, 2026-10-28

| Krav/story | Implementering | Testbevis |
|---|---|---|
| US-001–005 booking CRUD, filtre og live | services/bookings, repositories, api/main | test_api.py og test_spec_completion.py |
| US-006 belægning/periode | services/analytics | test_analytics_filters_and_denominators |
| US-007 indtjening, sæson, land, top og ADR | særskilte analytics endpoints | test_revenue_rankings_and_country_guests |
| US-008 barsalg og Helene | services/feedback, analytics | test_bars_total_category_shares_and_live_input, test_bar_calendar_boundaries_use_copenhagen |
| US-011 kundetilfredshed | booking_reviews, review endpoints | test_guest_feedback_and_response_rate |
| US-012 OpenAPI/Swagger/Docker | schemas, lokal Swagger, Compose | test_openapi_contract, swagger-smoke.mjs |
| 214 værelser, otte kategorier, 20/10 produkter | syntetisk reference-seed | test_reference_inventory |
| US-009 Tableau | bygges senere manuelt efter brugerens prioritering | Uden for T-020 |

## T-022 — flade indtjeningsrækker

US-007 → services/revenue_rows.py → de to /analytics/revenue endpoints.
Testbevis: test_revenue_rows.py kontrollerer 24 unikke kombinationer (også ved 0 og
inaktiv historisk type), numeriske beløb, sæson-/periodeklip, dansk landelabel,
annulleringer og ugyldige perioder. Ingen prisberegning flyttes til Tableau.
