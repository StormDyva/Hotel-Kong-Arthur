# Kundeimport fra ITAKEA/hoteldata

## Kilde

Kilden er det offentlige repository `ITAKEA/hoteldata`. Råfilerne skal hentes
lokalt og placeres i `data/raw/`:

- `international_names_with_rooms_1000.csv`
- `international_names_with_rooms_1000.xlsx`
- `drinks_menu_with_sales.xlsx`

Råfiler er ignoreret af Git, fordi de indeholder personlignende navne og derfor
ikke skal pushes til det offentlige projektrepository.

## Automatisk seed ved databaseoprettelse

`database/seed/004_anonymized_customer_source.sql` indlæses automatisk af
`db-init`, når en database initialiseres. Seedet indeholder de 1.000 opholdsrækker
og 30 drinksrækker, men gæstenavne er erstattet med generiske labels. De øvrige
felter og drinksdata er bevaret. Rå XLSX-filerne behøver derfor ikke at ligge hos
andre brugere. Eksisterende rækker med samme kilde-ID bevares ved genkørsel.

Det efterfølgende `005_synthetic_customer_bookings.sql` opretter 1.000
skrivebeskyttede API-bookinger fra opholdsrækkerne. Check-in, checkout, værelses-ID
og én gæst pr. ophold er syntetiske antagelser; kildebeløb, opholdslængde,
værelseskategori, land og sæson bevares. API-svar markerer disse rækker med
`data_origin=synthetic_import`, anonymiserer navne og udelader kontaktdata.
Syntetiske bookinger vises også i bookingbaserede analyser for deres genererede år.
Drinkaggregaterne ligger fortsat i `customer_bar_sales_aggregates`; de opretter
ikke daterede `bar_sales`, fordi medarbejder og salgstidspunkt mangler.

`db-init` anvender hvert seed én gang pr. databasevolume via `schema_migrations`.
Når et seed tilføjes i en eksisterende checkout, køres `db-init` igen ved næste
`docker compose up`.

## Importkommando

Generér idempotent SQL med Python-standardbiblioteket:

```bash
python3 database/import/import_customer_data.py \
  --customer-dir data/raw \
  > /tmp/hotel-kong-arthur-customer-import.sql
```

Kør den genererede SQL mod den lokale MySQL-database, eksempelvis med Docker:

```bash
docker compose exec -T db \
  sh -c 'exec mysql --default-character-set=utf8mb4 -uroot -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"' \
  < /tmp/hotel-kong-arthur-customer-import.sql
```

Importscriptet skriver en profil og afviste rækker til stderr. SQL går til
stdout, så rapporten og importen kan kontrolleres separat.

## Mapping

`international_names_with_rooms_1000.xlsx` er den kanoniske gæstekilde, fordi
CSV’en indeholder en Unicode-erstatningskarakter i navnefeltet. Gæste-XLSX’en
mapper sådan:

| Kilde | Destination |
|---|---|
| First Name, Family Name, Country | `guests` |
| hele kilderækken | `customer_stay_records` |
| Room Type | `customer_stay_records.source_room_type` |
| Days Rented | `customer_stay_records.days_rented` |
| Season | `customer_stay_records.season_code` |
| Price | `customer_stay_records.price_total` |

Booking-seedet genererer check-in, checkout, værelses-ID, status `confirmed` og
`guests_count=1`. Det er syntetiske analysefelter, ikke historisk dokumentation.
`data_origin` gør oprindelsen synlig, og API'et tillader ikke redigering eller
annullering af dem.

`drinks_menu_with_sales.xlsx` mapper sådan:

| Kilde | Destination |
|---|---|
| Drink Name, Category, Price (DKK) | `bar_products` |
| Units Sold og hele kilderækken | `customer_bar_sales_aggregates` |

`bar_sales` ændres ikke, fordi kilden mangler `sold_at`, `employee_name` og
vagt. Det betyder, at produktomsætning kan beregnes ud fra aggregate-tabellen,
men medarbejder- og vagtfiltre kræver en senere dateret salgskilde.

## Idempotens og afvisninger

- `import_batches` identificerer en fil med SHA-256.
- `customer_stay_records` og `customer_bar_sales_aggregates` har unik nøgle på
  importbatch og kilde-række.
- `guests.import_key` identificerer en kilderække med filhash og source_record_id.
  Navn og land bruges ikke som personidentitet.
- Samme import kan køres igen uden nye gæster, staging-rækker eller produkter.
- Den seedede gæste-XLSX indeholder 1.000 gyldige rækker; seedet accepterer alle
  1.000 og gemmer ingen afviste rækker.


T-023 erstatter navnebaseret deduplikering: guests.import_key er SHA-256 af
kildens filhash og source_record_id. Nøglen identificerer en importeret kilderække,
ikke en person. Gentagen import bruger samme kilde-ID; bookinger bruger NULL-nøgle
og separate gæstesnapshots. Allerede importerede legacy-rækker får ved første
genimport nye eksplicitte gæsterelationer, hvorefter genimport er stabil.
