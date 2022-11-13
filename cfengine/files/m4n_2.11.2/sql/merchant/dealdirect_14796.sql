-- August 11 2010, Update to #5480:
--Zou je de special deal LP 4593 die van toepassing is op Affiliate IML 7277 willen aanpassen 
--en baseren op de leadtijd (dus de staffel alleen in laten gaan wanneer er 35+ leads zijn behaald van 1e tot 30e/31e van elke maand).
/* July 6 2010, Dineke, Ticket #5480:
 * Requested by Patrick E.
 * Special deal
Dealdirect 14796 wil graag een aparte staffel aanhouden voor 1 affiliate IML 7277
Ze willen dat alle leads die per 1 juni zijn gezet laten meetellen in de staffel > 35 sales LeadProgramma 4593
*/
UPDATE
	lead
SET
	lead_program_id = 4593
WHERE 
	lead_program_id IN  (3264, 4306) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	affiliate_id = 7277 AND
	EXTRACT(month FROM created) = EXTRACT(month FROM NOW()- INTERVAL '7 hours') AND --only update leads that were set in the current month
	(SELECT COUNT(*) FROM lead WHERE	lead_program_id IN (3264, 4306, 4593) AND
										status = 'ACCEPTED' AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										EXTRACT(month FROM created) = EXTRACT(month FROM NOW() - INTERVAL '7 hours') AND --only count leads that were set in the current month
										affiliate_id = 7277
	) > 35;


-- July 6 2010, Dineke, Ticket #5480:
--Simyo staffel: 25 sales and up: 4091 --> 4303
UPDATE
	lead
SET
	lead_program_id = 4303
WHERE 
	lead_program_id IN  (4091) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (4091, 4303) AND
		status = 'ACCEPTED' AND
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY
		affiliate_id HAVING COUNT(id) >= 25
	);