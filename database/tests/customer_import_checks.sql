-- Read-only checks for migration 003 and the generated customer import SQL.

DELIMITER //

CREATE PROCEDURE assert_customer_import()
BEGIN
    DECLARE failed_checks INT DEFAULT 0;

    SELECT COUNT(*) INTO failed_checks
      FROM import_batches
     WHERE source_system = 'ITAKEA/hoteldata';
    IF failed_checks <> 2 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected two ITAKEA import batches';
    END IF;

    SELECT COUNT(*) INTO failed_checks
      FROM import_batches
     WHERE source_system = 'ITAKEA/hoteldata'
       AND accepted_count + rejected_count <> row_count;
    IF failed_checks <> 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Import batch counts do not reconcile';
    END IF;

    SELECT COUNT(*) INTO failed_checks
      FROM customer_stay_records
     WHERE row_status = 'accepted' AND guest_id IS NULL;
    IF failed_checks <> 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Accepted customer stay has no guest';
    END IF;

    SELECT COUNT(*) INTO failed_checks
      FROM customer_stay_records
     WHERE row_status = 'accepted';
    IF failed_checks <> 1000 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected 1000 accepted customer stay rows';
    END IF;

    SELECT COUNT(*) INTO failed_checks
      FROM customer_stay_records
     WHERE row_status = 'rejected' AND rejection_reason IS NOT NULL;
    IF failed_checks <> 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected one explained rejected customer row';
    END IF;

    SELECT COUNT(*) INTO failed_checks
      FROM customer_stay_records
     WHERE row_status = 'accepted'
       AND (days_rented IS NULL OR days_rented < 1 OR price_total IS NULL OR price_total < 0);
    IF failed_checks <> 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Accepted customer stay has invalid numeric data';
    END IF;

    SELECT COALESCE(MAX(duplicate_count), 0) INTO failed_checks
      FROM (
          SELECT COUNT(*) AS duplicate_count
            FROM customer_stay_records
           GROUP BY import_batch_id, source_record_id
      ) duplicate_rows;
    IF failed_checks > 1 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Duplicate customer source record';
    END IF;

    SELECT COUNT(*) INTO failed_checks
      FROM customer_bar_sales_aggregates
     WHERE row_status = 'accepted' AND product_id IS NULL;
    IF failed_checks <> 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Accepted bar row has no product';
    END IF;

    SELECT COUNT(*) INTO failed_checks
      FROM customer_bar_sales_aggregates
     WHERE row_status = 'accepted';
    IF failed_checks <> 30 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected 30 accepted bar aggregate rows';
    END IF;

    SELECT COUNT(*) INTO failed_checks FROM bar_sales;
    IF failed_checks <> 4 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Existing bar_sales rows were changed';
    END IF;

    SELECT COUNT(*) INTO failed_checks FROM bookings;
    IF failed_checks <> 4 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Existing bookings were changed';
    END IF;

    SELECT COUNT(*) INTO failed_checks FROM booking_price_lines;
    IF failed_checks <> 8 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Existing booking price lines were changed';
    END IF;

    SELECT 'customer import checks passed' AS result;
END//

DELIMITER ;

CALL assert_customer_import();
DROP PROCEDURE assert_customer_import;
