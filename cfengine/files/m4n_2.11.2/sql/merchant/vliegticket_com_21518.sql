/* December 16, Dineke, #6447
 * Aanvrager: Camiel

Special deal
Alle leads voor affiliate Caroline Ferguson (8480) die binnenkomen op 4683 doorsluizen naar 6062,
tenzij er in description 3 "lowcost airlines" staat, 
dan gaat ie niet door naar 6062 (see rule below).

Startdatum: 1-12-2010
Einddatum: geen
 */
UPDATE
	lead
SET
	lead_program_id = 6062
WHERE
	lead_program_id = 4683 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 8480 AND
	description3 NOT LIKE '%lowcost%' AND
	created > '2010-12-01';
/**
* Dineke Tuinhof, August 16 2010, #5690
* Staffel vliegtickets.com 21518
*/

--Move sales with description3 'lowcost' from lead_program_id 4683 --> 4693
UPDATE 
	lead
SET 
	lead_program_id = 4693
WHERE 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 4683 AND
	description3 LIKE '%lowcost%';

/* September 16 2010, Dineke, #5911:
 * Aanvrager: Fleur

Welk type staffel is het (maak 1 keuze)?

Special deal
8874 : JoriSsz?

Standaard in hoogste staffel; 4683 à 4692

Startdatum: 15-9-2010 ( dus graag met terugwerkende kracht)
Einddatum: nvt
 */
UPDATE
	lead
SET
	lead_program_id = 4692
WHERE
	lead_program_id = 4683 AND
	affiliate_id = 8874 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-09-15';

/* January 31 2011, Jan
Move leads containing lijnvlucht in description3 to the multi-tier reward lead program
*/
UPDATE
	lead
SET
	lead_program_id = 6069
WHERE
	lead_program_id = 4683 AND
	description3 LIKE '%lijnvlucht%' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created >= '2011-02-01';
	
--Staffel for remaining leads in lead_program 4683, description3 should be 'lijnvlucht'
--11-19 sales: 4683 --> 4691
UPDATE
	lead 
SET
	lead_program_id = 4691
WHERE
	lead_program_id IN (4683) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	description3 LIKE '%lijnvlucht%' AND
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (4691, 4683) AND
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		click_created < '2011-02-01' AND
		description3 LIKE '%lijnvlucht%'
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 19
	);
	
--20 sales and up: 4691 --> 4692
UPDATE
	lead 
SET
	lead_program_id = 4692
WHERE
	lead_program_id IN (4683, 4691) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	description3 LIKE '%lijnvlucht%' AND
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (4691, 4683, 4692) AND
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		click_created < '2011-02-01' AND
		description3 LIKE '%lijnvlucht%'
	GROUP BY affiliate_id HAVING COUNT(id) >= 20
	);