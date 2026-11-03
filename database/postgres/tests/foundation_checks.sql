-- Run only against the isolated, freshly seeded test database.
DO $$ BEGIN
 IF (SELECT count(*) FROM rooms WHERE active) <> 214 THEN RAISE EXCEPTION 'Expected 214 active rooms'; END IF;
 IF (SELECT count(*) FROM room_types) <> 8 THEN RAISE EXCEPTION 'Expected 8 room types'; END IF;
 IF (SELECT count(*) FROM seasons) <> 3 THEN RAISE EXCEPTION 'Expected 3 seasons'; END IF;
 IF (SELECT count(*) FROM customer_stay_records WHERE row_status='accepted') <> 1000 THEN RAISE EXCEPTION 'Expected 1000 source stays'; END IF;
 IF EXISTS(SELECT 1 FROM bookings a JOIN bookings b ON a.room_id=b.room_id AND a.id<b.id AND a.check_in<b.check_out AND a.check_out>b.check_in WHERE a.status='confirmed' AND b.status='confirmed') THEN RAISE EXCEPTION 'Overlapping confirmed seed bookings'; END IF;
END $$;
