/* Dineke, April 24 2009:
	kun je voor mij het affiliate id 9181 kunnen koppelen aan het offid nr 2697 kunnen koppelen bij Modern 8126 vanaf vandaag?
*/
UPDATE lead
	SET lead_program_id = 2697
	WHERE 	lead_program_id = 1262 AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			affiliate_id = 9181;	
			
/* March 22 2011, Jan, ticket: #7076
Hierbij een aanvraag voor special deal van Modern 8126.

Alle sales van affiliate 98hulse 19895 moeten op lpid 4088 worden gezet.

Per vandaag aub.
*/
UPDATE 
	lead
SET 
	lead_program_id = 4088
WHERE
	lead_program_id = 1262 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 19895 AND
	created >= '2011-03-21';	
