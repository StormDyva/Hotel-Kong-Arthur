-- PDF: summer AND Christmas are high season. Exact Christmas dates are a project assumption.
-- Recurring 20–31 December; do not rewrite historical booking price snapshots.
UPDATE season_periods p JOIN seasons s ON s.id=p.season_id
SET p.end_month=12,p.end_day=19
WHERE s.code='low' AND p.start_month=11 AND p.start_day=1;
INSERT INTO season_periods(season_id,start_month,start_day,end_month,end_day)
SELECT id,12,20,12,31 FROM seasons WHERE code='high'
ON DUPLICATE KEY UPDATE end_day=VALUES(end_day);
