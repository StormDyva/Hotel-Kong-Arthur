# Kundeimport fra ITAKEA/hoteldata

## Kilde

Kilden er det offentlige repository `ITAKEA/hoteldata`. Råfilerne skal hentes
lokalt og placeres i `data/raw/`:

- `international_names_with_rooms_1000.csv`
- `international_names_with_rooms_1000.xlsx`
- `drinks_menu_with_sales.xlsx`

Råfiler er ignoreret af Git, fordi de indeholder personlignende navne og derfor
ikke skal pushes til det offentlige projektrepository.

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
  mysql -uroot -p"${MYSQL_ROOT_PASSWORD}" "${MYSQL_DATABASE}" \
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

Der oprettes ikke bookings, fordi filen mangler check-in, check-out, status og
sikkert værelsesnummer. Der opfindes heller ikke room IDs.

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
- `guests` deduplikeres på fornavn, efternavn og country code. Det er en
  dokumenteret antagelse, ikke en garanti for identitet.
- Samme import kan køres igen uden nye gæster, staging-rækker eller produkter.
- Gæste-XLSX’ens ekstra delvist tomme række afvises med årsag og gemmes som
  `row_status = rejected`.


T-023 erstatter navnebaseret deduplikering: guests.import_key er SHA-256 af
kildens filhash og source_record_id. Nøglen identificerer en importeret kilderække,
ikke en person. Gentagen import bruger samme kilde-ID; bookinger bruger NULL-nøgle
og separate gæstesnapshots. Allerede importerede legacy-rækker får ved første
genimport nye eksplicitte gæsterelationer, hvorefter genimport er stabil.
