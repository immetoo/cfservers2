/* 30 January 2009, Dineke:
Staffel + special deal for postordershop
*/

/* Special deal for affiliate Lysander: always gets 2606. Change for ticket #4191 */
UPDATE
	lead
SET
	lead_program_id = 2606
WHERE
 	lead_program_id = 2359 AND 
 	affiliate_id = 10929  AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/**
 * Ticket #4190.  Echte staffel change.
 * Andre Augusto Cesta.  2009-10-04.
 */
UPDATE 
	lead 
SET 
	lead_program_id = 2606
WHERE 
	lead_program_id = 2359 AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (2359, 2606) AND 
				         status = 'ACCEPTED' AND 
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 10
			        );