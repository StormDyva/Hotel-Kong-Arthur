# Tableau — manuel dashboardopgave udestår

API'et beregner nøgletallene; Tableau skal vise dem. Det samlede dashboard,
interaktioner og booking → opdateret dashboard er IKKE færdigverificeret.
Eksisterende TWB/TWBX-filer er tidligere prototyper/snapshots, ikke acceptbevis.

## Færdige rækker fra API'et

- `/analytics/revenue/by-room-type-season?year=2026`: alle 24 type/sæson-rækker,
  også nulbeløb; roomType, season og numerisk revenue i DKK.
- `/analytics/revenue/by-country?year=2026`: country og numerisk revenue i DKK.
- `/api/analytics/dashboard`: samlet datasæt til den eksisterende eksportbro.

Backenden beregner natpriser × nætter og summerer. periodens to og checkout er
eksklusive. Tableau skal ikke gentage prisberegningen.

## Tableau-arbejdsbog og API-endpoints

Eksportbroen bruger dashboard-endpointet til de otte fælles datasæt og henter
derudover alle 13 analyse-endpoints separat. Hvert analysesvar får sin egen CSV,
Hyper-datakilde og fane i arbejdsbogen. Det omfatter belægning, omsætning,
gæstetal, bar og kundetilfredshed samt de to flade Tableau-eksporter.
Skrive-endpoints (POST/PUT/DELETE) ændrer data og bruges derfor ikke som
Tableau-datakilder.

Refresh henter også alle sider fra `GET /api/bookings` og bygger to ekstra ark:
alle bookinger og kun `data_origin=synthetic_import`. Pris er Value; Label
indeholder booking-ID, datakilde, land, værelse, datoer, selskabsstørrelse og
status. Gæstenavne og kontaktdata eksporteres ikke. De syntetiske rækker bruger
opfundne datoer/værelser og kan derfor ligge uden for standard-analyseperioden 2026.

Eksporten læser også de importerede ophold og drinksaggregater fra MySQL via
`docker compose exec`. Den laver separate kilder for opholdsrækker og
landesummeringer samt drinksdetaljer, omsætning og antal. Gæstenavne og
kontaktfelter eksporteres ikke. Docker, API'et og databasen skal køre under
refresh.

## Eksportbro (kører på værtsmaskinen)

Fra repository-roden, med API'et kørende:

```sh
uv venv backend/.venv
uv pip install --python backend/.venv/bin/python -r tableau/requirements.txt
backend/.venv/bin/python tableau/refresh.py
python3 tableau/build_workbook.py
```

Broen læser API'et, skriver CSV/Hyper under tableau/data og snapshot.json med periode
og refresh-tid. Brug --from/--to og evt. --api for andre perioder/adresser.
Kør derefter `python3 tableau/build_workbook.py`; åbn `tableau/Hotel-Kong-Arthur.twbx`
i Tableau Public. Genbyg workbook/pakke efter hver dataopdatering. Denne proces er
ikke kontinuerlig live-opdatering eller automatisk refresh af en publiceret Public-side.
Et lokalt API er ikke tilgængeligt fra Tableau Publics servere.

Gæsteeksporten bruger booking_guests: en booking med fire personer tæller fire.
Hele selskabet henføres til bookinggæstens land; andre nationaliteter registreres ikke.
distinct_bookers tæller bookingprofiler, ikke identificerede unikke personer.

Uberørt syntetisk seed, kalender 2026: hotel 12.700 DKK, seks solgte nætter,
78.110 tilgængelige nætter, belægning 0,01 %, ADR 2.116,67 DKK. Helene: 575 DKK,
cocktails 43,48 %, kaffe 56,52 %. Rigtige API-ændringer kan ændre tallene.

CSV/Hyper-gæstetal er testet mod API'et. Endelig Tableau-godkendelse kræver stadig
manuel afstemning, filtertest og demonstration af en bookingændring i dashboardet.
