-- Runs after schema/seeds in the test profile and after demo-init in a fresh runtime DB.
DO $$
DECLARE
 bar_batch_count bigint;
 review_batch_count bigint;
 eligible_reviews bigint;
 actual_reviews bigint;
BEGIN
 IF (SELECT count(*) FROM rooms WHERE active) <> 214 THEN RAISE EXCEPTION 'Expected 214 active rooms'; END IF;
 IF (SELECT count(*) FROM room_types) <> 8 THEN RAISE EXCEPTION 'Expected 8 room types'; END IF;
 IF (SELECT count(*) FROM seasons) <> 3 THEN RAISE EXCEPTION 'Expected 3 seasons'; END IF;
 IF (SELECT count(*) FROM customer_stay_records WHERE row_status='accepted') <> 1000 THEN RAISE EXCEPTION 'Expected 1000 source stays'; END IF;
 IF EXISTS(SELECT 1 FROM bookings a JOIN bookings b ON a.room_id=b.room_id AND a.id<b.id AND a.check_in<b.check_out AND a.check_out>b.check_in WHERE a.status='confirmed' AND b.status='confirmed') THEN RAISE EXCEPTION 'Overlapping confirmed seed bookings'; END IF;
 IF EXISTS(SELECT 1 FROM bookings b JOIN rooms r ON r.id=b.room_id JOIN room_types t ON t.id=r.room_type_id WHERE b.guests_count>t.capacity) THEN RAISE EXCEPTION 'Booking exceeds room capacity'; END IF;
 IF EXISTS(SELECT 1 FROM pg_constraint WHERE connamespace='public'::regnamespace AND contype IN ('f','c') AND NOT convalidated) THEN RAISE EXCEPTION 'Unvalidated foreign-key or check constraint'; END IF;

 SELECT row_count INTO bar_batch_count FROM import_batches
  WHERE source_system='school-project' AND file_name='realistic_bar_sales_2026_v1'
    AND file_sha256='c617293e28084a20c59468964713c237ed37c5fb0641f917a3c380b758fe08b5';
 IF bar_batch_count IS NOT NULL THEN
  IF (SELECT COUNT(*) FROM bar_sales WHERE created_at=TIMESTAMP '2026-11-04 00:00:00')<>bar_batch_count THEN
   RAISE EXCEPTION 'Generated bar-sales row count does not match import marker';
  END IF;
  IF EXISTS(
   SELECT a.product_id FROM customer_bar_sales_aggregates a
   LEFT JOIN (SELECT product_id,SUM(quantity) quantity FROM bar_sales
      WHERE created_at=TIMESTAMP '2026-11-04 00:00:00' GROUP BY product_id) s USING(product_id)
   WHERE a.row_status='accepted' AND COALESCE(s.quantity,0)<>a.units_sold
  ) OR EXISTS(
   SELECT s.product_id FROM (SELECT product_id FROM bar_sales
      WHERE created_at=TIMESTAMP '2026-11-04 00:00:00' GROUP BY product_id) s
   LEFT JOIN customer_bar_sales_aggregates a ON a.product_id=s.product_id AND a.row_status='accepted'
   WHERE a.product_id IS NULL
  ) THEN RAISE EXCEPTION 'Generated bar quantity does not reconcile to accepted aggregates'; END IF;
  IF EXISTS(SELECT 1 FROM bar_sales s JOIN bar_products p ON p.id=s.product_id
      WHERE s.created_at=TIMESTAMP '2026-11-04 00:00:00'
        AND (s.unit_price<>p.price OR s.currency<>'DKK' OR s.quantity>6
          OR timezone('Europe/Copenhagen',s.sold_at AT TIME ZONE 'UTC')::date<DATE '2026-01-01'
          OR timezone('Europe/Copenhagen',s.sold_at AT TIME ZONE 'UTC')::date>=DATE '2027-01-01'))
   THEN RAISE EXCEPTION 'Generated bar sale violates date, price, currency, or quantity rules'; END IF;
  IF (SELECT COUNT(*) FILTER (WHERE quantity<=2)::numeric/COUNT(*) FROM bar_sales
      WHERE created_at=TIMESTAMP '2026-11-04 00:00:00')<0.90 THEN
   RAISE EXCEPTION 'Expected quantities 1-2 to be typical';
  END IF;
  IF (SELECT SUM(quantity) FILTER (WHERE employee_name='Helene Christine')::numeric/SUM(quantity)
      FROM bar_sales WHERE created_at=TIMESTAMP '2026-11-04 00:00:00') NOT BETWEEN 0.30 AND 0.50 THEN
   RAISE EXCEPTION 'Helene Christine should be a central employee';
  END IF;
  IF (SELECT COUNT(DISTINCT employee_name) FROM bar_sales
      WHERE created_at=TIMESTAMP '2026-11-04 00:00:00') NOT BETWEEN 3 AND 5 THEN
   RAISE EXCEPTION 'Expected 3-5 fictional bar employees';
  END IF;
  IF NOT EXISTS(SELECT 1 FROM bar_sales WHERE created_at=TIMESTAMP '2026-11-04 00:00:00'
      AND employee_name='Helene Christine') THEN
   RAISE EXCEPTION 'Helene Christine must remain central to demo bar sales';
  END IF;
  IF EXISTS(SELECT 1 FROM bar_sales s JOIN bar_products p ON p.id=s.product_id
      WHERE s.created_at=TIMESTAMP '2026-11-04 00:00:00' AND
       ((p.category='coffee' AND EXTRACT(HOUR FROM timezone('Europe/Copenhagen',s.sold_at AT TIME ZONE 'UTC')) NOT IN (7,8,9,10,14,15,16))
        OR (p.category='cocktail' AND EXTRACT(HOUR FROM timezone('Europe/Copenhagen',s.sold_at AT TIME ZONE 'UTC')) NOT IN (0,1,17,18,19,20,21,22,23))))
   THEN RAISE EXCEPTION 'Drink sale time does not match its category';
  END IF;
  IF (SELECT corr(s.quantity::double precision,COALESCE(o.guest_nights,0)::double precision)
      FROM (SELECT timezone('Europe/Copenhagen',sold_at AT TIME ZONE 'UTC')::date AS local_date,
                   SUM(quantity) quantity FROM bar_sales
            WHERE created_at=TIMESTAMP '2026-11-04 00:00:00' GROUP BY 1) s
      LEFT JOIN (SELECT l.night_date AS local_date,SUM(b.guests_count) guest_nights
                 FROM booking_price_lines l JOIN bookings b ON b.id=l.booking_id
                 WHERE b.status='confirmed' GROUP BY l.night_date) o ON o.local_date=s.local_date)<0 THEN
   RAISE EXCEPTION 'Bar sales must rise with occupied guest nights';
  END IF;
  IF (SELECT AVG(units) FILTER (WHERE EXTRACT(ISODOW FROM local_date) IN (6,7))
      FROM (SELECT timezone('Europe/Copenhagen',sold_at AT TIME ZONE 'UTC')::date AS local_date,
                   SUM(quantity) units FROM bar_sales
            WHERE created_at=TIMESTAMP '2026-11-04 00:00:00' GROUP BY 1) d)
     <= (SELECT AVG(units) FILTER (WHERE EXTRACT(ISODOW FROM local_date) NOT IN (6,7))
      FROM (SELECT timezone('Europe/Copenhagen',sold_at AT TIME ZONE 'UTC')::date AS local_date,
                   SUM(quantity) units FROM bar_sales
            WHERE created_at=TIMESTAMP '2026-11-04 00:00:00' GROUP BY 1) d) THEN
   RAISE EXCEPTION 'Expected higher average bar volume on weekends';
  END IF;
  IF (SELECT AVG(units) FILTER (WHERE local_date BETWEEN DATE '2026-06-01' AND DATE '2026-08-31'
                                          OR local_date BETWEEN DATE '2026-12-20' AND DATE '2026-12-31')
      FROM (SELECT timezone('Europe/Copenhagen',sold_at AT TIME ZONE 'UTC')::date AS local_date,
                   SUM(quantity) units FROM bar_sales
            WHERE created_at=TIMESTAMP '2026-11-04 00:00:00' GROUP BY 1) d)
     <= (SELECT AVG(units) FILTER (WHERE NOT (local_date BETWEEN DATE '2026-06-01' AND DATE '2026-08-31'
                                          OR local_date BETWEEN DATE '2026-12-20' AND DATE '2026-12-31'))
      FROM (SELECT timezone('Europe/Copenhagen',sold_at AT TIME ZONE 'UTC')::date AS local_date,
                   SUM(quantity) units FROM bar_sales
            WHERE created_at=TIMESTAMP '2026-11-04 00:00:00' GROUP BY 1) d) THEN
   RAISE EXCEPTION 'Expected higher average bar volume in high season';
  END IF;
 END IF;

 SELECT row_count INTO review_batch_count FROM import_batches
  WHERE source_system='school-project' AND file_name='realistic_booking_reviews_2026_v1'
    AND file_sha256='d68addf62f6251390dfef5211505e266376109d33ad444d10746e5c9cf88d688';
 IF review_batch_count IS NOT NULL THEN
  SELECT COUNT(*) INTO eligible_reviews FROM bookings
   WHERE status='confirmed' AND check_out>=DATE '2026-01-01'
     AND check_out<DATE '2026-11-04';
  SELECT COUNT(*) INTO actual_reviews FROM booking_reviews v JOIN bookings b ON b.id=v.booking_id
   WHERE b.status='confirmed' AND b.check_out>=DATE '2026-01-01'
     AND b.check_out<DATE '2026-11-04';
  IF actual_reviews<>review_batch_count OR eligible_reviews=0
     OR actual_reviews::numeric/eligible_reviews NOT BETWEEN 0.30 AND 0.50 THEN
   RAISE EXCEPTION 'Generated review count or response rate is outside expected range';
  END IF;
  IF EXISTS(SELECT 1 FROM booking_reviews v JOIN bookings b ON b.id=v.booking_id
      WHERE b.status<>'confirmed' OR b.check_out>=DATE '2026-11-04'
        OR v.rating NOT BETWEEN 1 AND 5
        OR timezone('Europe/Copenhagen',v.created_at AT TIME ZONE 'UTC')::date<=b.check_out
        OR timezone('Europe/Copenhagen',v.created_at AT TIME ZONE 'UTC')::date>DATE '2026-11-04')
   THEN RAISE EXCEPTION 'Generated review is cancelled, not completed, invalid, or outside its response window';
  END IF;
  IF (SELECT COUNT(*) FILTER (WHERE rating>=4)::numeric/COUNT(*) FROM booking_reviews
      WHERE created_at IS NOT NULL)<0.65 THEN
   RAISE EXCEPTION 'Expected positive ratings to be the majority';
  END IF;
 END IF;
END $$;
