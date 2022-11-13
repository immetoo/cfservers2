/* December 16 2010, Dineke, #6446
Aanvrager:Paul Vogelzang (December 15th)

Exploitanten (in geval van special deal. Username + id):

13435 Webaholics
578   Martijn
7277  IML
9672  Netoda
18399 gsmpedia10
14783 scherponline

Wat moet er precies gebeuren?

Alle 6 affiliates mogen standaard in de hoge staffel (4832) geplaatst worden.
Zij ontvangen een vergoeding van 35 euro cpl voor de affiliates

Startdatum: als het mogelijk is per direct, anders per 1 januari 2011
Einddatum:-
*/
UPDATE
	lead
SET
	lead_program_id = 4832
WHERE
	lead_program_id IN (SELECT lead_programs(2734)) AND lead_program_id != 4832 AND
	affiliate_id IN (13435, 578, 7277, 9672, 18399, 14783) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created  > '2010-12-15';
	
/* November 30 2009, Dineke
Reported by Jonas, November 27th:
Zou je alle leads van Jwestra id: 10252 voor student mobiel (2734) automatisch op leadprogramma 3675 willen zetten?

Vanaf heden.
*/

UPDATE
	lead
SET
	lead_program_id = 3675
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 2734 AND id != 3675) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 10252 AND
	created > '2009-11-27';
	
/*
 * Adverteerder: Studentmobiel.nl
ID Adverteerder: 2734


Welk type staffel is het (maak 1 keuze)?
1) Echte staffel

Lead programma's ID of advertentie ID (oud en nieuw):  
oud: 	607		1-3 sales			25 CPL voor de affiliate	
oud: 	4040	los toestel/product	3 CPL voor de affiliate	
nieuw:	4829	4-9 sales			30 CPL voor de affiliate
nieuw:	4830	10-24 sales		32,50 CPL voor de affiate
nieuw:	4832	>25 sales			35 CPL voor de affiliate

Wat moet er precies gebeuren?
Staffel instellen, per 1 oktober mag deze in werking gaan, waarbij leadprogramma 4040 mee mag tellen voor de staffel telling.
Startdatum: 01-10-10
Einddatum:geen


*/
	
/*
 * nieuw:	4829	4-9 sales			30 CPL voor de affiliate
 */
	
UPDATE
	lead
SET
	lead_program_id = 4829
WHERE
	lead_program_id = 607 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-10-01' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (607,4040, 4829, 4832, 4830 ) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created >= '2010-10-01'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 4 AND
			COUNT(id) < 10
	);
	
/*
 * nieuw:	4830	10-24 sales		32,50 CPL voor de affiate
 */

UPDATE
	lead
SET
	lead_program_id = 4830
WHERE
	lead_program_id IN (607, 4829)  AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-10-01' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (607,4040, 4829, 4832, 4830 ) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created >= '2010-10-01'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10 AND
			COUNT(id) < 25
	);

/*
 * nieuw:	4832	>25 sales			35 CPL voor de affiliate
 */
	
UPDATE
	lead
SET
	lead_program_id = 4832
WHERE
	lead_program_id IN (607, 4829, 4830) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-10-01' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (607,4040, 4829, 4832, 4830 ) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created >= '2010-10-01'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 25
	);
	
	