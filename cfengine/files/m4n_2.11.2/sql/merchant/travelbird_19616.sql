/* June 28 2010, Dineke, Ticket #5416:
 * Hoi Dineke,

Aanvrager: Fleur

Welk type staffel is het (maak 1 keuze)? Gewone staffel

Affiliate: alle

Staffel:
1-15 sales    4156
15-35 sales   4157
35 en hoger   4174

Startdatum: 1-7-2010
Einddatum: NVT
*/
--15-35 sales   --> 4157
UPDATE
	lead
SET
	lead_program_id = 4157
WHERE
	lead_program_id = 4156 AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-07-01' AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(SELECT
			affiliate_id
		FROM 
			lead
		WHERE
			status = 'ACCEPTED' AND
			lead_program_id IN (4156, 4157, 4174) AND 		 
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 15 AND 34
		);

--35 en hoger   --> 4174
UPDATE
	lead
SET
	lead_program_id = 4174
WHERE
	lead_program_id IN (4156, 4157) AND
	status = 'ACCEPTED' AND
	created > '2010-07-01' AND
	click_created < '2011-01-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
		(SELECT
			affiliate_id
		FROM 
			lead
		WHERE
			status = 'ACCEPTED' AND
			lead_program_id IN (4156, 4157, 4174) AND 		
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY affiliate_id HAVING COUNT(id) >= 35
		);

/* May 3rd 2010, Dineke, Ticket #4934
Aanvrager: Fleur

Welk type staffel is het (maak 1 keuze)?
Special deal

Affiliate: alle

Wat moet er precies gebeuren?

Alle sales van alle affiliates van 1-5-2010 t/m 31-5-2010 vallen in de hoogste staffel
4156 --> 4363
UPDATE MAY 11th 2010: programs 4174 and 4157 should also be promoted to 4363

Startdatum: 1-5-2010
Einddatum: 31-5-2010 
*/
UPDATE
	lead
SET
	lead_program_id = 4363
WHERE
	lead_program_id IN (4174, 4157, 4156) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-05-01' AND '2010-06-01';
	
