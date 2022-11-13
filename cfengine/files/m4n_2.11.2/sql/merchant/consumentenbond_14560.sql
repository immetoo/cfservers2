
UPDATE 
    lead 
SET 
    lead_program_id = 3210
WHERE 
	lead_program_id = 3209 AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3209, 3210) AND 
				         status = 'ACCEPTED' AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 11);
