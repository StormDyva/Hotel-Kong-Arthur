-- Deterministic development/test seed for the booking foundation.
-- This is not claimed to be the hotel's historical source data. It is safe to
-- re-run: natural keys are updated, and the same explicit IDs are reused.

INSERT INTO room_types
    (id, name, description, capacity, active,
     base_price_low_season, base_price_mid_season, base_price_high_season)
VALUES
    (1, 'Single', 'Compact room for one guest', 1, TRUE, 900.00, 1100.00, 1400.00),
    (2, 'Double', 'Room for two guests', 2, TRUE, 1100.00, 1400.00, 1800.00),
    (3, 'Twin', 'Room with two separate beds', 2, TRUE, 1150.00, 1450.00, 1850.00),
    (4, 'Superior Double', 'Larger double room', 2, TRUE, 1350.00, 1700.00, 2200.00),
    (5, 'Family', 'Room for up to three guests', 3, TRUE, 1600.00, 2000.00, 2600.00),
    (6, 'Junior Suite', 'Suite for up to three guests', 3, TRUE, 2100.00, 2600.00, 3300.00),
    (7, 'Suite', 'Suite for up to four guests', 4, TRUE, 2800.00, 3400.00, 4300.00),
    (8, 'Accessible Double', 'Accessible room for two guests', 2, TRUE, 1200.00, 1500.00, 1900.00)
ON DUPLICATE KEY UPDATE
    description = VALUES(description),
    capacity = VALUES(capacity),
    active = VALUES(active),
    base_price_low_season = VALUES(base_price_low_season),
    base_price_mid_season = VALUES(base_price_mid_season),
    base_price_high_season = VALUES(base_price_high_season);

INSERT INTO rooms (id, room_number, room_type_id, status, active)
VALUES
    (101, '101', 1, 'available', TRUE),
    (102, '102', 2, 'available', TRUE),
    (103, '103', 2, 'available', TRUE),
    (201, '201', 3, 'available', TRUE),
    (202, '202', 4, 'available', TRUE),
    (203, '203', 5, 'available', TRUE),
    (301, '301', 6, 'available', TRUE),
    (302, '302', 7, 'available', TRUE),
    (303, '303', 8, 'maintenance', TRUE),
    (401, '401', 1, 'available', TRUE),
    (402, '402', 2, 'available', TRUE),
    (403, '403', 3, 'available', TRUE),
    (501, '501', 4, 'available', TRUE),
    (502, '502', 5, 'available', TRUE),
    (601, '601', 6, 'available', TRUE),
    (602, '602', 7, 'available', TRUE)
ON DUPLICATE KEY UPDATE
    room_number = VALUES(room_number),
    room_type_id = VALUES(room_type_id),
    status = VALUES(status),
    active = VALUES(active);

INSERT INTO guests (id, first_name, last_name, email, phone, country_code, country_name)
VALUES
    (1, 'Anna', 'Jensen', 'anna.jensen@example.test', '+45 11111111', 'DK', 'Denmark'),
    (2, 'Liam', 'Smith', 'liam.smith@example.test', '+44 22222222', 'GB', 'United Kingdom'),
    (3, 'Sofia', 'Garcia', 'sofia.garcia@example.test', '+34 33333333', 'ES', 'Spain'),
    (4, 'Noah', 'Müller', 'noah.muller@example.test', '+49 44444444', 'DE', 'Germany')
ON DUPLICATE KEY UPDATE
    first_name = VALUES(first_name),
    last_name = VALUES(last_name),
    email = VALUES(email),
    phone = VALUES(phone),
    country_code = VALUES(country_code),
    country_name = VALUES(country_name);

INSERT INTO seasons (id, code, name, active)
VALUES
    (1, 'low', 'Lavsæson', TRUE),
    (2, 'mid', 'Mellemsæson', TRUE),
    (3, 'high', 'Højsæson', TRUE)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    active = VALUES(active);

INSERT INTO season_periods
    (id, season_id, start_month, start_day, end_month, end_day)
VALUES
    (1, 1, 1, 1, 3, 31),
    (2, 1, 11, 1, 12, 31),
    (3, 2, 4, 1, 5, 31),
    (4, 2, 9, 1, 10, 31),
    (5, 3, 6, 1, 8, 31)
ON DUPLICATE KEY UPDATE
    season_id = VALUES(season_id),
    start_month = VALUES(start_month),
    start_day = VALUES(start_day),
    end_month = VALUES(end_month),
    end_day = VALUES(end_day);

INSERT INTO room_type_prices (room_type_id, season_id, price_per_night, currency, active)
SELECT rt.id, s.id,
       CASE s.code
           WHEN 'low' THEN rt.base_price_low_season
           WHEN 'mid' THEN rt.base_price_mid_season
           WHEN 'high' THEN rt.base_price_high_season
       END,
       'DKK', TRUE
FROM room_types rt
JOIN seasons s ON s.code IN ('low', 'mid', 'high')
ON DUPLICATE KEY UPDATE
    price_per_night = VALUES(price_per_night),
    currency = VALUES(currency),
    active = VALUES(active);

INSERT INTO bookings
    (id, guest_id, room_id, check_in, check_out, guests_count,
     price_total, currency, status, cancelled_at)
VALUES
    (1001, 1, 102, '2026-06-10', '2026-06-12', 2, 3600.00, 'DKK', 'confirmed', NULL),
    (1002, 2, 201, '2026-03-10', '2026-03-12', 2, 2300.00, 'DKK', 'confirmed', NULL),
    (1003, 3, 102, '2026-06-10', '2026-06-12', 2, 3600.00, 'DKK', 'cancelled', '2026-05-20 10:00:00'),
    (1004, 4, 302, '2026-09-05', '2026-09-07', 2, 6800.00, 'DKK', 'confirmed', NULL)
ON DUPLICATE KEY UPDATE
    guest_id = VALUES(guest_id),
    room_id = VALUES(room_id),
    check_in = VALUES(check_in),
    check_out = VALUES(check_out),
    guests_count = VALUES(guests_count),
    price_total = VALUES(price_total),
    currency = VALUES(currency),
    status = VALUES(status),
    cancelled_at = VALUES(cancelled_at);

INSERT INTO booking_price_lines
    (booking_id, night_date, season_id, price_per_night, quantity, line_total, currency)
VALUES
    (1001, '2026-06-10', 3, 1800.00, 1, 1800.00, 'DKK'),
    (1001, '2026-06-11', 3, 1800.00, 1, 1800.00, 'DKK'),
    (1002, '2026-03-10', 1, 1150.00, 1, 1150.00, 'DKK'),
    (1002, '2026-03-11', 1, 1150.00, 1, 1150.00, 'DKK'),
    (1003, '2026-06-10', 3, 1800.00, 1, 1800.00, 'DKK'),
    (1003, '2026-06-11', 3, 1800.00, 1, 1800.00, 'DKK'),
    (1004, '2026-09-05', 2, 3400.00, 1, 3400.00, 'DKK'),
    (1004, '2026-09-06', 2, 3400.00, 1, 3400.00, 'DKK')
ON DUPLICATE KEY UPDATE
    season_id = VALUES(season_id),
    price_per_night = VALUES(price_per_night),
    quantity = VALUES(quantity),
    line_total = VALUES(line_total),
    currency = VALUES(currency);

INSERT INTO bar_products (id, name, category, price, active)
VALUES
    (1, 'Kong Arthur Martini', 'cocktail', 125.00, TRUE),
    (2, 'Espresso', 'coffee', 40.00, TRUE),
    (3, 'Old Fashioned', 'cocktail', 135.00, TRUE),
    (4, 'Cappuccino', 'coffee', 55.00, TRUE)
ON DUPLICATE KEY UPDATE
    name = VALUES(name),
    category = VALUES(category),
    price = VALUES(price),
    active = VALUES(active);

INSERT INTO bar_sales
    (id, product_id, sold_at, quantity, unit_price, currency, employee_name)
VALUES
    (1, 1, '2026-06-10 18:00:00', 2, 125.00, 'DKK', 'Helene Christine'),
    (2, 2, '2026-06-10 08:00:00', 4, 40.00, 'DKK', 'Helene Christine'),
    (3, 3, '2026-06-11 19:00:00', 1, 135.00, 'DKK', 'Mads Hansen'),
    (4, 4, '2026-09-05 09:00:00', 3, 55.00, 'DKK', 'Helene Christine')
ON DUPLICATE KEY UPDATE
    product_id = VALUES(product_id),
    sold_at = VALUES(sold_at),
    quantity = VALUES(quantity),
    unit_price = VALUES(unit_price),
    currency = VALUES(currency),
    employee_name = VALUES(employee_name);
