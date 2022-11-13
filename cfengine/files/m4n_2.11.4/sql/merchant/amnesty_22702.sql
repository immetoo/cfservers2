/* October 18th 2010, Jan, ticket: #6052
Kun jij ervoor zorgen dat vanaf maandag de leads van Jiggy (11524) op de special deal (4868) van Amnesty (22072) worden gezet?
*/

UPDATE 
    lead 
SET 
    lead_program_id = 4868
WHERE 
	lead_program_id = 4793 AND
	created >= '2010-10-18' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11524;