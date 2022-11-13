/* Staffel ticket #3720.  This is an echte staffel.
 * Andre Augusto Cesta - 25 August 2009.
 */ 
UPDATE 
    lead 
SET 
    lead_program_id = 3261
WHERE 
	lead_program_id = 3260 AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3260, 3261) AND 
				         status = 'ACCEPTED' AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 5);
 