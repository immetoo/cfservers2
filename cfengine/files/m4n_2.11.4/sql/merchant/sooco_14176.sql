/**
 * Staffel Sooco. #3794
 * Andre' Cesta.
 * 2009-09-10.
 */
UPDATE 
    lead 
SET 
    lead_program_id = 3300
WHERE 
	lead_program_id = 3207 AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
	created >= '2009-09-10' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3300, 3207) AND
				         status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 11);

/* May 26 2010, Jan, ticket: #5164 
Requested by Liesbeth:
Verder, zou jij voor alle sales die binnenkomen met prijs en vergoeding = 0 + beschrijving 1 is leeg, de orderwaarde EUR 78.92 in kunnen vullen?
*/
UPDATE
	lead
SET
	price = 78.92
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 14176) AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	price = 0 AND
	reward = 0;