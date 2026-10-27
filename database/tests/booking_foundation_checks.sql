-- Read-only checks for 002_booking_database_foundation.sql and its seed.
-- Run after migrations and seed. The script raises an error on failed checks.

DELIMITER //

CREATE PROCEDURE assert_booking_foundation()
BEGIN
    DECLARE failed_checks INT DEFAULT 0;

    SELECT COUNT(*) INTO failed_checks
      FROM room_types WHERE active = TRUE;
    IF failed_checks < 8 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected at least 8 active room types';
    END IF;

    SELECT COUNT(*) INTO failed_checks FROM rooms;
    IF failed_checks < 16 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected at least 16 seeded rooms';
    END IF;

    SELECT COUNT(*) INTO failed_checks FROM guests
     WHERE first_name IS NOT NULL AND last_name IS NOT NULL AND country_code IS NOT NULL;
    IF failed_checks < 4 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected at least 4 complete seeded guests';
    END IF;

    SELECT COUNT(*) INTO failed_checks FROM seasons WHERE active = TRUE;
    IF failed_checks <> 3 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected exactly 3 active seasons';
    END IF;

    SELECT COUNT(*) INTO failed_checks FROM room_type_prices
     WHERE active = TRUE AND currency = 'DKK' AND price_per_night >= 0;
    IF failed_checks < 24 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected 8 room types x 3 season prices';
    END IF;

    SELECT COUNT(*) INTO failed_checks FROM bookings;
    IF failed_checks < 4 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected at least 4 seeded bookings';
    END IF;

    SELECT COUNT(*) INTO failed_checks
      FROM bookings b
      JOIN rooms r ON r.id = b.room_id
      JOIN room_types rt ON rt.id = r.room_type_id
     WHERE b.guests_count > rt.capacity;
    IF failed_checks <> 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A booking exceeds room capacity';
    END IF;

    SELECT COUNT(*) INTO failed_checks
      FROM bookings a
      JOIN bookings b ON b.room_id = a.room_id AND b.id > a.id
     WHERE a.status = 'confirmed' AND b.status = 'confirmed'
       AND a.check_in < b.check_out AND b.check_in < a.check_out;
    IF failed_checks <> 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Seed contains overlapping confirmed bookings';
    END IF;

    SELECT COUNT(*) INTO failed_checks
      FROM bookings b
      LEFT JOIN (
          SELECT booking_id, SUM(line_total) AS lines_total
            FROM booking_price_lines GROUP BY booking_id
      ) price_sums ON price_sums.booking_id = b.id
     WHERE price_sums.lines_total IS NULL OR price_sums.lines_total <> b.price_total;
    IF failed_checks <> 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Booking totals do not match price lines';
    END IF;

    SELECT COUNT(*) INTO failed_checks
      FROM bookings cancelled
      JOIN bookings confirmed ON confirmed.room_id = cancelled.room_id
     WHERE cancelled.status = 'cancelled'
       AND confirmed.status = 'confirmed'
       AND cancelled.check_in < confirmed.check_out
       AND confirmed.check_in < cancelled.check_out;
    IF failed_checks = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Expected a cancelled overlap fixture';
    END IF;

    SELECT 'booking foundation checks passed' AS result;
END//

DELIMITER ;

CALL assert_booking_foundation();
DROP PROCEDURE assert_booking_foundation;
