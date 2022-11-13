/* December 16, Dineke, #6451:
 * Aanvrager: Paul Vogelzang

Lead programma's ID of advertentie ID (oud en nieuw): nieuw 6063

Wat moet er precies gebeuren?

Affiliate vrijheidspers (8350) krijgt in de periode van 16 december tm 27 december een bruto vergoeding
 van 25 euro CPL. Alle leads die in deze periode binnenkomem mogen direct worden goedgekeurd.
Na deze periode mag de affiliate weer in leadprogramma id 3499 vallen. Deze leads moeten niet meer standaard gekeurd worden.

Startdatum: 16 december
Einddatum: 27 december
*/
UPDATE
	lead
SET
	lead_program_id = 6063, status = 'ACCEPTED'
WHERE
	lead_program_id IN (SELECT lead_programs(5722)) AND lead_program_id != 6063 AND
	affiliate_id = 8350 AND
	status != 'BLOCKED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-12-16' AND '2010-12-28';
	
/** GSM.nl (Id: 5722)
 *
 *	Ticket #1887: automatically reject all leads from GSMnl_Stats (Id: 10852) **/

UPDATE
	lead
SET 
	status = 'REJECTED'
WHERE 
 	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 5722) AND
 	affiliate_id = 10852 AND
 	status IN ('TO_BE_APPROVED', 'ACCEPTED', 'ON_HOLD') AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* October 23 2009, Dineke Ticket #4136:
Special deal for affiliate vrijheidspers (8350) always gets lead_program_id 3499, starting October 21st
*/
UPDATE
	lead
SET
	lead_program_id = 3499
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 5722) AND
	affiliate_id = 8350 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2009-10-21';
	
/* July 14th 2010, Jan, ticket: #5526
Leads van Euroclix (105) zone 781846 voor gsm.nl moeten op lead_programma 4619 komen te staan.
De mailing gaat er morgen 14-07-2010 uit.
*/
UPDATE
	lead
SET
	lead_program_id = 4619
FROM
	click
WHERE
	click_id = click.id AND
	lead.affiliate_id = 105 AND
	click.zone_id = 781846 AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 5722 AND id != 4619) AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.created >= '2010-07-14';
	
/* November 5 2009, Dineke:
	Reported by Tim: Special deal staffel:
Voor een paar affiliates hebben we een special deal. 
Affiliates:
* Lysander (10929)
* Martijn Portable Gear (578)
* Sanoma - Jouwmobiel (13382)
* online-concepts" (4661).

 	3528      Bruto vergoeding 0 - 50 orders
	3529      Bruto vergoeding - 50+ orders

Update June 23 2010, Online-concepts are switching to account 13435 (Webaholics)		
*/
--step 1: affiliates are promoted to the base of the special deal
UPDATE
	lead
SET
	lead_program_id = 3528, status = 'ACCEPTED'
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 5722 AND lead_program_id NOT IN (3538, 3539)) AND
	affiliate_id IN (10929, 578, 13382, 4661, 13435) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
--step 2: promote the affiliates who have more than 50 leads
UPDATE
	lead
SET
	lead_program_id = 3529
WHERE
	lead_program_id = 3528 AND
	affiliate_id IN (10929, 578, 13382, 4661, 13435) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (3528, 3529) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) > 50
	);
	