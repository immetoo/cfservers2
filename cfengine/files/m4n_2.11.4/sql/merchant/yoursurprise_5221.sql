/* June 24 2010, Jan, ticket: #5410
Requested by: Liesbeth
Leads with a 'Belevenis' as description3 should be moved to lead program 4549, starting May 24th.
*/
UPDATE 
    lead
SET 
    lead_program_id = 4549
WHERE 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2272, 2341, 2342) AND	
	description3 = 'Belevenis';
	
/*
	Yoursuprise 5221

	Offerid 2342 	 > 20 orders per maande 15% vergoeding 	15.0 % 	 23.07692 %
	Offerid 2341 	10-20 orders per maand 12,5% vergoeding 12.5 % 	19.230768 %
	Offerid 2272 	0-10 orders per maand, 10% vergoeding 	10.0 % 	15.38461 % 
*/


/** Offerid 2341 **/
UPDATE 
    lead
SET 
    lead_program_id = 2341
WHERE 
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2272, 2342) AND	
	click_created <= '2011-01-01' AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE
				         status = 'ACCEPTED' AND 
				         click_created <= '2011-01-01' AND
				         lead_program_id IN (2272,2341,2342)  
				     GROUP BY 
				         affiliate_id 
				     HAVING 
				     	COUNT(id) BETWEEN 10 AND 20 
				     );

/** Offerid 2342 **/
UPDATE 
    lead
SET 
    lead_program_id = 2342
WHERE 
    status = 'ACCEPTED' AND 
    click_created < '2011-01-01' AND
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2272, 2341) AND	
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE
				         status = 'ACCEPTED' AND 
				         click_created < '2011-01-01' AND
				         lead_program_id IN (2272,2341,2342)  
				     GROUP BY 
				         affiliate_id 
				     HAVING 
				     	COUNT(id) > 20 
				     );