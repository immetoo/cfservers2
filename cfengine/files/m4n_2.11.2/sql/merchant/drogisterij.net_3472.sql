/* January 17 2011, Jan, ticket: #6562
Zou jij de volgende special deal willen aanmaken.

Wil jij deze affiliates:
- Actiepag (ID 3571)
- Imbull (ID 11033)
hangen aan lpid 6157 van adverteerder Drogisterij.net (ID 3472)

Per vandaag, 11-01-2011. 
*/

UPDATE 
    lead 
SET 
    lead_program_id = 6157
WHERE 
	lead_program_id IN (686, 3381, 3382, 3896) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (3571, 11033) AND
	created >= '2011-01-11';

/* January 11 2011, Jan, ticket: #6522
Kan je in het account van Drogisterij.net (3472), shopkorting (12307) koppelen aan lpid 6157

Zij krijgen voor elke order een vast percentage commissie. Kan je dit met terugwerkende kracht vanaf 1 januari invoeren?
*/

UPDATE 
    lead 
SET 
    lead_program_id = 6157
WHERE 
	lead_program_id IN (686, 3381, 3382, 3896) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 12307 AND
	created >= '2011-01-01';

/*
 *  November 3 2010, Arjan, ticket: #6202
	Ik heb nog een special deal die vanaf vandaag ingaat (voor dezelfde affiliate):
	Shopkorting  (21941) komt in de hoogste staffel van Drogisterij.net. Dat is in dit geval lpid: 3382
*/
			         UPDATE 
    lead 
SET 
    lead_program_id = 3382
WHERE 
	lead_program_id IN (686, 3381, 3382,3896) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 21941;			         