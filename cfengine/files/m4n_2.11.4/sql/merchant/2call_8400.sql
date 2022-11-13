/* November 2 2009, Dineke:
Reported by Jonas:
Dineke zou je kunnen kijken of 2Call (8400) al een staffel heeft?
Anders graag een staffel aanmaken 5 of meer leads op 1363 zetten (30 euro affiliate)
Ik zal dan de naam van de staffel aanpassen.
Zou je kunnen zorgen dat Martijn van Portable gear (id; 578 )automatisch in de hoogste staffel komt  
*/

UPDATE
	lead
SET	
	lead_program_id = 3514
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8400 AND id NOT IN (1320, 3514)) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 578;
	
UPDATE 
	lead 
SET 
	lead_program_id = 3514
WHERE 
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8400 AND id NOT IN (1320, 3514)) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8400 AND id != 1320) AND
		status = 'ACCEPTED' AND
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
	GROUP BY affiliate_id HAVING COUNT(id) >=5
	);