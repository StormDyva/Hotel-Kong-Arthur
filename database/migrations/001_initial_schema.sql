-- Hotel Kong Arthur - initial MySQL schema
-- Runtime database: MySQL 8+

CREATE TABLE room_types (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(120) NOT NULL,
    capacity TINYINT UNSIGNED NOT NULL,
    base_price_low_season DECIMAL(10, 2) NOT NULL,
    base_price_mid_season DECIMAL(10, 2) NOT NULL,
    base_price_high_season DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_room_types_name (name),
    CONSTRAINT chk_room_types_capacity CHECK (capacity BETWEEN 1 AND 4),
    CONSTRAINT chk_room_types_prices CHECK (
        base_price_low_season >= 0
        AND base_price_mid_season >= 0
        AND base_price_high_season >= 0
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE rooms (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    room_number VARCHAR(20) NOT NULL,
    room_type_id BIGINT UNSIGNED NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_rooms_room_number (room_number),
    KEY ix_rooms_room_type_active (room_type_id, active),
    CONSTRAINT fk_rooms_room_type
        FOREIGN KEY (room_type_id) REFERENCES room_types (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE guests (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    country_code CHAR(2) NOT NULL,
    country_name VARCHAR(120) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_guests_country_name_code (country_code, country_name),
    KEY ix_guests_country_code (country_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE bookings (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    guest_id BIGINT UNSIGNED NOT NULL,
    room_id BIGINT UNSIGNED NOT NULL,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    guests_count TINYINT UNSIGNED NOT NULL,
    price_total DECIMAL(12, 2) NOT NULL,
    currency CHAR(3) NOT NULL DEFAULT 'DKK',
    status ENUM('confirmed', 'cancelled') NOT NULL DEFAULT 'confirmed',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY ix_bookings_guest_id (guest_id),
    KEY ix_bookings_room_dates_status (room_id, check_in, check_out, status),
    KEY ix_bookings_status_dates (status, check_in, check_out),
    CONSTRAINT fk_bookings_guest
        FOREIGN KEY (guest_id) REFERENCES guests (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_bookings_room
        FOREIGN KEY (room_id) REFERENCES rooms (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_bookings_dates CHECK (check_out > check_in),
    CONSTRAINT chk_bookings_guests_count CHECK (guests_count >= 1),
    CONSTRAINT chk_bookings_price_total CHECK (price_total >= 0),
    CONSTRAINT chk_bookings_currency CHECK (currency = 'DKK')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE bar_products (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(160) NOT NULL,
    category ENUM('cocktail', 'coffee', 'other') NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_bar_products_name (name),
    KEY ix_bar_products_category_active (category, active),
    CONSTRAINT chk_bar_products_price CHECK (price >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE bar_sales (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_id BIGINT UNSIGNED NOT NULL,
    sold_at TIMESTAMP NOT NULL,
    quantity INT UNSIGNED NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    currency CHAR(3) NOT NULL DEFAULT 'DKK',
    employee_name VARCHAR(160) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY ix_bar_sales_product_sold_at (product_id, sold_at),
    KEY ix_bar_sales_employee_sold_at (employee_name, sold_at),
    CONSTRAINT fk_bar_sales_product
        FOREIGN KEY (product_id) REFERENCES bar_products (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_bar_sales_quantity CHECK (quantity >= 1),
    CONSTRAINT chk_bar_sales_unit_price CHECK (unit_price >= 0),
    CONSTRAINT chk_bar_sales_currency CHECK (currency = 'DKK')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
       AND r.active = TRUE;

    IF room_capacity IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'room_id must reference an active room';
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
       AND r.active = TRUE;

    IF room_capacity IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'room_id must reference an active room';
    END IF;

    IF NEW.guests_count > room_capacity THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'guests_count exceeds room type capacity';
    END IF;
END//

DELIMITER ;
