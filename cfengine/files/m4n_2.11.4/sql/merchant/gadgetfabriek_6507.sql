
/**
* February 2, 2009, Dineke:

Staffel Gadgetfabriek (Id 6507):
1205      Bij meer dan 10 verkopen per maand 15%
1204     Bij meer dan 3 verkopen per maand 12,5%     
1057     10% commisie
*/

/** Lead program id 1204 **/
UPDATE lead 
SET lead_program_id = 1204
WHERE
	lead_program_id IN (1057, 1205) AND
	status = 'ACCEPTED'	AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (1057, 1204, 1205) AND 
			status = 'ACCEPTED' AND 
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 4 AND 10
		);
	
/** Lead program id 1205 **/
UPDATE lead 
SET lead_program_id = 1205
WHERE
	lead_program_id IN (1057, 1204) AND
	status = 'ACCEPTED'	AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		click_created < '2011-01-01' AND
	affiliate_id IN 
		(SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (1057, 1204, 1205) AND 
			status = 'ACCEPTED' AND 
				click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY affiliate_id HAVING COUNT(id) > 10
		);

/** February 9, 2009, Dineke: Special deal Midsol (8106): always gets 1205 */
UPDATE lead
SET lead_program_id = 1205
WHERE lead_program_id IN (1057, 1204) AND
	status = 'ACCEPTED' AND
	created > '2009-02-09' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 8106;