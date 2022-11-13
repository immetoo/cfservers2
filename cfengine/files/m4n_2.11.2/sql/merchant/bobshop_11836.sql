
/**
* Staffel Bobshop 11836
*/


/**
March 20 2009, Dineke: special deal (reported by Alexander, March 19)
Kan jij voor bobshop11836 een special deal aanmaken op lead id 2783 voor besteconsumentenkoop9181.
Daarnaast moeten de volgende marges voor affiliates aangepast worden.
*/

UPDATE lead SET lead_program_id = 2783
WHERE affiliate_id = 9181 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 11836 AND id != 2783);

/* April 20 2010, Jan, ticket: #4854
Adverteerder: Bobshop
ID Adverteerder: 11836
Welk type staffel is het (maak 1 keuze)?

Wat moet er precies gebeuren?
Alle leads van 19895 98Hulse moeten in lead programma 4310 komen. Ook de vaste vergoedingen

Startdatum: 20-04-2010
Einddatum: geen
*/
UPDATE
	lead 
SET
	lead_program_id = 4310
WHERE
	affiliate_id = 19895 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 11836 AND id != 4310) AND
	created >= '2010-04-20';

/* May 19 2010, Jan, ticket: #5110
Aanvrager: Wouter Groenewoud
Exploitanten (in geval van special deal. Username + id): Hoeknet (7863)

Wat er moet gebeuren is het volgende: Leads die van Hoeknet voor Bobshop binnekomen moeten vallen in leadprogramma 4412.

Mocht er nog iets onduidelijk zijn, hoor ik dit graag.
*/

UPDATE
	lead 
SET
	lead_program_id = 4412
WHERE
	affiliate_id = 7863 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 11836 AND id != 4412) AND
	created >= '2010-05-18';

/* September 22 2010, Jan, ticket: #5929
Special deal voor aanvraag voor: Debesteonline (19186) bij Bobshop (11836) als debesteonline meer dan 10 leads zet voor Bobshop dan mogen de leads 
in leadprogramma 4412 vallen.
*/
	
UPDATE
	lead
SET
	lead_program_id = 4412
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 11836 AND id != 4412) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 11836 AND id != 4412) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			affiliate_id = 19186
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10
	);