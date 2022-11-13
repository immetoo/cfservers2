/* August 2 2010, Jan, ticket: #5629
Zou jij het lp 4673 van Goeiemode (id 17274) kunnen koppelen aan affiliate Jorrit1612 (id 13152)
*/

UPDATE 
    lead 
SET 
    lead_program_id = 4673
WHERE 
	lead_program_id = 3701 AND
	affiliate_id = 13152 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);