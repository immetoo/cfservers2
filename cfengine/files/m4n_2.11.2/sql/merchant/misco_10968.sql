/* February 9 2011, Jan, ticket: #6747
Kan je shopkorting (12307) in het account van Misco (10968) toevoegen aan special deal 6225?

Kan je ook Scoot Media (4318) toevoegen aan special deal:6225 bij Misco 10968?
*/
UPDATE 
	lead 
SET 
	lead_program_id = 6225 
WHERE
	lead_program_id = 1928 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (12307, 10968);

/** 
* Ticket 1907: Misco (10968) heeft een staffel
*
* Minder dan 10 sales is de vergoeding 4 procent voor de affiliate (offid 1928)
* 10 of meer sales is de vergoeding 5 procent voor de affiliate (offid 2190)
* De verhouding exploitant adverteerder is gewoon 65/100
*/

UPDATE lead SET lead_program_id = 2190 WHERE 
	lead_program_id = 1928 AND 
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)	AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT affiliate_id FROM lead 
						WHERE lead_program_id IN (1928, 2190) AND
								status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
								click_created < '2011-01-01' AND
								payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
						GROUP BY affiliate_id HAVING count(id) >= 10);
						
