#!/usr/bin/env python3
"""Generate synthetic bookings from anonymized customer-stay seed records.

Dates, assigned rooms, and one guest per booking are invented. The source
amount, length of stay, room category, country, and season are retained.
"""

from __future__ import annotations

import argparse
import re
from collections import defaultdict
from datetime import date, timedelta
from decimal import Decimal
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
SOURCE = ROOT / "database/seed/004_anonymized_customer_source.sql"
INVENTORY = ROOT / "database/seed/002_assignment_reference_inventory.sql"
DEFAULT_OUTPUT = ROOT / "database/seed/005_synthetic_customer_bookings.sql"
BATCH_HASH = "e829206c8c697074a7d9621ec3fc1d6d4a329bc2309270b49f63630e8fa9eee8"
ROOM_TYPES = {
    "Standard Single": 1,
    "Grand Lit": 2,
    "Standard Double": 3,
    "Superior Double": 4,
    "Junior Suite": 5,
    "Spa Executive": 6,
    "Suite": 7,
    "LOFT Suite": 8,
}
WINDOWS = {
    "low": (date(2001, 1, 1), date(2001, 3, 31)),
    "mid": (date(2001, 4, 1), date(2001, 5, 31)),
    "high": (date(2001, 6, 1), date(2001, 8, 31)),
}


def read_records() -> list[dict]:
    row_pattern = re.compile(
        r"VALUES \(@import_batch_id, 'Sheet1:(\d+)', @guest_id, 'Guest', "
        r"'Imported Record \d{4}', '[^']*', '[A-Z]{2}', '([^']+)', "
        r"(\d+), '(low|mid|high)', ([0-9]+(?:\.[0-9]+)?), 'accepted'\)"
    )
    records = []
    for match in row_pattern.finditer(SOURCE.read_text()):
        source_row, source_type, nights, season, total = match.groups()
        if source_type not in ROOM_TYPES:
            raise ValueError(f"Unknown source room type: {source_type}")
        records.append({
            "source": f"Sheet1:{source_row}", "type_id": ROOM_TYPES[source_type],
            "nights": int(nights), "season": season, "total": Decimal(total),
        })
    if len(records) != 1000:
        raise ValueError(f"Expected 1000 anonymized stay records, found {len(records)}")
    return records


def room_counts() -> dict[int, int]:
    pattern = re.compile(r"\(\d+,'DEMO-\d+',([1-8]),'available',TRUE\)")
    counts: dict[int, int] = defaultdict(int)
    for match in pattern.finditer(INVENTORY.read_text()):
        counts[int(match.group(1))] += 1
    if set(counts) != set(range(1, 9)):
        raise ValueError("Could not read all eight room categories from inventory seed")
    return counts


def schedule(records: list[dict], counts: dict[int, int]) -> list[dict]:
    used_by_type: dict[int, int] = defaultdict(int)
    scheduled = []
    for record in records:
        type_id = record["type_id"]
        type_sequence = used_by_type[type_id]
        used_by_type[type_id] += 1
        room_offset = type_sequence % counts[type_id]
        year_number = type_sequence // counts[type_id]
        first, last = WINDOWS[record["season"]]
        nights = record["nights"]
        latest_start = last - timedelta(days=nights - 1)
        available_days = (latest_start - first).days + 1
        offset = (type_sequence * 13 + int(record["source"].split(":")[1])) % available_days
        start = first.replace(year=2027 + year_number) + timedelta(days=offset)
        record = {**record, "room_offset": room_offset, "start": start,
                  "end": start + timedelta(days=nights)}
        scheduled.append(record)
    return scheduled


def money(value: Decimal) -> str:
    return f"{value:.2f}"


def render(records: list[dict]) -> str:
    lines = [
        "SET NAMES utf8mb4;",
        "START TRANSACTION;",
        "-- Invented booking dates, room assignment, and party size; source values retained.",
        f"SET @import_batch_id = (SELECT id FROM import_batches WHERE file_sha256 = '{BATCH_HASH}');",
        "",
    ]
    for row in records:
        start, end = row["start"], row["end"]
        lines.extend([
            "INSERT INTO bookings",
            "    (guest_id, room_id, check_in, check_out, guests_count, price_total, currency, status, data_origin, import_batch_id, source_record_id)",
            f"SELECT c.guest_id, (SELECT r.id FROM rooms r WHERE r.room_type_id={row['type_id']} AND r.active=TRUE AND r.status='available' ORDER BY r.id LIMIT 1 OFFSET {row['room_offset']}), '{start:%Y-%m-%d}', '{end:%Y-%m-%d}', 1, {money(row['total'])}, 'DKK', 'confirmed', 'synthetic_import', @import_batch_id, '{row['source']}'",
            "FROM customer_stay_records c",
            f"WHERE c.import_batch_id=@import_batch_id AND c.source_record_id='{row['source']}' AND c.row_status='accepted'",
            "ON DUPLICATE KEY UPDATE guest_id=VALUES(guest_id), room_id=VALUES(room_id), check_in=VALUES(check_in), check_out=VALUES(check_out), guests_count=VALUES(guests_count), price_total=VALUES(price_total), data_origin=VALUES(data_origin);",
        ])

    line_rows = []
    for row in records:
        nightly_cents = int((row["total"] * 100).quantize(Decimal("1")))
        base, remainder = divmod(nightly_cents, row["nights"])
        for index in range(row["nights"]):
            amount = Decimal(base + (1 if index < remainder else 0)) / 100
            night = row["start"] + timedelta(days=index)
            line_rows.append((row["source"], f"'{night:%Y-%m-%d}'", row["season"], money(amount)))
    for offset in range(0, len(line_rows), 250):
        chunk = line_rows[offset:offset + 250]
        lines.extend([
            "INSERT INTO booking_price_lines (booking_id, night_date, season_id, price_per_night, line_total)",
            "SELECT b.id, x.night_date, s.id, x.amount, x.amount",
            "FROM (SELECT source_record_id, night_date, season_code, amount FROM (",
        ])
        lines.append(" UNION ALL ".join(
            f"SELECT '{i}' source_record_id, {d} night_date, '{s}' season_code, {a} amount"
            for i, d, s, a in chunk
        ))
        lines.extend([
            ") generated_lines) x",
            "JOIN bookings b ON b.import_batch_id=@import_batch_id AND b.source_record_id=x.source_record_id",
            "JOIN seasons s ON s.code=x.season_code",
            "ON DUPLICATE KEY UPDATE season_id=VALUES(season_id), price_per_night=VALUES(price_per_night), line_total=VALUES(line_total);",
        ])
    lines.extend(["COMMIT;", ""])
    return "\n".join(lines)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()
    records = schedule(read_records(), room_counts())
    args.output.write_text(render(records))
    print(f"Generated {len(records)} synthetic bookings and {sum(r['nights'] for r in records)} price lines: {args.output}")


if __name__ == "__main__":
    main()
