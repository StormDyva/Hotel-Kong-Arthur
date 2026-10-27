#!/usr/bin/env python3
"""Generate idempotent MySQL SQL from the ITAKEA/hoteldata files.

The script deliberately writes SQL to stdout instead of opening a database
connection. This keeps the importer dependency-free and lets local users run
it through either a host mysql client or a MySQL Docker container.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import re
import sys
import zipfile
from decimal import Decimal, InvalidOperation
from pathlib import Path
from xml.etree import ElementTree as ET


SOURCE_SYSTEM = "ITAKEA/hoteldata"
COUNTRY_CODES = {
    "Australia": "AU",
    "Brazil": "BR",
    "Canada": "CA",
    "China": "CN",
    "Egypt": "EG",
    "France": "FR",
    "Germany": "DE",
    "India": "IN",
    "Italy": "IT",
    "Japan": "JP",
    "Mexico": "MX",
    "Nigeria": "NG",
    "Pakistan": "PK",
    "Russia": "RU",
    "South Korea": "KR",
    "Spain": "ES",
    "Sweden": "SE",
    "United Kingdom": "GB",
    "United States": "US",
    "Vietnam": "VN",
}
SEASONS = {"low", "mid", "high"}
CATEGORIES = {"cocktail": "cocktail", "coffee": "coffee"}
XML_NS = {"m": "http://schemas.openxmlformats.org/spreadsheetml/2006/main"}


def sql_string(value: object | None) -> str:
    if value is None:
        return "NULL"
    text = str(value)
    text = text.replace("\\", "\\\\").replace("'", "\\'")
    text = text.replace("\r", "\\r").replace("\n", "\\n")
    return f"'{text}'"


def sql_decimal(value: Decimal | None) -> str:
    return "NULL" if value is None else format(value, "f")


def file_sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as source:
        for chunk in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def column_index(reference: str) -> int:
    letters = "".join(character for character in reference if character.isalpha())
    index = 0
    for character in letters.upper():
        index = index * 26 + ord(character) - ord("A") + 1
    return index - 1


def read_xlsx(path: Path) -> list[dict[str, str | None]]:
    """Read the first worksheet using only the Python standard library."""
    with zipfile.ZipFile(path) as workbook:
        shared_strings: list[str] = []
        if "xl/sharedStrings.xml" in workbook.namelist():
            shared_root = ET.fromstring(workbook.read("xl/sharedStrings.xml"))
            shared_strings = [
                "".join(text.text or "" for text in item.iterfind(".//m:t", XML_NS))
                for item in shared_root.findall("m:si", XML_NS)
            ]

        sheet_root = ET.fromstring(workbook.read("xl/worksheets/sheet1.xml"))
        rows: list[list[str | None]] = []
        for row in sheet_root.findall(".//m:sheetData/m:row", XML_NS):
            values: list[str | None] = []
            for cell in row.findall("m:c", XML_NS):
                index = column_index(cell.attrib.get("r", ""))
                while len(values) <= index:
                    values.append(None)
                value_node = cell.find("m:v", XML_NS)
                value = None if value_node is None else value_node.text
                if cell.attrib.get("t") == "s" and value is not None:
                    value = shared_strings[int(value)]
                values[index] = value
            rows.append(values)

    if not rows:
        return []
    headers = [str(value).strip() if value is not None else "" for value in rows[0]]
    return [
        {header: row[index] if index < len(row) else None for index, header in enumerate(headers)}
        for row in rows[1:]
    ]


def read_csv(path: Path) -> list[dict[str, str | None]]:
    with path.open("r", encoding="utf-8-sig", newline="") as source:
        return list(csv.DictReader(source))


def clean(value: object | None) -> str:
    return "" if value is None else str(value).strip()


def parse_decimal(value: str) -> Decimal:
    return Decimal(value.replace(",", "."))


def validate_guest_row(row: dict[str, str | None]) -> tuple[dict[str, object] | None, str | None]:
    first_name = clean(row.get("First Name"))
    family_name = clean(row.get("Family Name"))
    country_name = clean(row.get("Country"))
    room_type = clean(row.get("Room Type"))
    days_value = clean(row.get("Days Rented"))
    season = clean(row.get("Season")).lower()
    price_value = clean(row.get("Price"))

    if not all((first_name, family_name, country_name, room_type, days_value, season, price_value)):
        return None, "missing required source value"
    if country_name not in COUNTRY_CODES:
        return None, f"unsupported country: {country_name}"
    if season not in SEASONS:
        return None, f"unsupported season: {season}"
    try:
        days_rented = int(days_value)
        price_total = parse_decimal(price_value)
    except (ValueError, InvalidOperation):
        return None, "days rented or price is not numeric"
    if days_rented <= 0:
        return None, "days rented must be positive"
    if price_total < 0:
        return None, "price must not be negative"
    return {
        "first_name": first_name,
        "family_name": family_name,
        "country_name": country_name,
        "country_code": COUNTRY_CODES[country_name],
        "room_type": room_type,
        "days_rented": days_rented,
        "season": season,
        "price_total": price_total,
    }, None


def validate_drink_row(row: dict[str, str | None]) -> tuple[dict[str, object] | None, str | None]:
    drink_name = clean(row.get("Drink Name"))
    category = clean(row.get("Category")).lower()
    price_value = clean(row.get("Price (DKK)"))
    units_value = clean(row.get("Units Sold"))
    if not all((drink_name, category, price_value, units_value)):
        return None, "missing required source value"
    if category not in CATEGORIES:
        return None, f"unsupported category: {category}"
    try:
        unit_price = parse_decimal(price_value)
        units_sold = int(units_value)
    except (ValueError, InvalidOperation):
        return None, "price or units sold is not numeric"
    if unit_price < 0 or units_sold < 0:
        return None, "price or units sold is negative"
    return {
        "drink_name": drink_name,
        "category": CATEGORIES[category],
        "unit_price": unit_price,
        "units_sold": units_sold,
    }, None


def batch_sql(path: Path, row_count: int, accepted: int, rejected: int) -> str:
    status = "completed" if rejected == 0 else "completed_with_rejections"
    return "\n".join(
        [
            "INSERT INTO import_batches",
            "    (source_system, file_name, file_sha256, row_count, accepted_count, rejected_count, status)",
            f"VALUES ({sql_string(SOURCE_SYSTEM)}, {sql_string(path.name)}, {sql_string(file_sha256(path))}, {row_count}, {accepted}, {rejected}, {sql_string(status)})",
            "ON DUPLICATE KEY UPDATE",
            "    id = LAST_INSERT_ID(id), imported_at = CURRENT_TIMESTAMP,",
            "    row_count = VALUES(row_count), accepted_count = VALUES(accepted_count),",
            "    rejected_count = VALUES(rejected_count), status = VALUES(status);",
            "SET @import_batch_id = LAST_INSERT_ID();",
        ]
    )


def compare_csv_xlsx(csv_rows: list[dict[str, str | None]], xlsx_rows: list[dict[str, str | None]]) -> list[str]:
    differences: list[str] = []
    for row_number, (csv_row, xlsx_row) in enumerate(zip(csv_rows, xlsx_rows), start=2):
        fields = ("First Name", "Family Name", "Country", "Room Type", "Days Rented", "Season", "Price")
        if any(clean(csv_row.get(field)) != clean(xlsx_row.get(field)) for field in fields):
            differences.append(f"row {row_number}")
    if len(csv_rows) != len(xlsx_rows):
        differences.append(f"row-count CSV={len(csv_rows)} XLSX={len(xlsx_rows)}")
    return differences


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--customer-dir", type=Path, required=True)
    args = parser.parse_args()
    customer_dir = args.customer_dir
    guest_csv = customer_dir / "international_names_with_rooms_1000.csv"
    guest_xlsx = customer_dir / "international_names_with_rooms_1000.xlsx"
    drinks_xlsx = customer_dir / "drinks_menu_with_sales.xlsx"
    for path in (guest_csv, guest_xlsx, drinks_xlsx):
        if not path.is_file():
            parser.error(f"missing source file: {path}")

    guest_xlsx_rows = read_xlsx(guest_xlsx)
    guest_csv_rows = read_csv(guest_csv)
    drink_rows = read_xlsx(drinks_xlsx)
    csv_xlsx_differences = compare_csv_xlsx(guest_csv_rows, guest_xlsx_rows)

    valid_guests: list[tuple[str, dict[str, object]]] = []
    rejected_guests: list[tuple[str, dict[str, str | None], str]] = []
    for row_number, row in enumerate(guest_xlsx_rows, start=2):
        source_record_id = f"Sheet1:{row_number}"
        valid, reason = validate_guest_row(row)
        if valid is None:
            rejected_guests.append((source_record_id, row, reason or "invalid row"))
        else:
            valid_guests.append((source_record_id, valid))

    valid_drinks: list[tuple[str, dict[str, object]]] = []
    rejected_drinks: list[tuple[str, dict[str, str | None], str]] = []
    for row_number, row in enumerate(drink_rows, start=2):
        source_record_id = f"Sheet1:{row_number}"
        valid, reason = validate_drink_row(row)
        if valid is None:
            rejected_drinks.append((source_record_id, row, reason or "invalid row"))
        else:
            valid_drinks.append((source_record_id, valid))

    print("Customer data profile:", file=sys.stderr)
    print(f"  guest source XLSX: {len(guest_xlsx_rows)} rows, {len(valid_guests)} accepted, {len(rejected_guests)} rejected", file=sys.stderr)
    print(f"  guest source CSV: {len(guest_csv_rows)} rows, used for comparison only", file=sys.stderr)
    print(f"  CSV/XLSX differences: {len(csv_xlsx_differences)} ({', '.join(csv_xlsx_differences[:5]) or 'none'})", file=sys.stderr)
    print(f"  drinks source XLSX: {len(drink_rows)} rows, {len(valid_drinks)} accepted, {len(rejected_drinks)} rejected", file=sys.stderr)
    for source_record_id, _, reason in rejected_guests:
        print(f"  rejected guest row {source_record_id}: {reason}", file=sys.stderr)
    for source_record_id, _, reason in rejected_drinks:
        print(f"  rejected drink row {source_record_id}: {reason}", file=sys.stderr)

    sql: list[str] = [
        "SET NAMES utf8mb4;",
        "START TRANSACTION;",
        "-- Generated by database/import/import_customer_data.py.",
        "-- XLSX is canonical for guest rows; CSV is validation-only because its encoding contains a replacement character.",
        batch_sql(guest_xlsx, len(guest_xlsx_rows), len(valid_guests), len(rejected_guests)),
    ]

    for source_record_id, row in valid_guests:
        sql.extend(
            [
                "INSERT INTO guests (first_name, last_name, country_code, country_name)",
                f"VALUES ({sql_string(row['first_name'])}, {sql_string(row['family_name'])}, {sql_string(row['country_code'])}, {sql_string(row['country_name'])})",
                "ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), country_name = VALUES(country_name);",
                "SET @guest_id = LAST_INSERT_ID();",
                "INSERT INTO customer_stay_records",
                "    (import_batch_id, source_record_id, guest_id, first_name, family_name, country_name, country_code, source_room_type, days_rented, season_code, price_total, row_status)",
                f"VALUES (@import_batch_id, {sql_string(source_record_id)}, @guest_id, {sql_string(row['first_name'])}, {sql_string(row['family_name'])}, {sql_string(row['country_name'])}, {sql_string(row['country_code'])}, {sql_string(row['room_type'])}, {row['days_rented']}, {sql_string(row['season'])}, {sql_decimal(row['price_total'])}, 'accepted')",
                "ON DUPLICATE KEY UPDATE guest_id = VALUES(guest_id), row_status = VALUES(row_status), rejection_reason = NULL;",
            ]
        )

    for source_record_id, row, reason in rejected_guests:
        sql.extend(
            [
                "INSERT INTO customer_stay_records",
                "    (import_batch_id, source_record_id, first_name, family_name, country_name, source_room_type, days_rented, season_code, price_total, row_status, rejection_reason)",
                f"VALUES (@import_batch_id, {sql_string(source_record_id)}, {sql_string(row.get('First Name'))}, {sql_string(row.get('Family Name'))}, {sql_string(row.get('Country'))}, {sql_string(row.get('Room Type'))}, NULL, {sql_string(row.get('Season'))}, NULL, 'rejected', {sql_string(reason)})",
                "ON DUPLICATE KEY UPDATE row_status = VALUES(row_status), rejection_reason = VALUES(rejection_reason);",
            ]
        )

    sql.append(
        batch_sql(drinks_xlsx, len(drink_rows), len(valid_drinks), len(rejected_drinks))
    )
    for source_record_id, row in valid_drinks:
        sql.extend(
            [
                "INSERT INTO bar_products (name, category, price, active)",
                f"VALUES ({sql_string(row['drink_name'])}, {sql_string(row['category'])}, {sql_decimal(row['unit_price'])}, TRUE)",
                "ON DUPLICATE KEY UPDATE id = LAST_INSERT_ID(id), category = VALUES(category), price = VALUES(price), active = TRUE;",
                "SET @product_id = LAST_INSERT_ID();",
                "INSERT INTO customer_bar_sales_aggregates",
                "    (import_batch_id, source_record_id, product_id, drink_name, category, unit_price, units_sold, row_status)",
                f"VALUES (@import_batch_id, {sql_string(source_record_id)}, @product_id, {sql_string(row['drink_name'])}, {sql_string(row['category'])}, {sql_decimal(row['unit_price'])}, {row['units_sold']}, 'accepted')",
                "ON DUPLICATE KEY UPDATE product_id = VALUES(product_id), row_status = VALUES(row_status), rejection_reason = NULL;",
            ]
        )
    for source_record_id, row, reason in rejected_drinks:
        sql.extend(
            [
                "INSERT INTO customer_bar_sales_aggregates",
                "    (import_batch_id, source_record_id, drink_name, row_status, rejection_reason)",
                f"VALUES (@import_batch_id, {sql_string(source_record_id)}, {sql_string(row.get('Drink Name'))}, 'rejected', {sql_string(reason)});",
            ]
        )

    sql.append("COMMIT;")
    print("\n".join(sql))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
