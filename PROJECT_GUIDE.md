# Hotel Kong Arthur — aktuel projektguide

## Kravgrundlag og prioritering

Grundlag: E26 Tværfaglig Opgave Hotel Kong Arthur og Tillægsspørgsmål_swa.
MVP: trelags-backend, REST/JSON, OpenAPI/Swagger, MySQL, Docker Compose,
booking-CRUD, hotel-/baranalyser, bookingfrontend, dokumentation og Tableau.
Brugeren har prioriteret API og valgt 1–5-rating pr. afsluttet booking.
Tableau bygges manuelt senere; den samlede dashboardleverance er ikke verificeret.

Den kanoniske funktionelle specifikation er specs/spec.md. Arbejdsflow:
Constitution → Specify → Clarify → Plan → Tasks → Implement → Converge.
Alle stories har acceptkriterier. Sporbarhed: specs/traceability.md. Aktuel
Converge: specs/converge-api-2026-10-28.md; ældre rapporter er historik.

## Teknisk struktur

- api/main.py og schemas.py: HTTP, JSON, validering, statuskoder, Swagger.
- services/: bookingregler, sæsonpriser, nøgletal og bedømmelser.
- repositories/: parameteriseret SQL, persistence og låse; intet HTTP.
- MySQL: autoritativ runtime-kilde; historiske kundefiler er kun import/staging.
- Frontend: HTML/CSS/JavaScript; kalder API, aldrig MySQL direkte.
- Tableau: bruger API-beregnede beløb. Flade /analytics/revenue-rækker er klar.

Compose starter MySQL → migrations/seed → API-health → nginx/frontend.
Swagger serveres i API-containeren med lokale JS/CSS-filer. MySQL-data bevares i
projektets navngivne volume. Testprofilen har separat database og API-testcontainer.
Se README for præcise porte, miljøvariabler, opstart og tests.

## Gældende domæneregler

Datoer og rapporters to er eksklusive ved checkout/slut. Historiske natpriser
gemmes som snapshots. Sommer og 20.–31. december er højsæson; julegrænserne er en
projektantagelse. Land/type/sæson filtrerer hotellet, medarbejder filtrerer baren.
Landefilter ændrer ikke kapacitetsnævneren. Valuta er DKK.

Bookinger må ikke overlappe. Rum låses i ID-rækkefølge før bookinglåsen.
DELETE soft-canceller. Nye bookinger får separate gæstesnapshots; navn og land
identificerer ikke personer. Kontaktrettelser kan ikke overskrive andre bookinger.
Bedømte bookinger tillader kun email/telefonrettelser. Kundetilfredshed beregnes
fra indsendte ratings; der opfindes ingen scores. Tabte historiske kontaktdata eller
fejltilskrevne ratings kan kræve en autoritativ kilde/manuelt review.

Referenceinventar: 214 syntetiske værelser, otte opgavekategorier, 428 pladser.
Der er 20 cocktails og 10 kaffeprodukter i demokataloget. Typefordeling, værelsesnumre
og menu er ikke en påstand om hotellets faktiske drift. Se data-dictionary.

## Samarbejde og AI-regler

Arbejd på én afgrænset task i egen branch; kontrollér git status før ændringer.
Bevar ukendte ændringer; brug ikke git reset --hard eller git checkout --.
Ingen secrets/tokens/.env i Git. API-/datamodelændringer kræver specs og OpenAPI.
Markér intet færdigt uden testbevis. En PR skal angive task/story, ændrede filer,
tests/resultater, migrationer og kendte begrænsninger. Et andet medlem reviewer
før merge; API-/database-/Dockerændringer kræver mindst to reviewers.

Kør relevante tests og git diff --check. Ved konflikter i kontrakt/datamodel/formler
beslutter gruppen løsningen og dokumenterer den under docs/decisions/.
Ingen direkte main-commit eller merge uden gruppens aftalte review.

## Aflevering og fremlæggelse

README har arkitekturdiagram og opstart. CONTRIBUTE.md henviser til CONTRIBUTING.md.
Spec-artefakter, stories, testbevis og sidste Converge skal være i GitHub.
SWA-spørgsmålene gennemgås med konkrete kodeeksempler i docs/swa-questions.md.
Alle tre medlemmer skal kunne forklare og vurdere løsningen og dokumentere egne
bidrag. En færdig API erstatter ikke en Tableau-demo med afstemte tal, filtre og
booking → API → opdateret dashboard. Se docs/release-checklist.md før PR-accept.

Fremlæggelsen i opgaven er fredag 6. november 2026 kl. 12.30–15.45. Hver gruppe
har 10 minutters præsentation og 10 minutters spørgsmål/feedback. Gruppe 1–3:
12.30–13.30; gruppe 4–6: 13.35–14.35; gruppe 7–9: 14.40–15.40.
