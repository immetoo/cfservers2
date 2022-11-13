/* March 10 2010, Jan, ticket: #4699
Aanvrager: paul vogelzang

Adverteerder: Misco
ID Adverteerder: 10968

Exploitanten (in geval van special deal. Username + id):

Username: Martijn, het bedraagt om portablegear.nl

id: 578

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):  lead programma id: 2190

Wat moet er precies gebeuren?

Portablegear.nl moet standaard in het leadprogramma 2190,van Mico, vallen en een vergoeding ontvangen van 5%
*/
UPDATE 
	lead 
SET 
	lead_program_id = 2190 
WHERE
	lead_program_id = 1928 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 578 AND
	created > '2010-03-10';


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
						
/* May 12 2009, Dineke:
	Special deal: prijsvergelijk (6387) always gets the high reward, starting today
*/
UPDATE lead SET lead_program_id = 2190 WHERE
	lead_program_id = 1928 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6387 AND
	created > '2009-05-12';
						
/**
 * Nov 11 2009, Andre':
 * Special deal: windows7 (16413) always gets the high reward, starting today
 */
UPDATE lead SET lead_program_id = 2190 WHERE
	lead_program_id = 1928 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 16413 AND
	created > '2009-11-01';

/* January 5, 2010, Jan, ticket: #4429
Aanvrager: Jesse le Grand
Exploitanten (in geval van special deal. Username + id): shopkorting 12307

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
From: 1928 to: 2190

Wat moet er precies gebeuren?
Alle sales van expl. 12307 moeten op lpid 2190 worden gezet.

Startdatum: 01-01-10
Einddatum: geen
 */
UPDATE 
	lead 
SET 
	lead_program_id = 2190 
WHERE
	lead_program_id = 1928 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 12307 AND
	created > '2010-01-01';
