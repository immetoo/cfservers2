/* March 7 2011, Jan, ticket: #6943
Kan jij in het programma Suitableshop (12705) een special deal aanmaken voor Fashionsites (6059).

Lpid=6315
*/

UPDATE
	lead
SET
	lead_program_id = 6315
WHERE
	lead_program_id = 2583 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6059;

