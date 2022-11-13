/* May 11 2010, Dineke:
 * reported by Patrick Emmen
 * special deal: Moneymiljonair (307) always gets the staffel 
 */
UPDATE 
    lead 
SET 
    lead_program_id = 3427
WHERE 
	lead_program_id = 3327 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 307;
	
/** 
 * Echte staffel.  Ticket #4020.
 * Andre Cesta - 7th-Oct-2009. 
 */
UPDATE 
    lead 
SET 
    lead_program_id = 3427
WHERE 
	lead_program_id = 3327 AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3327, 3427) AND 
				         status = 'ACCEPTED' AND 
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 20);
 