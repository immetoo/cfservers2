/** Ticket#2649: 06 March 2008, Andre: Echte Staffel. **/
/**  Ticket#2649: silver >= 5 sales goes from lead program: 2587 to 2735 **/
UPDATE 
	lead 
SET 
	lead_program_id = 2735
WHERE
	lead_program_id IN (2736, 2587) AND
	status = 'ACCEPTED' AND 	
	click_created < '2011-01-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE
			status = 'ACCEPTED' AND
			lead_program_id in (2587, 2735) AND 		  
			created > '2009-03-06' AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 5 AND 14
	);
	
/**  Ticket#2649: silver >= 15 sales goes from lead programs: 2587, 2735 to 2736 **/
UPDATE 
	lead 
SET 
	lead_program_id = 2736
WHERE
	lead_program_id IN (2587, 2735) AND
	status = 'ACCEPTED' AND 	
	click_created < '2011-01-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE
			status = 'ACCEPTED' AND
			lead_program_id in (2587, 2735, 2736) AND 		  
			created > '2009-03-06' AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 15
	);