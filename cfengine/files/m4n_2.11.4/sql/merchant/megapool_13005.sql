/* October 27 2010, Jan, ticket: #6138
Graag een special aanmaken voor Megapool (13005) en Kelkoo(420) De leads van Kelkoo (420) mogen in ID 2806 vallen. Dit mag ingaan per vandaag. 
*/
UPDATE
	lead
SET
	lead_program_id = 2806
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2664 AND
	affiliate_id = 420 AND
	created >= '2010-10-26';

/* February 2 2010, Jan, ticket: #4532
Aanvrager: Jesse le Grand
Adverteerder: Megapool
ID Adverteerder: 13005
 
Exploitanten (in geval van special deal. Username + id): Lysander 10929

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
From: 2664 to: 2806

Wat moet er precies gebeuren?
Alle sales van 10929 moeten op 2806 worden gezet.

Startdatum: 01-01-10
Einddatum: geen
 */
UPDATE
	lead
SET
	lead_program_id = 2806
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2664 AND
	affiliate_id = 10929 AND
	created >= '2010-01-01';
	

/** March 27 2009, Dineke: Special Deal
    As of 27th of March, all leads on lead_program 2664 from affiliate 13117 are promoted to lead_program_id 2806
**/

UPDATE 
	lead 
SET 
	lead_program_id = 2806
WHERE	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		affiliate_id = 13317 AND
		status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
		lead_program_id =  2664;

/* June 19 2009, Dineke:
Special deal for same program as above, but starting on a different date...

Zou je Affiliate 11315 kunnen koppelen aan offid 2806 bij megapool 13005.
Dit moet met terugwerkende kracht per 15-06 ingaan.
You are the best! :)
Jesse le Grand
Team Manager Shopping
*/
UPDATE
	lead
SET
	lead_program_id = 2806
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11315 AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	lead_program_id =  2664 AND
	created > '2009-06-15';
	
/* May 19 2010, Jan, ticket: #5119
Aanvrager: Wouter Groenewoud
Exploitanten (in geval van special deal. Username + id): Prijsvergelijk (6387)

Wat er moet gebeuren is het volgende: Leads die van Prijsvergelijk voor Megapool binnenkomen moeten vallen in leadprogramma 2806.
Ingangsdatum: 19-05-2010
*/
UPDATE
	lead
SET
	lead_program_id = 2806
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6387 AND
	lead_program_id = 2664 AND
	created > '2010-05-19';
	
/* May 20 2010, Jan, ticket: #5136 
Aanvrager: Wouter Groenewoud
Exploitanten (in geval van special deal. Username + id): Twenga (11672)
Wat er moet gebeuren is het volgende: Leads die van Twenga voor Megapool binnenkomen moeten vallen in leadprogramma 2806.
Ingangsdatum: 20-05-2010
*/
UPDATE
	lead
SET
	lead_program_id = 2806
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11672 AND
	lead_program_id = 2664 AND
	created >= '2010-05-20';
	
/* May 28 2010, Jan, ticket: #5210
Aanvrager: Wouter Groenewoud
Kunnen de leads die marksurf (16582) voor Megapool (13005) zet in het vervolg in programma (2806) binnenkomen. 
*/
UPDATE
	lead
SET
	lead_program_id = 2806
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 16582 AND
	lead_program_id = 2664 AND
	created > '2010-05-28';	
	
/* June 1 2010, Jan, ticket: #5259
Aanvrager: Wouter Groenewoud
Zou je voor mij de volgende Special deal kunnen maken?
De leads van Kortingkorting (8420) voor Megapool (13005) mogen in het vervolg in programma (2806) binnenkomen.
*/
UPDATE
	lead
SET
	lead_program_id = 2806
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 8420 AND
	lead_program_id = 2664 AND
	created >= '2010-06-01';		


/* 10 September 2010, Arjan, ticket: #5887
Aanvrager: Wouter Groenewoud
Kan er een special deal worden gemaakt voor debesteonline (19186 ) en Megapool (13005)
Leads die debesteonline voor Megapool zet mogen in leadprgramma (2806) vallen.
Ingangsdatum: 10 september.
*/
UPDATE
	lead
SET
	lead_program_id = 2806
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 19186  AND
	lead_program_id = 2664 AND
	created >= '2010-09-10';		

	