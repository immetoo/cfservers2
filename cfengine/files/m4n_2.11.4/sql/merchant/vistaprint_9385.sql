/* April 16 2010, Dineke: requested by Tim:
 * Echte Staffel vistaprint
 */
--25 up to 49 sales: 1544 --> 1545
UPDATE
	lead
SET
	lead_program_id = 1545
WHERE
	lead_program_id = 1544 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT affiliate_id FROM lead 
						WHERE
							lead_program_id IN (1544, 1545, 1546) AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
							click_created < '2011-01-01' AND
							status = 'ACCEPTED'
						GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 25 AND 49
					);
					
--25 up to 49 sales: 1544, 1545 --> 1546
UPDATE
	lead
SET
	lead_program_id = 1546
WHERE
	lead_program_id IN (1544, 1545) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT affiliate_id FROM lead 
						WHERE
							lead_program_id IN (1544, 1545, 1546) AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
							click_created < '2011-01-01' AND
							status = 'ACCEPTED'
						GROUP BY affiliate_id HAVING COUNT(id) >= 50
					);