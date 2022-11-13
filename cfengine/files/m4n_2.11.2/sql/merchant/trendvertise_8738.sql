/**
* Staffel Trendvertise (8738)
*/

-- 6 up to 9 sales? --> 2859
 
 UPDATE lead
 	SET lead_program_id = 2859
 	WHERE status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (2536, 2860) AND
 	click_created < '2011-01-01' AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (2536, 2859, 2860) AND 
 												status = 'ACCEPTED' AND
 												click_created < '2011-01-01' AND
 												payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 6 AND 9);
 				
-- 10 sales and up? --> 2860
 
 UPDATE lead
 	SET lead_program_id = 2860
 	WHERE status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (2536, 2859) AND
 	click_created < '2011-01-01' AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (2536, 2859, 2860) AND 
 												status = 'ACCEPTED' AND
 												click_created < '2011-01-01' AND
 												payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) >= 10);


-- June 9 2009, Dineke: Midsol (8106) always gets the highest staffel (lead program id 2860)
 UPDATE lead
 	SET lead_program_id = 2860
 	WHERE	status = 'ACCEPTED' AND
 			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 			lead_program_id IN (2536, 2859) AND
 			affiliate_id = 8106;
 