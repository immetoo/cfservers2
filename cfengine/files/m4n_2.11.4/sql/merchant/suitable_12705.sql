/** Ticket#2755: 21 April 2009, Andre: Echte Staffel. **/
/**  Ticket#2755: silver = 10-20 sales goes from lead program: 2583 to 2883 **/
UPDATE 
	lead 
SET 
	lead_program_id = 2883
WHERE
	lead_program_id =  2583 AND 
	created >= '2009-04-21' AND 
	click_created < '2011-01-01' AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id in (2583, 2883) AND 
			status = 'ACCEPTED' AND 
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	    GROUP BY 
	    	affiliate_id 
	   	HAVING 
	   		COUNT(id) >= 10 AND 
	   		COUNT(id) <= 20
	);

/** Ticket#2755: gold > 20 sales goes from lead programs: 2583, 2883 to 2884. **/
UPDATE 
	lead 
SET 
	lead_program_id = 2884
WHERE
	lead_program_id IN (2583, 2883) AND 
	created >= '2009-04-21' AND 
	click_created < '2011-01-01' AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (2583, 2883, 2884) AND status = 'ACCEPTED' AND 
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	    GROUP BY 
	    	affiliate_id 
	    HAVING COUNT(id) >= 21
	);
