--September 21 2010, Dineke, requested by Patrick E.: reject all leads that were set by not-accepted affiliates
--(this merchant used to be public and is now tailormade, that's why some leads are set by not-accepted affiliates
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	lead_program_id IN (SELECT lead_programs(5317)) AND
	affiliate_id NOT IN (SELECT affiliate_id FROM affiliate_merchant WHERE merchant_id = 5317 AND status = 1) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > now() - interval '2 days'; --only reject leads until 2 days old, otherwise rejecting an affiliate today will reject all older leads too
 