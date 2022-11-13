/** 
* Staffels van bestel.nl  
* gebruikerID: 3370 
* 
**/
	
/**  Update Offer 1716 meer dan 10 leads **/
UPDATE 
    lead
SET 
    lead_program_id = 1716
WHERE 
    lead_program_id IN (1715,1716) AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE	
		                 lead_program_id IN (1715,1716) AND 
	                     status = 'ACCEPTED' AND 
	                     click_created < '2011-01-01' AND
	                     payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	                 GROUP BY 
	                     affiliate_id 
	                 HAVING 
	                     COUNT(id) >= 10
	                 );