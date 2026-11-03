-- Keep generated customer-import bookings distinguishable from real bookings.
ALTER TABLE bookings
    ADD COLUMN data_origin ENUM('operational', 'synthetic_import') NOT NULL
        DEFAULT 'operational' AFTER status,
    ADD COLUMN import_batch_id BIGINT UNSIGNED NULL AFTER data_origin,
    ADD COLUMN source_record_id VARCHAR(120) NULL AFTER import_batch_id,
    ADD UNIQUE KEY uq_bookings_import_source (import_batch_id, source_record_id),
    ADD KEY ix_bookings_data_origin (data_origin),
    ADD CONSTRAINT fk_bookings_import_batch
        FOREIGN KEY (import_batch_id) REFERENCES import_batches (id)
        ON UPDATE CASCADE ON DELETE RESTRICT;
