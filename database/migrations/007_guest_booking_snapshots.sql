-- Names and nationalities are attributes, never a person's identity.
ALTER TABLE guests
    DROP INDEX uq_guests_identity,
    ADD COLUMN import_key CHAR(64) NULL,
    ADD UNIQUE KEY uq_guests_import_key (import_key);
-- NULL import_key permits independent booking snapshots. Historical source rows
-- receive deterministic keys on subsequent import; no lost contacts are invented.
