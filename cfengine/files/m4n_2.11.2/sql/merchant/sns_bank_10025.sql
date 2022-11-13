/** budget hypotheek tussen 16 en 25 leads **/
UPDATE 
	lead 
SET 
	lead_program_id = 1681
WHERE  
	lead_program_id IN  (1680,1682) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1680,1681,1682) AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 16 AND 25
	);
	
/** budget hypotheek meer dan  25 leads **/
UPDATE 
	lead 
SET 
	lead_program_id = 1682
WHERE 
	lead_program_id IN  (1680,1681) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1680,1681,1682) AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
	GROUP BY affiliate_id HAVING COUNT(id) > 	25
	);
	
	
/** maxisparen tussen 16 en 25 leads **/
UPDATE 
	lead 
SET 
	lead_program_id = 1668
WHERE  
	lead_program_id IN (1667,1670) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1668,1667,1670) AND
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 16 AND 25
	);
	
/** maxisparen meer dan  25 leads **/
UPDATE 
	lead 
SET 
	lead_program_id = 1670
WHERE 
	lead_program_id IN  (1668,1667) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1668,1667,1670) AND
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
	GROUP BY affiliate_id HAVING COUNT(id) > 	25
	);

/** lenen 16-25 leads offerid 1977 **/
UPDATE 
	lead 
SET 
	lead_program_id = 1977
WHERE 
	lead_program_id IN  (1918, 1978) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1918,1977,1978) AND
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 16 AND 25 
	);		

/** lenen > 25 leads offerid 1978 **/
UPDATE 
	lead 
SET 
	lead_program_id = 1978
WHERE 
	lead_program_id IN  (1918,1977) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1918,1977,1978) AND
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
	GROUP BY affiliate_id HAVING COUNT(id) > 25 
	);				