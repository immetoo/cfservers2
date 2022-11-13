/* January 20th 2011, Jan, ticket: #6616
Adverteerder: 10853 wil een special deal voor affiliate: 11306 bij leadprogramma: 6175.
Pixel staat op 2204.
*/

UPDATE 
    lead 
SET 
    lead_program_id = 6175
WHERE 
	lead_program_id = 2204 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11306;