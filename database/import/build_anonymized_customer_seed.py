#!/usr/bin/env python3
"""Generate an initialization seed from local XLSX files without guest names."""

from __future__ import annotations

import argparse
import hashlib
import sys
from pathlib import Path

from import_customer_data import (
    batch_sql,
    read_xlsx,
    sql_decimal,
    sql_string,
    validate_drink_row,
    validate_guest_row,
)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--customer-dir", type=Path, required=True)
    args = parser.parse_args()
    guest_path = args.customer_dir / "international_names_with_rooms_1000.xlsx"
    drinks_path = args.customer_dir / "drinks_menu_with_sales.xlsx"
    for path in (guest_path, drinks_path):
        if not path.is_file():
            parser.error(f"missing source file: {path}")

    guest_source = read_xlsx(guest_path)
    drink_source = read_xlsx(drinks_path)
    guests = []
    drinks = []
    invalid_guest_count = 0
    invalid_drink_count = 0
    for row_number, row in enumerate(guest_source, start=2):
        value, _reason = validate_guest_row(row)
        if value is None:
            invalid_guest_count += 1
        else:
            guests.append((f"Sheet1:{row_number}", value))
    for row_number, row in enumerate(drink_source, start=2):
        value, _reason = validate_drink_row(row)
        if value is None:
            invalid_drink_count += 1
        else:
            drinks.append((f"Sheet1:{row_number}", value))
    if invalid_guest_count or invalid_drink_count:
        parser.error(
            "seed generation requires every row to validate; "
            f"invalid guest rows={invalid_guest_count}, drink rows={invalid_drink_count}"
        )

    sql = [
        "SET NAMES utf8mb4;",
        "START TRANSACTION;",
        "-- Generated from local XLSX source files; guest names are deliberately anonymized.",
        batch_sql(guest_path, len(guest_source), len(guests), 0),
    ]

    guest_hash = hashlib.sha256(guest_path.read_bytes()).hexdigest()
    for index, (source_record_id, row) in enumerate(guests, start=1):
        first_name = "Guest"
        family_name = f"Imported Record {index:04d}"
        import_key = hashlib.sha256(
            f"{guest_hash}:{source_record_id}".encode()
        ).hexdigest()
        sql.extend(
            [
                "INSERT INTO guests (first_name, last_name, country_code, country_name, import_key)",
                f"VALUES ({sql_string(first_name)}, {sql_string(family_name)}, {sql_string(row['country_code'])}, {sql_string(row['country_name'])}, {sql_string(import_key)})",
                "ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);",
                "SET @guest_id = LAST_INSERT_ID();",
                "INSERT INTO customer_stay_records",
                "    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)",
                f"VALUES (@import_batch_id, {sql_string(source_record_id)}, @guest_id, {sql_string(first_name)}, {sql_string(family_name)}, {sql_string(row['country_name'])}, {sql_string(row['country_code'])}, {sql_string(row['room_type'])}, {row['days_rented']}, {sql_string(row['season'])}, {sql_decimal(row['price_total'])}, 'accepted')",
                "ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id);",
            ]
        )

    sql.append(batch_sql(drinks_path, len(drink_source), len(drinks), 0))
    for source_record_id, row in drinks:
        sql.extend(
            [
                "INSERT INTO bar_products (name, category, price, active)",
                f"VALUES ({sql_string(row['drink_name'])}, {sql_string(row['category'])}, {sql_decimal(row['unit_price'])}, TRUE)",
                "ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;",
                "SET @product_id = LAST_INSERT_ID();",
                "INSERT INTO customer_bar_sales_aggregates",
                "    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)",
                f"VALUES (@import_batch_id, {sql_string(source_record_id)}, @product_id, {sql_string(row['drink_name'])}, {sql_string(row['category'])}, {sql_decimal(row['unit_price'])}, {row['units_sold']}, 'accepted')",
                "ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), drink_name = VALUES(drink_name), category = VALUES(category), unit_price = VALUES(unit_price), units_sold = VALUES(units_sold), row_status = VALUES(row_status), rejection_reason = NULL;",
            ]
        )

    sql.append("COMMIT;")
    print("\n".join(sql))
    print(
        f"Generated anonymized seed for {len(guests)} guest rows and {len(drinks)} drink rows.",
        file=sys.stderr,
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
