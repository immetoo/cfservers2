/**
* Staffel van Het Net userid: 8905
* ticket #1458
**/

/*
* Special Deal
* Affiliate prijsvergelijk 6387 Altijd naar OFFERID 1664 
**/
UPDATE 
	lead
SET 
	lead_program_id = 1664
WHERE 
	lead_program_id = 1412 AND status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6387;

/**
*
* Offerid 1664 26 or more leads in total? ADSL (1412) becomes 1664
**/
UPDATE 
	lead
SET 
	lead_program_id = 1664
WHERE 
	lead_program_id = 1412 AND 
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (1412,1420,1663,1664,1690) AND 
			click_created < '2011-01-01' AND
			status = 'ACCEPTED' AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) > 25
	);
	
/* Added February 25 2009 by Dineke, reported Feb 24 day by Tim
 Wat moet er precies gebeuren?

 Alle leads van Euroclix (ook reeds gezette leads) moeten naar
 leadprogramma 2647.
*/
UPDATE 
	lead
SET 
	lead_program_id = 2647
WHERE 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8905) AND
	affiliate_id = 105;
	
/* Ticket #2619
Added February 25 2009 by Dineke, reported same day by Tim

 Exploitanten (in geval van special deal. Username + id): 9321 Leadmedia

 Welk type staffel is het?
 2) Special deal

 Leadprogramma's:  2707
 Let op! Vergoeding moet worden € 40,- aff. en € 49,- adv.

 Wat moet er precies gebeuren?
  * Leadmedia krijgt een hogere vergoeding (€ 40,-) voor HetNet.
 Startdatum: 01-02-2009
 Einddatum: nvt
 */

UPDATE 
	lead
SET 
	lead_program_id = 2707
WHERE 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8905 AND id != 2707) AND
	affiliate_id = 9321 AND
	click_created NOT BETWEEN '2009-05-16' AND '2009-06-16'; --TEMP: see comment below

/* May 28 2009, Dineke, Ticket #2873
Aanvrager: Patrick Tyc

Hoi Dineke,

Zou je tijdelijk de exploitant de normale (hogere actievergoeding) willen toekennen t/m 15 juni?

Betreft affiliate: id=9321

Leadprogramma Tot 15 juni (offid=2707)
vanaf 16 juni = offid-1412
*/
