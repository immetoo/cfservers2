/* March 25 2010, Dineke:
Requested by Jonas:
Dineke zou je alle leads die binnen komen en binnen zijn gekomen via affiliate DSG (12524)op laten staan willen zetten?
*/

UPDATE
	lead
SET
	status = 'ON_HOLD'
WHERE
	affiliate_id = 12524 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('TO_BE_APPROVED');
