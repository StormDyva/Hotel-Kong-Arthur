-- Exact local CSV facts, separate from the existing anonymized demo bookings.
CREATE TABLE csv_source_rows (
    import_batch_id BIGINT UNSIGNED NOT NULL,
    source_row_number INT UNSIGNED NOT NULL,
    raw_record JSON NOT NULL,
    booking_id BIGINT UNSIGNED NOT NULL,
    PRIMARY KEY (import_batch_id,source_row_number),
    CONSTRAINT fk_csv_batch FOREIGN KEY(import_batch_id) REFERENCES import_batches(id) ON DELETE RESTRICT,
    CONSTRAINT fk_csv_booking FOREIGN KEY(booking_id) REFERENCES bookings(id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
