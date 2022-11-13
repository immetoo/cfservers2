/*
* in response to tick #1956 which is not the birthyear of Madonna.
*/

/* Special deal for user Flavourites (7957) */
UPDATE lead 
	SET lead_program_id = 2152
	WHERE lead_program_id = 942 AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		affiliate_id = 7957;

/* Normal quantity-based bonus */
UPDATE lead 
	SET lead_program_id = 2152
	WHERE lead_program_id = 942 AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		affiliate_id IN (SELECT affiliate_id
							FROM lead
							WHERE lead_program_id IN (942, 2152) AND
								status = 'ACCEPTED' AND
								payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
							GROUP BY affiliate_id HAVING COUNT(id)  > 15
			);
