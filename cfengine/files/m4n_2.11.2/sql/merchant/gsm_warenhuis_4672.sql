/** 
 * Echte staffel.  Ticket #4019.
 * Andre Cesta - 7th-Oct-2009. 
 */
UPDATE 
    lead 
SET 
    lead_program_id = 3426
WHERE 
	lead_program_id in (851, 877) AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created between '2009-10-06' and '2012-10-06' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (851, 877, 3426) AND 
				         status = 'ACCEPTED' AND 
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 20);
 
	