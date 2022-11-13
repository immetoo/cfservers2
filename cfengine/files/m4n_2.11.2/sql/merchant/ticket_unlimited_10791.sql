/**
* Staffel Ticket Unlimited (10791)
*/

/* 
10 sales and up for lead_program_id 1885? --> Lead program id 2547
*/
 
 UPDATE lead
 	SET lead_program_id = 2547
 	WHERE status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 1885 AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (2547, 1885) AND 
 												status = 'ACCEPTED' AND
 												payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) >= 10 );
 				
  
/* Special Deal for affiliate Midsol (#8106) - Lead program id 2547 */
UPDATE lead
	SET lead_program_id = 2547
	WHERE status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 1885 AND
	affiliate_id = 8106;
	