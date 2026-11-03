# Tableau REST API Connector: endpoints and JSONPath

Verified against the API on 2026-11-03. Use this guide for Tableau Desktop with
[Tableau's REST API Connector](https://exchange.tableau.com/products/1111).
All prices and KPI figures are calculated by the backend.

## 1. Start and connect

Run from the repository folder:

```sh
docker compose up --build -d --wait
```

Open `http://localhost:8000/docs` on the **same computer as Tableau**. If this
fails in the browser, fix the API connection before configuring Tableau.
`localhost` always means the computer running Tableau. Each student running their
own Docker project has a separate database. The default Docker ports accept
connections only from that computer; changing localhost to another computer's IP
alone does not make the API remotely accessible.

In Tableau, create a REST API connection/table with:

- HTTP method: GET.
- Response format: JSON.
- URL: the complete URL from the table below (including `http://`).
- JSONPath to records: copy the exact value from the matching row.
- Authentication: no credentials are required by our local API. Use the
  connector's anonymous/no-auth option if available; do not enter database login details.
- Give tables meaningful names such as RevenueCountry or MonthlyRevPAR.

Check the preview before building charts. Array selectors return one row per
array item. Object selectors select one summary record; confirm its scalar fields
appear as columns in your installed driver. Do not use `$*`: it is invalid.

## 2. Recommended starting tables

These two endpoints already return separate dimensions and numeric revenue.
They are the simplest sources for the required revenue charts.

| Table | Complete URL | JSONPath to records | Columns |
|---|---|---|---|
| RevenueCountry | `http://localhost:8000/analytics/revenue/by-country?year=2026` | `$[*]` | `country`, `revenue` |
| RevenueRoomSeason | `http://localhost:8000/analytics/revenue/by-room-type-season?year=2026` | `$[*]` | `roomType`, `season`, `revenue` |

RevenueRoomSeason always has **24 rows** (eight types × three seasons), including
zero revenue. RevenueCountry has one row per country with matching confirmed stays;
it does not return one row per booking or all countries in the world.

Example country chart: Country → Columns; SUM(Revenue) → Rows.
Example season chart: RoomType → Columns; SUM(Revenue) → Rows; Season → Color.

## 3. Detailed hotel analyses

These endpoints wrap their results in a `data` property.

| Table | Complete URL | JSONPath | Useful fields |
|---|---|---|---|
| HotelKPIs | `http://localhost:8000/api/analytics/occupancy?year=2026` | `$.data` | `occupancy_percent`, `room_nights`, `available_room_nights`, `adr`, `revpar` |
| RevenueTotal | `http://localhost:8000/api/analytics/revenue?year=2026` | `$.data` | `revenue` (also returns the other summary fields) |
| RevenueRoom | `http://localhost:8000/api/analytics/revenue-by-room?year=2026` | `$.data[*]` | `label` = room number, `revenue` |
| RevenueRoomType | `http://localhost:8000/api/analytics/revenue-by-room-type?year=2026` | `$.data[*]` | `label` = room type, `revenue` |
| RevenueCountryDetailed | `http://localhost:8000/api/analytics/revenue-by-country?year=2026` | `$.data[*]` | `label` = country code, `revenue` |
| RevenueSeason | `http://localhost:8000/api/analytics/revenue-by-season?year=2026` | `$.data[*]` | `label` = `low`/`mid`/`high`, `revenue` |
| RevenueRoomSeasonDetailed | `http://localhost:8000/api/analytics/revenue-by-room-type-season?year=2026` | `$.data[*]` | `label` = combined type/season, `revenue` |
| GuestsCountry | `http://localhost:8000/api/analytics/guests-by-country?year=2026` | `$.data[*]` | `label` = country code, `booking_guests`, `guest_nights`, `distinct_bookers` |
| RevPARTotal | `http://localhost:8000/api/analytics/revpar?year=2026` | `$.data` | `revpar`, `revenue`, `available_room_nights` |
| MonthlyRevPAR | `http://localhost:8000/api/analytics/revpar?year=2026` | `$.data.monthly[*]` | `month`, `revpar`, `revenue`, `available_room_nights` |

Grouped rows also contain `room_nights`, `guest_nights`, `bookings`,
`distinct_bookers` and `booking_guests`. Use `booking_guests` for the number of
people; `bookings` counts reservations. Everyone in a party is attributed to the
booking guest's country. `distinct_bookers` counts guest snapshots, not proven
unique people across repeat visits.

The flat country endpoint uses Danish names such as Sverige, whereas the detailed
endpoint uses codes such as SE. These are different values and cannot be directly
related without an explicit mapping.

## 4. Bar and satisfaction

The same URL can supply multiple tables by choosing different JSONPaths.

| Table | Complete URL | JSONPath | Useful fields |
|---|---|---|---|
| BarTotal | `http://localhost:8000/api/analytics/bar-sales?year=2026` | `$.data` | `total_revenue`, `employee_name` |
| DrinkRevenue | `http://localhost:8000/api/analytics/bar-sales?year=2026` | `$.data.products[*]` | `product`, `category`, `quantity`, `revenue` |
| DrinkCategoryShares | `http://localhost:8000/api/analytics/bar-sales?year=2026` | `$.data.categories[*]` | `category`, `revenue`, `percent` |
| SatisfactionKPIs | `http://localhost:8000/api/analytics/customer-satisfaction?year=2026` | `$.data` | `average_rating`, `response_percent`, `rated_bookings`, `eligible_bookings` |
| RatingDistribution | `http://localhost:8000/api/analytics/customer-satisfaction?year=2026` | `$.data.distribution[*]` | `rating`, `count` |

Bar analyses default to employee **Helene Christine**. The source drinks aggregate
is not employee/date-level sales, so it is not silently included in these totals.
No ratings are invented: a null `average_rating` means no qualifying ratings, not
zero satisfaction. Ratings use completed confirmed bookings with checkout in the
selected period.

## 5. Top performers

| Table | Complete URL | JSONPath | Meaning |
|---|---|---|---|
| TopRoom | `http://localhost:8000/api/analytics/top-performers?year=2026` | `$.data.top_room` | One object: most profitable room |
| TopRoomType | `http://localhost:8000/api/analytics/top-performers?year=2026` | `$.data.top_room_type` | One object: most profitable room type |
| TopCountry | `http://localhost:8000/api/analytics/top-performers?year=2026` | `$.data.top_country` | One object: most profitable country (code) |

Objects have `label`, `revenue` and the grouped-count fields. They may be null for
an empty period. Treat null as no result, not a zero-revenue winner.

## 6. One dashboard response, multiple tables

If using the combined response, use this URL for every table in this section:

```text
http://localhost:8000/api/analytics/dashboard?year=2026
```

This endpoint has **no `data` wrapper**. Do not use `$.data[*]` here.

| Dataset | JSONPath |
|---|---|
| Overall hotel/bar summary | `$.summary` |
| Revenue by physical room | `$.by_room[*]` |
| Revenue by room type | `$.by_room_type[*]` |
| Revenue/guest counts by country (country codes) | `$.by_country[*]` |
| Revenue by season | `$.by_season[*]` |
| Revenue by combined type/season label | `$.by_room_type_season[*]` |
| Daily revenue/counts (`label` is the date) | `$.daily[*]` |
| Drinks | `$.bar_products[*]` |
| Cocktail/coffee shares | `$.bar_categories[*]` |
| Satisfaction summary | `$.satisfaction` |
| Rating distribution | `$.satisfaction.distribution[*]` |
| Top room | `$.top_room` |
| Top room type | `$.top_room_type` |
| Top country | `$.top_country` |

Use the dedicated RevPAR endpoint for monthly RevPAR: `monthly` is not part of the
served dashboard schema. Choose either dedicated tables or these dashboard paths
for each chart; importing both copies does not create additional revenue.

## 7. Inventory and booking details (optional)

| Dataset | Complete URL | JSONPath |
|---|---|---|
| Rooms | `http://localhost:8000/api/rooms` | `$[*]` |
| Room types | `http://localhost:8000/api/room-types` | `$[*]` |
| Bar product catalogue (not sales) | `http://localhost:8000/api/bar-products` | `$[*]` |
| Available rooms for a specific stay | `http://localhost:8000/api/rooms/availability?check_in=2026-11-20&check_out=2026-11-23&guests_count=1` | `$[*]` |
| Bookings, first page only | `http://localhost:8000/api/bookings?page=1&page_size=100` | `$.items[*]` |
| One booking (replace 1001 with an existing ID) | `http://localhost:8000/api/bookings/1001` | `$` |
| One rating, if submitted (replace 1001) | `http://localhost:8000/api/bookings/1001/review` | `$` |

Bookings contain nested `guest` data. Check the driver's nested-column handling
before using guest attributes in a chart. The simple revenue tables avoid this.
A missing booking/review returns HTTP 404, not an empty array.

**Booking pagination:** page_size is capped at 100. `$.items[*]` selects only the
current page; it does not fetch other pages. Page 2 uses `page=2`, etc. At the
verified local count of 1,104 bookings there are 12 pages. Use the response's
`total` to determine the actual count; cancelled bookings are included unless
filtered. The connector advertises offset/limit pagination, while our endpoint
uses page/page_size: automatic full import has not been verified. Do not present
100 imported rows as the entire database. Use analytics endpoints for dashboard
totals; these process all matching bookings on the server without pagination.

Diagnostic GET `http://localhost:8000/health` has JSONPath `$`; it is not a chart
source. POST/PUT/DELETE operations change data and must not be added as Tableau
read connections.

## 8. Periods, numbers and relationships

- Examples use 2026. To select a range, replace `?year=2026` with
  `?from=2026-01-01&to=2027-01-01`. Do not combine year and from/to. The end date
  is exclusive. Cancelled bookings are excluded from revenue.
- Detailed `/api/analytics/...` endpoints also accept filters documented in
  Swagger, such as `&country_code=SE`, `&room_type_id=5`, `&season=high` or
  `&employee_name=Helene%20Christine`. The two flat `/analytics/revenue/...`
  endpoints support only year/from/to. Hotel filters do not filter bar sales.
- Set decimal-string measures in `/api/...` responses to **Number (decimal)**.
  The two flat revenue endpoints already return numeric revenue. Money is DKK.
- Occupancy and response/bar shares are returned on a 0–100 scale. Display the
  returned value with a percent suffix; Tableau's percentage formatting normally
  expects 0–1 and would turn 7.28 into 728% without conversion.
- Display the backend's overall occupancy, ADR, RevPAR and satisfaction values
  directly. Do not sum ratios or average monthly RevPAR into annual RevPAR.
- Add connections as needed, not every endpoint to one joined table. Prefer
  separate sources for independent charts. Create relationships only with shared,
  compatible keys, periods and levels of detail. Country revenue and room-type
  revenue have no shared dimension. A relationship cannot recover a missing
  country × type × season breakdown.
- Dashboard filters do not automatically recalculate server KPI denominators or
  change API URL parameters. For a filtered overall KPI, request that filter from
  the API. Detail needed for other interactive breakdowns must exist in the source.

## 9. Refresh and the three-country issue

The connector is **extract-only**. After changes: **Data → Refresh All Extracts**.
There is no continuous live push or automatic five-minute refresh in this setup.

A new Docker volume automatically contains 1,004 bookings, but the 1,000 imported
stays initially have generated dates from 2027 onward. The 2026 example revenue
therefore covers Denmark, United Kingdom and Germany only. That is expected for
that seed, not proof of a broken JSONPath or missing source records.

To load all CSV stays into generated 2026 dates and add 100 extra mock bookings,
follow [the CSV loader instructions](customer-data-import.md#exact-csv--extra-school-project-data-t-028),
then refresh the extract. Alternatively query another year or a supported date range
(maximum 3,660 days); one range cannot include every future seed year.
On the verified local CSV-loaded database, 2026 country revenue has 21 rows.
Do not expect the same count on a separate student's unmodified seed database.

If the browser has 21 rows but Tableau has three, check the selected connection,
extract, worksheet/data-source filters and relationships. Create a blank worksheet
from the country table alone to isolate the issue. If the browser also has three,
check the local dataset and requested period first.

## Verification limits

40 URL/JSONPath selections were checked with a JSONPath evaluator against served
API responses, covering every domain GET endpoint. The unrated booking review
returned the expected 404. Empty or
null results are valid where documented. The rating-detail 404 case was checked
against the route/schema. No new ratings or bookings were created for this guide.
These checks are not a full driver/UI test: confirm object/nested-field import,
relationships and extracts in your installed Tableau connector. End-to-end manual
dashboard verification remains separate from API acceptance.
