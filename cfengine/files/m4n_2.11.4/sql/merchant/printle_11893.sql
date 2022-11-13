/**
 * Ticket #4066.  Echte staffel.
 * Andre Cesta.  15th Oct 2009.
 */ 
UPDATE 
    lead 
SET 
    lead_program_id = 3461
WHERE 
	lead_program_id = 2263 AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (2263, 3461, 3462) AND 
				         status = 'ACCEPTED' AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 20 AND 49);

UPDATE 
    lead 
SET 
    lead_program_id = 3462
WHERE 
	lead_program_id IN (2263, 3461) AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (2263, 3461, 3462) AND 
				         status = 'ACCEPTED' AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 50);
			         