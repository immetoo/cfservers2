/* July 19 2010, Dineke
Aanvrager: Fleur

Welk type staffel is het (maak 1 keuze)?
2) Special deal, tijdelijke actie

Lead programma's ID of advertentie ID (oud en nieuw): nieuw 4621

Wat moet er precies gebeuren?
Alle affiliates krijgen tussen 14-7 en 14-8 een bonusvergoeding. Alle sales in deze periode moeten dus ID 4621 krijgen.

Startdatum: 14-7-2010
Einddatum: 14-8-2010
 */
UPDATE
	lead
SET
	lead_program_id = 4621
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 13058 AND id != 4621) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-07-14' AND '2010-08-15';
	
/* March 19 2010, Dineke:
 * requested by Wouter:
 * promote affiliate 13197 (olezonl) to Lpid 4069 (%-based). 
 * September 14 2010: add 22070 (olezoo)
 */
UPDATE
	lead
SET
	lead_program_id = 4069
WHERE
	lead_program_id IN (2704, 2740) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (13197, 22070);

/** Ticket 2773, April 23 2009, Dineke:
EuroNovo (11684), caroline (8480), blinzo (11212), shenouda (730)
are promoted to hidden lead_program 3179 (ticket 3604).
The price of the order is backed up in description3
**/
UPDATE
	lead
SET
	lead_program_id = 3179
WHERE
	lead_program_id IN (2704, 2740) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (11684, 8480, 11212, 730);

/* Ticket 4395, December 18 2009, Dineke:
Aanvrager:Wouter Swenneker
Adverteerder: Nile Travel ID Adverteerder: 13058
Exploitanten (in geval van special deal. Username + id): EuroNovo? (11684)

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 3769

Wat moet er precies gebeuren?
Sales van deze exploitant worden nu gekoppeld aan 3179. Tm eind dec graag koppelen aan lpid 3769

Startdatum: 01 december 2009 Einddatum: 31 december 2009 
*/
UPDATE
	lead
SET
	lead_program_id = 3769
WHERE
	lead_program_id = 3179 AND
	affiliate_id = 11684 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2009-12-01' AND '2010-01-01';
	
/** Ticket 2772. 2009 April 23rd. Andre Cesta.
Until the end of May, everyone gets silver! (2704 --> 2740 */
UPDATE 
	lead
SET 
	lead_program_id = 2740
WHERE
 	lead_program_id = 2704 AND	
	created < '2009-06-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id NOT IN (730, 11684, 5263);

/** 23 April 2009, Dineke:
	normal staffel: more than 2 leads? 2704 --> 2740
**/
UPDATE
	lead
SET	
	lead_program_id = 2740
WHERE
	lead_program_id = 2704 AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT affiliate_id FROM lead WHERE
							status = 'ACCEPTED' AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
							click_created < '2011-01-01' AND
							lead_program_id IN (2740, 2704)
					 GROUP BY affiliate_id HAVING COUNT(id) > 2
					 );


/**
 Ticket 2804. Andre Cesta. 2009-05-10.
 Special deal Blixem.
 Had to adapt it to use lead program id 2740 also.
 */
UPDATE lead
SET lead_program_id = 2741
WHERE 	status = 'ACCEPTED' AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2704, 2740) AND 
	affiliate_id = 5263 AND
	created >= '2009-05-04' AND
	created < '2012-05-04';


/**
 Ticket 2862. Andre Cesta. 2009-05-28.
 Special deal affiliate 5673.
 */
UPDATE lead
SET lead_program_id = 2741
WHERE status = 'ACCEPTED' AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id from lead_program where merchant_id = 13058 AND id != 2741) AND 
	affiliate_id = 5673 AND
	created >= '2009-05-27';
