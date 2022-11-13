/**
 * Ticket #3659, Echte staffel Zwitserleven.
 * Andre.Cesta@m4n.nl  2009-08-10.
 **/
UPDATE 
    lead 
SET 
    lead_program_id = 3211
WHERE 
    lead_program_id = 3187 AND 
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2009-08-10' AND '2012-08-10' AND 	
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3187, 3211) AND 
				         status = 'ACCEPTED' AND
				         created BETWEEN '2009-08-10' AND '2012-08-10' AND 				          
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) > 5);


UPDATE 
    lead 
SET 
    lead_program_id = 3215
WHERE 
    lead_program_id = 3086 AND 
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2009-08-10' AND '2012-08-10' AND 	
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3086, 3215) AND 
				         status = 'ACCEPTED' AND
				         created BETWEEN '2009-08-10' AND '2012-08-10' AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) > 5);

