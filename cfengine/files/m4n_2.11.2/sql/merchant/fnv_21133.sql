/* July 30th 2010, Jan, ticket: #5611
Zou jij ervoor kunnen zorgen dat Money Miljonair en Euroclix terecht komen in de special deal van FNV bondgenoten?
Alle leads vanaf morgen moeten in de special deal terecht komen.

Euroclix: 105
Money Miljonair: 307
FNV: 21133
Special deal: 4661
*/

UPDATE 
    lead 
SET 
    lead_program_id = 4661
WHERE 
	lead_program_id = 4607 AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (105, 307) AND
	created >= '2010-07-30';
	
/* September 20 2010, Dineke, #5926:
Requested by Leonne:
Hey Dineke, Zou je voor mij een staffel kunnen aanmaken? Jiggy (11524) die mailt FNV (21133) en krijgt een verhoogde vergoeding. 
Kan je alle clicks & leads vanaf 14 september van het leadprogramma 4607 naar 4661 sluizen? Dank je!
*/
UPDATE
	lead
SET
	lead_program_id = 4661
WHERE
	lead_program_id = 4607 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11524 AND
	created > '2010-09-14';