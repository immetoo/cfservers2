/* Januray 24 2011, Dineke, #
 * Requested by Patrick:
 * Special deal: Leadprogramma 6188. Zou jij alle leads die door Martijn 578 worden gezet op dit leadprogramma willen zetten. 
 */
UPDATE
	lead
SET
	lead_program_id = 6188
WHERE
	lead_program_id IN (SELECT lead_programs(25285)) AND lead_program_id != 6288 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 578;
