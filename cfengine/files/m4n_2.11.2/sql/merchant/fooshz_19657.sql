/* February 24 2011, Jan, ticket: #6865
Zou jij off_id 6290 van account_id 19657 (Fooshz) aan affiliate_id 8880 (Fashionchick) willen koppelen?
*/

UPDATE
	lead
SET
	lead_program_id = 6290
WHERE
	lead_program_id = 4242 AND
	affiliate_id = 8880 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-02-22';