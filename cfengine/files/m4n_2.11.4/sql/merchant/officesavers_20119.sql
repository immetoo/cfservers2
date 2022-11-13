/* August 4 2010, Jan, ticket: #5643 
Requested by Liesbeth
Automatically approve all leads that are older than 2 weeks that are still on status 'TO_BE_APPROVED'
*/
UPDATE
	lead
SET
	status = 'ACCEPTED'
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 20119) AND
	status = 'TO_BE_APPROVED' AND
	created + interval '14 DAY' < now() AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);