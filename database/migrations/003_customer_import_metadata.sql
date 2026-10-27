-- Hotel Kong Arthur - customer data import metadata and staging
-- Depends on 001_initial_schema.sql and 002_booking_database_foundation.sql.
-- Customer source rows are retained without pretending incomplete records are
-- live bookings or dated employee-level bar sales.

ALTER TABLE guests
    ADD UNIQUE KEY uq_guests_identity (first_name, last_name, country_code);

CREATE TABLE import_batches (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    source_system VARCHAR(160) NOT NULL,
    file_name VARCHAR(255) NOT NULL,
    file_sha256 CHAR(64) NOT NULL,
    imported_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    row_count INT UNSIGNED NOT NULL,
    accepted_count INT UNSIGNED NOT NULL,
    rejected_count INT UNSIGNED NOT NULL,
    status ENUM('completed', 'completed_with_rejections', 'failed') NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_import_batches_file (source_system, file_name, file_sha256),
    KEY ix_import_batches_source_time (source_system, imported_at),
    CONSTRAINT chk_import_batches_counts CHECK (
        accepted_count + rejected_count = row_count
    )
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE customer_stay_records (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    import_batch_id BIGINT UNSIGNED NOT NULL,
    source_record_id VARCHAR(120) NOT NULL,
    guest_id BIGINT UNSIGNED NULL,
    first_name VARCHAR(120) NULL,
    family_name VARCHAR(120) NULL,
    country_name VARCHAR(120) NULL,
    country_code CHAR(2) NULL,
    source_room_type VARCHAR(120) NULL,
    days_rented SMALLINT UNSIGNED NULL,
    season_code VARCHAR(40) NULL,
    price_total DECIMAL(12, 2) NULL,
    currency CHAR(3) NOT NULL DEFAULT 'DKK',
    row_status ENUM('accepted', 'rejected') NOT NULL,
    rejection_reason VARCHAR(500) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_customer_stay_source_row (import_batch_id, source_record_id),
    KEY ix_customer_stay_guest (guest_id),
    KEY ix_customer_stay_country (country_code),
    KEY ix_customer_stay_room_season (source_room_type, season_code),
    CONSTRAINT fk_customer_stay_batch
        FOREIGN KEY (import_batch_id) REFERENCES import_batches (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_customer_stay_guest
        FOREIGN KEY (guest_id) REFERENCES guests (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_customer_stay_price CHECK (price_total IS NULL OR price_total >= 0),
    CONSTRAINT chk_customer_stay_currency CHECK (currency = 'DKK')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE customer_bar_sales_aggregates (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    import_batch_id BIGINT UNSIGNED NOT NULL,
    source_record_id VARCHAR(120) NOT NULL,
    product_id BIGINT UNSIGNED NULL,
    drink_name VARCHAR(160) NULL,
    category ENUM('cocktail', 'coffee', 'other') NULL,
    unit_price DECIMAL(10, 2) NULL,
    units_sold INT UNSIGNED NULL,
    currency CHAR(3) NOT NULL DEFAULT 'DKK',
    row_status ENUM('accepted', 'rejected') NOT NULL,
    rejection_reason VARCHAR(500) NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_customer_bar_source_row (import_batch_id, source_record_id),
    KEY ix_customer_bar_product (product_id),
    KEY ix_customer_bar_category (category),
    CONSTRAINT fk_customer_bar_batch
        FOREIGN KEY (import_batch_id) REFERENCES import_batches (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_customer_bar_product
        FOREIGN KEY (product_id) REFERENCES bar_products (id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_customer_bar_price CHECK (unit_price IS NULL OR unit_price >= 0),
    CONSTRAINT chk_customer_bar_units CHECK (units_sold IS NULL OR units_sold >= 0),
    CONSTRAINT chk_customer_bar_currency CHECK (currency = 'DKK')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
