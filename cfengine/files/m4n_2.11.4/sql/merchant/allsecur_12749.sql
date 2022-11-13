/* January 14 2010, Dineke:
Requested by Bart:
Reject all leads for lead_program 3672. No end date given.
*/

UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 3672;
	
