/*August 20 2010, Dineke #5720
Aanvrager: Wouter
Autoapprove all leads that are 10 days old and older
*/
UPDATE
	lead
SET
	status = 'ACCEPTED'
WHERE
	lead_program_id IN (SELECT lead_programs(12360)) AND
	created < now() - INTERVAL '10 days' AND
	status = 'TO_BE_APPROVED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
/* March 15 2010, Dineke:
 * 2) Special deal
Wat moet er precies gebeuren?
Transacties van EuroClix (105) die binnenkomen op 3311  verplaatsen naar 3313. Wanneer ze vallen in parkspecifieke special deal (zie bijlage) dan naar 3320

Startdatum: 01/03/2010
Einddatum: 01/10/2010
 */
UPDATE
	lead
SET
	lead_program_id = 3313
WHERE
	lead_program_id = 3311 AND
	affiliate_id = 105 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-03-01';
	
/* Special deal: lead program 3313 for list of affiliates:
mathijs						7035
reizenpaleis				8149
Roas						3421
ton.vandenhoogen@iid.nl 	7743
EuroNovo					11684
trader						11033
Thomas25					5673
gratiskortingscode			12903
qincqinc 					630
cadeau						6429
Dovest						17214
*/
UPDATE
	lead
SET
	lead_program_id = 3313
WHERE
	lead_program_id = 3311 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (7035, 8149, 3421, 7743, 11684, 11033, 5673, 12903, 630, 6429, 17214);

/* April 21 2010, Dineke: Ticket #4860: special deal changed
Aanvrager:Wouter

Exploitanten (in geval van special deal. Username + id): info2@tndmedia.nl  (11976)

Welk type staffel is het (maak 1 keuze)?
2) Special deal
 

Lead programma's ID of advertentie ID (oud en nieuw): 

Wat moet er precies gebeuren?
Leads van info2@tndmedia.nl    (11976) naar lpid 3313.

Startdatum: 01/04/2010
Einddatum: 30/06/2010
*/
UPDATE
	lead
SET
	lead_program_id = 3313
WHERE
	lead_program_id IN (3311, 3312) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11976;
	
/* July 14th 2010, Jan, ticket: #5524
Aanvrager: Wouter

Exploitanten (in geval van special deal. Username + id):
Vakantieparken.nl (16709)
spanje.nl (8897)

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Wat moet er precies gebeuren?
Leads van Vakantieparken.nl  (16709) en spanje.nl (8897)naar lpid 3313.

Startdatum: 01/06/2010
Einddatum: 01/06/2012
*/
UPDATE
	lead
SET
	lead_program_id = 3313
WHERE
	lead_program_id IN (3311, 3312, 4567, 4568) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (8897, 16709) AND 
	created >= '2010-06-01' AND
	created < '2012-06-01'; 										

/** Echte staffel: 
 * 0-2 sales per maand 		= 3% (lpid 3482) 
 * 0 - 9 sales per maand 	= 4% (lpid 3311) * this is the base staffel
 * 10 - 24 sales per maand	= 5% (lpid 3312)
 * >= 25 sales per maand 	= 6% (lpid 3313)
**/

UPDATE
	lead
SET
	lead_program_id = 3483
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3311) AND
 	click_created < '2011-01-01' AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (3483, 3311, 3312, 3313, 3561, 3395, 3396, 3320) AND 
 											status = 'ACCEPTED' AND
 											click_created < '2011-01-01' AND
 											payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 0 AND 2);

UPDATE
	lead
SET
	lead_program_id = 3311
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3483) AND
 	click_created < '2011-01-01' AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (3483, 3311, 3312, 3313, 3561, 3395, 3396, 3320) AND 
 											status = 'ACCEPTED' AND
 											click_created < '2011-01-01' AND
 											payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 3 AND 9);
 	 										
UPDATE
	lead
SET
	lead_program_id = 3312
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3483, 3311) AND
 	click_created < '2011-01-01' AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (3483, 3311, 3312, 3313, 3561, 3395, 3396, 3320) AND 
 											status = 'ACCEPTED' AND
 											click_created < '2011-01-01' AND
 											payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 10 AND 24);
 				
UPDATE
	lead
SET
	lead_program_id = 3313
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3483, 3311, 3312) AND
 	click_created < '2011-01-01' AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (3483, 3311, 3312, 3313, 3561, 3395, 3396, 3320) AND 
 											status = 'ACCEPTED' AND
 											click_created < '2011-01-01' AND
 											payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) >= 25);
 										
/* November 5 2010, Dineke: #6209 bonuslead staffel
Aanvrager: Camiel

2) Bonusdeal
Wat moet er precies gebeuren:
Alle boekingen voor het park met de code SR à reguliere vergoeding + bonuslead lpid 4963
Parkcode staat vermeld onder omschrijving 2.
									
Startdatum: 5-11-2010
Einddatum: 31-12-2010  
 */
INSERT INTO	lead (
    click_id, 
    lead_program_id, 
    description1, 
    description2, 
    description3, 
    status, 
    created, 
    referrer, 
    user_agent, 
    ip_address, 
    price, 
    affiliate_id,
    click_created, 
    payment_period_id
    )
    SELECT 
    	click_id,							--click_id
    	4963,								--lead_program_id of bonus
    	now(),								--date in description1
    	description2,						-- bonus amount in description2
    	description3,						--description3
    	'ACCEPTED',							--status
    	now() - interval '7 hour',			--date
    	'automatic lead',					--referrer
    	'inserted by m4n',					--user_agent
    	'127.0.0.1',						--ip address
    	0,									--price
    	affiliate_id,						--affiliate id
    	click_created,						--time of click
    	(SELECT max(id) FROM payment_period)--payment_period_id
    FROM
    	(
    	SELECT
    		*
    	FROM
    		lead
    	WHERE
    		lead_program_id IN (SELECT lead_programs(12360)) AND lead_program_id != 4963 AND
    		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    		created BETWEEN '2010-11-05' AND '2010-12-01' AND
    		(description2 LIKE '%SR%') AND
    		NOT EXISTS (
    			SELECT
    				id
    			FROM
    				lead AS bonus_leads
    			WHERE
    				bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
    				bonus_leads.lead_program_id = 4836 AND
    				lead.click_id = bonus_leads.click_id
    		)
    	) AS leads;

/* December 31, Dineke, #6499:
Aanvrager: Liesbeth 

Lead programma's id: 6077 3483 6066

Wat moet er precies gebeuren?
Alle sales komen momenteel binnen op lp 6066. 
Wanneer in 'BL' description 2 staat, moet deze in lp 6077 vallen 
Wanneer in 'OD', 'KM' of 'VI' description 2 staat, moet deze in lp 3483 vallen

Startdatum: 25 december
Einddatum: Nog niet bekend, maar ze zijn bezig om dit technisch zelf op te gaan lossen. 
Maar in ieder geval moeten de sales van december goedgezet worden.
*/
UPDATE
	lead
SET
	lead_program_id =	CASE
							WHEN description2 LIKE '%BL%' THEN 6077
							ELSE 3483
						END
WHERE
	lead_program_id IN (6066) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-12-25' AND
	(description2 LIKE '%BL%' OR description2 LIKE '%OD%' OR description2 LIKE '%KM%' OR description2 LIKE '%VI');