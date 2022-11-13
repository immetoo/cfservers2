/** Perrysport staffel:
* 4.2 %: 0 t/m 10 sales		936
* 4.9 %: 11 t/m 20 sales 	2386
* 6.3 %: 21 sales of meer   2387
*
* it starts from 12 november 2008
*/

/* 11 up to 20 sales */
UPDATE 
	lead 
SET 
	lead_program_id = 2386
WHERE 
	lead_program_id IN  (936, 2387) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (936, 2386, 2387) AND status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
	GROUP BY affiliate_id HAVING COUNT(id) > 10 	
	);
	
/** 21 sales and up **/
UPDATE 
	lead 
SET 
	lead_program_id = 2387
WHERE 
	lead_program_id IN  (936, 2386) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (936, 2386, 2387) AND status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
	GROUP BY affiliate_id HAVING COUNT(id) > 20  	
	);