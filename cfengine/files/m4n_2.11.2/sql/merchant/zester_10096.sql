/* November 30 2010, Jan, ticket: #6377
Affiliate Marspc (13585) staat in de lijst van geblokkeerde websites van Zester (10096). Toch worden er nog leads en clicks geregistreerd van dit account.

Kunnen we zorgen dat er helemaal niks meer binnenkomt via dit account?
*/
UPDATE
	lead
SET
	status = 'REJECTED' 
WHERE 
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 10096) AND
	affiliate_id = 13585 AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);