
/** Ticket 4192. Easyswitch echte staffel. */
UPDATE 
    lead 
SET 
    lead_program_id = 3534
WHERE 
	lead_program_id IN (3507, 3536) AND
	status = 'ACCEPTED' AND
	created > '2009-11-04' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3507, 3534, 3536) AND 
				         status = 'ACCEPTED' AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 25);

UPDATE 
    lead 
SET 
    lead_program_id = 3536
WHERE 
	lead_program_id IN (3507, 3534) AND
	status = 'ACCEPTED' AND
	created > '2009-11-04' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3507, 3534, 3536) AND 
				         status = 'ACCEPTED' AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) > 25);
