/** Ticket#2657: 11 March 2008, Andre: Echte Staffel. **/
/**  Ticket#2657: >= 10 sales per maand gets 10% comission (goes from lpid 2738 to 2749). **/
UPDATE lead 
	SET lead_program_id = 2749
	WHERE
		lead_program_id =  2738 AND
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
		click_created < '2011-01-01' AND
		affiliate_id IN 
		(SELECT	affiliate_id
			FROM lead
			WHERE
				status = 'ACCEPTED' AND
				lead_program_id in (2738, 2749) AND 	
				click_created < '2011-01-01' AND
				payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	    	GROUP BY affiliate_id HAVING COUNT(id) >= 10
		);
/** End Ticket#2657. */