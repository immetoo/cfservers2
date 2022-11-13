-- November 16 2010, Dineke, requested by Patrick Emmen:
--This merchant has stopped (a while ago) so reject all leads that may still be set
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 1912) AND
	status NOT IN ('REJECTED', 'BLOCKED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-09-01';