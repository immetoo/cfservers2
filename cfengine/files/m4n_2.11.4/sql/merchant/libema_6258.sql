/* July 20 2010, Dineke, Ticket #5560:
Aanvrager: wouter

4) Bonusdeal 
Lead programma's ID of advertentie ID (oud en nieuw): 4497 

Wat moet er precies gebeuren?

Extra lead bij goedgekeurde boeking t/m augustus.

Startdatum: 10-06-2010
Einddatum (t/m): 31-08-2010
*/
INSERT INTO lead (
	click_id, 
	lead_program_id, 
	description1,
	price, 
	status,  
	referrer, 
	ip_address, 
	user_agent, 
	payment_period_id, 
	affiliate_id, 
	click_created,
	created
)

SELECT
	click_id,
	4497,
	'Bonus for ' || description1,
	 0 AS price,
	 status,
	 referrer,
	 ip_address,
	 user_agent,
	 payment_period_id,
	 affiliate_id,
	 click_created,
	 now() - interval '7 hours' 
FROM
	lead
WHERE
	created BETWEEN '2010-06-10' AND '2010-09-01' AND
	click_created BETWEEN '2010-06-10' AND '2010-09-01' AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 6258 AND id != 4497) AND
	NOT EXISTS (
		SELECT
			id
		FROM
			lead as bonus_leads
		WHERE
			bonus_leads.lead_program_id = 4497 AND
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			lead.affiliate_id = bonus_leads.affiliate_id AND
			'Bonus for ' || lead.description1 = bonus_leads.description1
	);

/* July 28th 2010, Jan, ticket: #5601
Aanvrager: Wouter

Exploitanten (in geval van special deal. Username + id):
hansrinsma (5133)

Welk type staffel is het (maak 1 keuze)?
1) special deal

Wat moet er precies gebeuren?
Leads verplaatsen naar lpid 2617

Startdatum: 28/07/2010
Einddatum: 28/07/2012
*/

UPDATE 
	lead
SET 
	lead_program_id = 2617
WHERE
	lead_program_id IN (1228, 4032, 4033) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id  = 5133 AND
	created >= '2010-07-28' AND
	created < '2012-07-28';

/* June 30 2010, Dineke:
Aanvrager: wouter

Exploitanten (in geval van special deal. Username + id):
* sizl: 630

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Wat moet er precies gebeuren?
Update leads from this user to highest lead_program, 2617.
*/
UPDATE lead
	SET lead_program_id = 2617
	WHERE
		lead_program_id IN (1228, 4032, 4033) AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		affiliate_id IN (630);

/* June 11 2010, Dineke, Ticket #5335
 * Aanvrager: wouter

Exploitanten (in geval van special deal. Username + id):

Welk type staffel is het (maak 1 keuze)?
Temp incentive

Lead programma's ID of advertentie ID (oud en nieuw): 

4033 > 2617

Wat moet er precies gebeuren?

In het geval de affiliate tussen de 7 en 14 boekingen behaalt, dus middels de reguliere staffel in lpid 4033 valt, dan boekingen overzetten naar 2617. 
Incentive heeft week uitloop, dus kliks t/m 10-07 tellen mee voor transacties t/m 17-07

Startdatum: 10-06-2010
Einddatum (t/m): 17-07-2010
*/
-- 2. 7-14 boekingen/mnd = 2617 (instead of lpid 4033)
UPDATE
	lead
SET
	lead_program_id = 2617
WHERE
	lead_program_id IN (1228, 4032, 4033) AND
	created BETWEEN '2010-06-07' AND '2010-07-18' AND
	click_created BETWEEN '2010-06-10' AND '2010-07-11' AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (	SELECT
							affiliate_id
						FROM
							lead
						WHERE
							lead_program_id IN (1228, 4032, 4033, 2617) AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
							status = 'ACCEPTED'
						GROUP BY
							affiliate_id
						HAVING
							count(id) BETWEEN 7 AND 14
					);

/* Ticket #4685, March 8 2010, Dineke:
Aanvrager: wouter

Exploitanten (in geval van special deal. Username + id):

Welk type staffel is het (maak 1 keuze)?
1) Echte staffel

Lead programma's ID of advertentie ID (oud en nieuw): 
1228 > 4032 > 4033 > 2617

Wat moet er precies gebeuren?

0. 0-2 boekingen/mnd = lpid 1228
1. 3-6 boekingen/mnd = lpid 4032
2. 7-14 boekingen/mnd = lpid 4033
3. > 14 boekingen/mnd = lpid 2617

Startdatum: 07-03-2010
Einddatum: 07-03-2012
*/
-- 1. 3-6 boekingen/mnd = lpid 4032
UPDATE
	lead
SET
	lead_program_id = 4032
WHERE
	lead_program_id = 1228 AND
	created > '2010-03-07' AND
	click_created < '2011-01-01' AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (	SELECT
							affiliate_id
						FROM
							lead
						WHERE
							lead_program_id IN (1228, 4032, 4033, 2617) AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
							click_created < '2011-01-01' AND
							status = 'ACCEPTED'
						GROUP BY
							affiliate_id
						HAVING
							count(id) BETWEEN 3 AND 6
					);

-- 2. 7-14 boekingen/mnd = lpid 4033
UPDATE
	lead
SET
	lead_program_id = 4033
WHERE
	lead_program_id IN (1228, 4032) AND
	created > '2010-03-07' AND
	click_created < '2011-01-01' AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (	SELECT
							affiliate_id
						FROM
							lead
						WHERE
							lead_program_id IN (1228, 4032, 4033, 2617) AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
							click_created < '2011-01-01' AND
							status = 'ACCEPTED'
						GROUP BY
							affiliate_id
						HAVING
							count(id) BETWEEN 7 AND 14
					);

--3. > 14 boekingen/mnd = lpid 2617
UPDATE
	lead
SET
	lead_program_id = 2617
WHERE
	lead_program_id IN (1228, 4032, 4033) AND
	created > '2010-03-07' AND
	click_created < '2011-01-01' AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (	SELECT
							affiliate_id
						FROM
							lead
						WHERE
							lead_program_id IN (1228, 4032, 4033, 2617) AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
							click_created < '2011-01-01' AND
							status = 'ACCEPTED'
						GROUP BY
							affiliate_id
						HAVING
							count(id) > 14
					);
