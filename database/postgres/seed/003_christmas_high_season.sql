-- PostgreSQL anonymized school fixture, ported from database/seed/003_christmas_high_season.sql
DO $seed$ DECLARE v_import_batch_id bigint; v_guest_id bigint; v_product_id bigint; BEGIN
UPDATE season_periods p SET end_month=12,end_day=19
FROM seasons s WHERE s.id=p.season_id AND s.code='low' AND p.start_month=11 AND p.start_day=1;
INSERT INTO season_periods(season_id,start_month,start_day,end_month,end_day)
SELECT id,12,20,12,31 FROM seasons WHERE code='high'
ON CONFLICT (season_id,start_month,start_day,end_month,end_day) DO UPDATE SET  end_day=EXCLUDED.end_day;
END $seed$;
DO $reset$ DECLARE r record; n bigint; BEGIN
 FOR r IN SELECT table_name,column_name FROM information_schema.columns WHERE table_schema='public' AND is_identity='YES' LOOP
  EXECUTE format('SELECT max(%I) FROM %I',r.column_name,r.table_name) INTO n;
  IF n IS NOT NULL THEN PERFORM setval(pg_get_serial_sequence(r.table_name,r.column_name),n,true); END IF;
 END LOOP;
END $reset$;
