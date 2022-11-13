/* January 2011, Jan, ticket: #6684
Reported by: Dianne

Zou jij affiliate Ciao-shopping (ID 7905) kunnen hangen aan lpid 6209 van adverteerder Assem (ID 13832).
Ingang: 01-02-2011 tot 01-05-2011.
*/
UPDATE
	lead
SET
	lead_program_id = 6209
WHERE
	lead_program_id = 2984 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 7905 AND
	created >= '2011-02-01' AND 
	created < '2011-05-01';
