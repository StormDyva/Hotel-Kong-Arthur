# Booking-UI – Hotel Kong Arthur (T-014)

Browserprototype til receptionen, bygget med HTML, CSS og vanilla JavaScript (ES-moduler, ingen build-step og ingen afhængigheder).

Funktioner:

1. Søgning med check-in, check-out og antal gæster
2. Visning af ledige værelser med værelsestype, kapacitet, pris pr. nat og samlet pris
3. Gæsteformular med navn, e-mail, telefon og land
4. Bookingbekræftelse med bookingnummer
5. Receptionistens bookingoversigt med søgning og statusfilter
6. Redigering af booking (datoer, gæster, kontaktoplysninger) med genberegnet pris
7. Annullering af booking (soft-cancel, jf. C-006)

Frontend forbinder aldrig direkte til MySQL. Al dataadgang går gennem service-laget i `js/services/booking-service.js`, som enten bruger mock-data eller kalder REST-API'et.

## Kør lokalt

ES-moduler kan ikke indlæses fra `file://`, så siden skal serveres over HTTP:

```bash
cd frontend
python3 -m http.server 5500     # eller: npm start
```

Åbn <http://localhost:5500>. Som standard kører UI'et i mock-tilstand, vist med et gult banner øverst.

Mock-data ligger kun i browserens hukommelse og nulstilles, når siden genindlæses.

## Skift mellem mock og API

`js/config.js` styrer, hvor data kommer fra:

| Indstilling | Standard | Betydning |
|---|---|---|
| `useMock` | `true` | `true` bruger mock-data, `false` kalder REST-API'et |
| `apiBaseUrl` | `http://localhost:8000` | Basis-URL for backend |
| `mockLatencyMs` | `250` | Kunstig forsinkelse i mock-tilstand, så loading-tilstande kan ses |

Uden at ændre filen kan du bruge URL-parametre:

```text
http://localhost:5500/?mock=false&api=http://localhost:8000
```

Du kan også sætte `window.HKA_CONFIG = { useMock: false }` før `main.js` indlæses.

Når frontend og API kører på forskellige porte, skal backend tillade CORS fra frontendens origin.

## API-kontrakt, som service-laget forventer

| Funktion | Kald |
|---|---|
| `searchAvailability({ check_in, check_out, guests_count })` | `GET /api/rooms/availability?check_in=…&check_out=…&guests_count=…` |
| `createBooking(payload)` | `POST /api/bookings` |
| `listBookings({ status })` | `GET /api/bookings?status=…` |
| `updateBooking(id, payload)` | `PUT /api/bookings/{id}` |
| `cancelBooking(id)` | `DELETE /api/bookings/{id}` |

Ledigt værelse:

```json
{
  "room_id": 12,
  "room_number": "204",
  "room_type": "Standard dobbeltværelse",
  "capacity": 2,
  "price_per_night": 1600,
  "total_price": 4800
}
```

Body til `POST /api/bookings` og `PUT /api/bookings/{id}`. PUT sender den fulde resource og har også `status`:

```json
{
  "room_id": 12,
  "check_in": "2026-11-20",
  "check_out": "2026-11-23",
  "guests_count": 2,
  "price_total": 4800,
  "currency": "DKK",
  "guest": {
    "name": "Mette Holm",
    "email": "mette@example.com",
    "phone": "+45 20 30 40 50",
    "country_code": "DK"
  }
}
```

Booking i svar fra API'et. Felterne `room_number`, `room_type`, `capacity` og `price_per_night` bruges til visning:

```json
{
  "id": 1001,
  "room_id": 12,
  "room_number": "204",
  "room_type": "Standard dobbeltværelse",
  "capacity": 2,
  "check_in": "2026-11-05",
  "check_out": "2026-11-08",
  "guests_count": 2,
  "price_per_night": 1600,
  "price_total": 4800,
  "currency": "DKK",
  "status": "confirmed",
  "guest": { "name": "…", "email": "…", "phone": "…", "country_code": "DK" }
}
```

Lister må returneres som et array eller som et pagineret objekt `{ "items": [...] }`.

Fejl forventes i projektets fejlformat. Feltfejl i `details` vises ved det relevante formularfelt:

```json
{
  "error": "VALIDATION_ERROR",
  "message": "check_out must be after check_in",
  "details": [{ "field": "check_out", "message": "check_out must be after check_in" }]
}
```

`DELETE` må svare med `204 No Content` eller med den annullerede booking.

## Mappestruktur

```text
frontend/
├── index.html                # Ny booking + bookingoversigt (faneblade) og dialoger
├── css/styles.css
├── js/
│   ├── main.js               # Binder UI-modulerne sammen
│   ├── config.js             # Mock/API-indstillinger
│   ├── lib/                  # Rene funktioner: datoer, validering, formatering, lande
│   ├── services/             # Service-lag: HTTP-klient, mock-API, mock-data, ApiError
│   └── ui/                   # Søgning, værelser, gæsteformular, reception, faneblade
└── tests/
    ├── *.test.js             # Unit-tests (node:test)
    └── browser-smoke.mjs     # End-to-end-test i headless Chrome
```

UI-modulerne kalder kun service-laget. Valideringen i `js/lib/validation.js` bruges både af formularerne og af mock-API'et. Backend skal altid validere igen.

## Test

Det kræver Node.js 22 eller nyere:

```bash
cd frontend
npm test          # unit-tests: validering, mock-API, service-lag og visninger
npm run smoke     # browser-test af hele flowet i headless Chrome (mock-tilstand)
```

`npm run smoke` gennemfører hele flowet: ugyldig søgning, søgning, valg af værelse, validering af gæsteformular, oprettelse, redigering, annullering, frigivet værelse, mobilbredde uden vandret scroll og en konsol uden fejl.

Testen har disse indstillinger:

- Den bruger portene 5599 og 9333. Du kan ændre dem med `SMOKE_PORT` og `SMOKE_DEBUG_PORT`.
- `CHROME_PATH` angiver stien til Chrome.
- `SCREENSHOT_DIR=./screenshots` gemmer skærmbilleder.

Kør også `git diff --check` før commit.

## Kendte begrænsninger

- **Mock-data er midlertidige.** De har 7 værelser og 3 bookinger og en fast pris pr. nat. Sæsonpriser (C-004 og C-007) er ikke modelleret i mock'en.
- **API-stierne bruger `/api`-præfiks.** Stierne følger opgaven for T-014: `/api/bookings` og `/api/rooms/availability`. `specs/` beskriver i dag `/bookings` uden præfiks. Availability-endpointet findes heller ikke i specs eller OpenAPI endnu. Kontrakten skal afstemmes med T-007 og T-008, før der skiftes til API-tilstand.
- **Gæsteoplysninger gemmes ikke i databasen endnu.** Tabellen `guests` har i dag kun `country_code` og `country_name`, ikke navn, e-mail eller telefon. Formularen sender felterne, men databasen og API'et skal udvides i en separat task, før de kan gemmes.
- **Værelset kan ikke skiftes ved redigering.** Redigering ændrer datoer, antal gæster og kontaktoplysninger. Vil gæsten have et andet værelse, annulleres bookingen, og der oprettes en ny.
- **Oversigten er ikke pagineret.** Den henter alle bookinger på én gang og bruger ikke `page` og `page_size`.
- **Der er ingen login.** Login er uden for MVP.
