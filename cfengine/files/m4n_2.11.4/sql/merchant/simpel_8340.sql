/* July 27th, 2010, Jan, ticket: #5589
Zou je in het account van Simpel 8340 alle clicks vanaf 10 juli van zone 770963 van Money Miljonair id 307 op leadprogramma 4649 willen zetten?
*/
UPDATE	
	lead
SET
	lead_program_id = 4649
FROM
	click
WHERE
	click.id = lead.click_id AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.affiliate_id = 307 AND
	lead.lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8340 AND id != 4649) AND
	click.created >= '2010-07-10';
	

/* Juni 28 2010, Dineke:
 * Reported by Tim:
 * Kan je alle leads van affiliate 19610 uit zone 775329 op leadprogramma 4365 van Simpel 8340 zetten?
*/
UPDATE	
	lead
SET
	lead_program_id = 4365
FROM
	click
WHERE
	click.id = lead.click_id AND
	click.zone_id = 775329 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.affiliate_id = 19610 AND
	lead.lead_program_id IN (1301, 3042);
	
/* May 6 2010, Dineke,
Reported by Tim:
Kan je alle leads van aff. 19777 standaard in leadprogramma 4365 bij Simpel 8340?
*/
UPDATE
	lead
SET
	lead_program_id = 4365
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8340 AND id != 4365) AND
	affiliate_id = 19777 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* April 16 2010, Dineke, ticket #4827
Hoi Din,

Kan je voor affiliate Beverhills 19610 alle leads die binnenkomen op zone 750669 voor Simpel 8341 naar het leadprogramma 4066 verplaatsen?

Met vriendelijke groet,
Tim Markestein

Update May 26 2010, Jan, ticket: #5173
Added zone 746134 for affiliate 19610
*/
UPDATE
	lead
SET
	lead_program_id = 4066
FROM
	click
WHERE
	click_id = click.id AND
	lead.affiliate_id = 19610 AND
	click.zone_id IN (750669, 746134) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8340 AND id != 4066) AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* April 13 2010, Dineke, ticket #4815
 * Reported by Tim:
Kan je de affiliate Yellow Industries 16163 standaard in leadprogramma 4216 zetten voor Simpel 8340?
Vanaf de huidige betaalperiode. Dus alle leads die bij accorderen staan deze maand.
Aff. 35 euro
Adv. 52 euro
*/
UPDATE
	lead
SET
	lead_program_id = 4216
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8340 AND id != 4216) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 16163;
	

/* January 27 2010, Dineke: new special deal
Jonas: Kun je de affiliate DMG(14878) voor zijn sales in januari en daarna op leadprogramma 3837 van adverteerder Simpel (8340) zetten?

May 31 2010, Dineke
Requested by Patrick Emmen: even better deal: 
Lead program 4449, starting May 21st
*/
UPDATE
	lead
SET
	lead_program_id = 4449
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8340 AND id != 4449) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 14878 AND
	created > '2010-05-21';

/* January 21 2009, Dineke:
Reported by Jonas:
Zou je alle leads van Mathijs Westdijk (7035 ) die hij vanaf 1 februari tot 1 maart (1 maand) voor adverteerder Simpel (8340) zet op het volgende leadprogramma willen zetten (3868 )
Na 1 maart graag alle leads van Mathijsvoor Simpel  automatisch op leadprogramma (3837)
*/

UPDATE
	lead
SET
	lead_program_id = CASE WHEN created < '2010-03-01' THEN 3868 ELSE 3827 END
WHERE
	affiliate_id = 7035 AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8340) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-02-01';
	
/* January 19 2010, Dineke:
Requested by Tim:
Kan je EC (105) standaard in het leadprogramma 3042 (€ 40,- ) zetten 
bij Simpel (8340), vanaf 18 januari?
* February 26 2010, Dineke:
* Requested by Tim:
* add affiliate LeadR (16163) to this deal
October 18 2010, Dineke, ticket #6055:
add affiliate Roy van Wensen (18012) to deal, starting October 18th.
*/
UPDATE
	lead
SET
	lead_program_id = 3042
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8340 AND id != 3042) AND
	affiliate_id IN (105, 16163, 18012) AND
	created > '2010-10-18';


/* March 15 2010, Dineke: special special deal (normal special deal is the one below)
 * Reported by Tim:
Kan je alle leads die binnenkomen op adv. 673683 voor Simpel (8340) van de Vrijheidspers (8350) op leadprogramma 4066 zetten?
 */
UPDATE
	lead

SET
	lead_program_id = 4066
FROM
	click
WHERE
	click.id = click_id AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8340 AND lead_program_id NOT IN (3500, 4066)) AND
	lead.affiliate_id = 8350 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	advertisement_id = 673683;

	/* October 23 2009, Dineke Ticket #4136:
Special deal for affiliate vrijheidspers (8350) always gets lead_program_id 3500, starting October 21st
*/
UPDATE
	lead
SET
	lead_program_id = 3500
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8340 AND lead_program_id NOT IN (3500, 4066)) AND
	affiliate_id = 8350 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2009-10-21';
	
 

/* 23 June 2009, Dineke, Ticket #3046:

Zou je voor Simpel (id=8340) een staffel willen inbouwen
Staffel #1 Offid=1301 0 t/m 49 sales Vergoeding 35/50
Staffel#2 Offid=3042 50+ Sales Vergoeding 40/50
*/

UPDATE
	lead
SET
	lead_program_id = 3042
WHERE
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 1301 AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(SELECT
			affiliate_id
		FROM 
			lead
		WHERE
			status = 'ACCEPTED' AND
			lead_program_id IN (1301, 3042) AND 	
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	    GROUP BY affiliate_id HAVING COUNT(id) >= 50
	);

 