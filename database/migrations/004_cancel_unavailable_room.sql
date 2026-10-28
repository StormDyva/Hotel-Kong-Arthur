-- Cancellation must release a stay even after room maintenance starts.
DROP TRIGGER IF EXISTS bookings_capacity_before_update;
DELIMITER //
CREATE TRIGGER bookings_capacity_before_update
BEFORE UPDATE ON bookings
FOR EACH ROW
BEGIN
    DECLARE room_capacity TINYINT UNSIGNED;

    IF NEW.status <> 'cancelled' THEN
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
    END IF;
END//
DELIMITER ;
