/* 
 * 2009-08-24 Ticket 3715
 * Andre Cesta
 * Ecthe staffel freshlabelz
 * Updated due to email from Alex.
 * 
 * Update September 29 2010, Jan: Fixed silly bugs in staffel
 */
UPDATE
    lead
SET
    lead_program_id = 3244
WHERE
	lead_program_id = 3245 AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2009-09-27' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3245, 3244, 3243) AND 
				         status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 20);

/* Updated due to email from Alex. */
UPDATE
    lead
SET
    lead_program_id = 3243
WHERE
	lead_program_id IN (3245, 3244) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2009-09-27' AND	
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT
	                     affiliate_id
			         FROM
			             lead
			         WHERE
			             lead_program_id IN (3245, 3244, 3243) AND 
				         status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 21);

