/* June 19 2009, Dineke: Special deal for affiliate Leadmedia (9321): always gets lead program 3038 */
UPDATE
	lead
SET
	lead_program_id = 3038
WHERE 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id IN (9321) AND
	lead_program_id IN (1749);
	
/* November 16 2010, Dineke, ticket #6308:
Special deal, requested by Fleur:
Affiliate hidde (22433) krijgt standaard de hogere staffel

1749 à 2545

Startdatum: 1-11-1010
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 2545
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 22433 AND
	lead_program_id = 1749 AND
	created > '2010-11-01';
	
/* Special Deal for affiliate Midsol (#8106) - Always gets lead_program_id 2545 */
/* June 11 2009, Dineke:
	Added affiliate Dinea (12520) to this deal, starting June the 5th */
UPDATE
	lead
SET
	lead_program_id = 2545
WHERE 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id IN (8106, 12520) AND
	lead_program_id IN (1749);
	