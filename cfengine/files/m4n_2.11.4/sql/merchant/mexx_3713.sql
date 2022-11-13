/** mexx 5 up to 14 leads **/
UPDATE 
	lead 
SET 
	lead_program_id = 1438
WHERE 
	lead_program_id IN  (709,1439) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)	AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)	AND
		click_created < '2011-01-01' AND
		lead_program_id IN (709,1438,1439) AND status = 'ACCEPTED' 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 5 AND 14
	);
	
/** 15 leads and up **/
UPDATE 
	lead 
SET 
	lead_program_id = 1439
WHERE 
	lead_program_id IN (709,1438) AND
	status = 'ACCEPTED' 		AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)	AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)	AND
		click_created < '2011-01-01' AND
		lead_program_id IN (709,1438,1439) AND status = 'ACCEPTED' 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 	15
	);
	
