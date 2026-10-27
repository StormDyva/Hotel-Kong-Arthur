-- Hotel Kong Arthur - booking database foundation
-- Depends on 001_initial_schema.sql. Non-destructive: existing tables and rows
-- are retained; new columns have compatible defaults where possible.

ALTER TABLE room_types
    ADD COLUMN description VARCHAR(500) NULL AFTER name,
    ADD COLUMN active BOOLEAN NOT NULL DEFAULT TRUE AFTER capacity;

ALTER TABLE rooms
    ADD COLUMN status ENUM('available', 'maintenance', 'inactive')
        NOT NULL DEFAULT 'available' AFTER room_type_id;

ALTER TABLE guests
    DROP INDEX uq_guests_country_name_code,
    ADD COLUMN first_name VARCHAR(120) NULL AFTER id,
    ADD COLUMN last_name VARCHAR(120) NULL AFTER first_name,
    ADD COLUMN email VARCHAR(254) NULL AFTER last_name,
    ADD COLUMN phone VARCHAR(40) NULL AFTER email;

ALTER TABLE bookings
    ADD COLUMN cancelled_at TIMESTAMP NULL AFTER status;

DROP TRIGGER IF EXISTS bookings_capacity_before_insert;
DROP TRIGGER IF EXISTS bookings_capacity_before_update;

DELIMITER //

CREATE TRIGGER bookings_capacity_before_insert
BEFORE INSERT ON bookings
FOR EACH ROW
BEGIN
    DECLARE room_capacity TINYINT UNSIGNED;

    SELECT rt.capacity
      INTO room_capacity
      FROM rooms r
      JOIN room_types rt ON rt.id = r.room_type_id
     WHERE r.id = NEW.room_id
       AND r.active = TRUE
       AND r.status = 'available'
       AND rt.active = TRUE;

    IF room_capacity IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'room_id must reference an active, available room type';
    END IF;

    IF NEW.guests_count > room_capacity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'guests_count exceeds room type capacity';
    END IF;
END//

CREATE TRIGGER bookings_capacity_before_update
BEFORE UPDATE ON bookings
FOR EACH ROW
BEGIN
    DECLARE room_capacity TINYINT UNSIGNED;

    SELECT rt.capacity
      INTO room_capacity
      FROM rooms r
      JOIN room_types rt ON rt.id = r.room_type_id
     WHERE r.id = NEW.room_id
       AND r.active = TRUE
       AND r.status = 'available'
       AND rt.active = TRUE;

    IF room_capacity IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'room_id must reference an active, available room type';
    END IF;

    IF NEW.guests_count > room_capacity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'guests_count exceeds room type capacity';
    END IF;
END//

DELIMITER ;

CREATE TABLE seasons (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    code VARCHAR(40) NOT NULL,
    name VARCHAR(120) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_seasons_code (code),
    UNIQUE KEY uq_seasons_name (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- A season may contain more than one recurring calendar interval. This models
-- low season in both January-March and November-December without duplicating
-- its room-type prices.
CREATE TABLE season_periods (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    season_id BIGINT UNSIGNED NOT NULL,
    start_month TINYINT UNSIGNED NOT NULL,
    start_day TINYINT UNSIGNED NOT NULL,
    end_month TINYINT UNSIGNED NOT NULL,
    end_day TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_season_period (season_id, start_month, start_day, end_month, end_day),
    KEY ix_season_period_lookup (start_month, start_day, end_month, end_day),
    CONSTRAINT fk_season_periods_season
        FOREIGN KEY (season_id) REFERENCES seasons (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_season_periods_months CHECK (
        start_month BETWEEN 1 AND 12
        AND end_month BETWEEN 1 AND 12
    ),
    CONSTRAINT chk_season_periods_days CHECK (
        start_day BETWEEN 1 AND 31
        AND end_day BETWEEN 1 AND 31
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE room_type_prices (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    room_type_id BIGINT UNSIGNED NOT NULL,
    season_id BIGINT UNSIGNED NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    currency CHAR(3) NOT NULL DEFAULT 'DKK',
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_room_type_price_season (room_type_id, season_id),
    KEY ix_room_type_prices_season (season_id, active),
    CONSTRAINT fk_room_type_prices_room_type
        FOREIGN KEY (room_type_id) REFERENCES room_types (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_room_type_prices_season
        FOREIGN KEY (season_id) REFERENCES seasons (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_room_type_prices_amount CHECK (price_per_night >= 0),
    CONSTRAINT chk_room_type_prices_currency CHECK (currency = 'DKK')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE booking_price_lines (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    booking_id BIGINT UNSIGNED NOT NULL,
    night_date DATE NOT NULL,
    season_id BIGINT UNSIGNED NOT NULL,
    price_per_night DECIMAL(10, 2) NOT NULL,
    quantity TINYINT UNSIGNED NOT NULL DEFAULT 1,
    line_total DECIMAL(12, 2) NOT NULL,
    currency CHAR(3) NOT NULL DEFAULT 'DKK',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_booking_price_line_night (booking_id, night_date),
    KEY ix_booking_price_lines_season (season_id, night_date),
    CONSTRAINT fk_booking_price_lines_booking
        FOREIGN KEY (booking_id) REFERENCES bookings (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_booking_price_lines_season
        FOREIGN KEY (season_id) REFERENCES seasons (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_booking_price_lines_price CHECK (price_per_night >= 0),
    CONSTRAINT chk_booking_price_lines_quantity CHECK (quantity >= 1),
    CONSTRAINT chk_booking_price_lines_total CHECK (line_total >= 0),
    CONSTRAINT chk_booking_price_lines_currency CHECK (currency = 'DKK')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Availability is intentionally a query/service rule rather than a CHECK
-- constraint: MySQL CHECK constraints cannot compare two booking rows.
-- The future booking transaction must lock the room row, then run the overlap
-- predicate documented in docs/data-dictionary.md before inserting/updating.
