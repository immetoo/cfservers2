/* February 4 2010, Jan, ticket: #4539
Updated: February 8 2010
Aanvrager: Wouter Groenewoud

Adverteerder: Bikesplaza
ID Adverteerder: 17443

Welk type staffel is het (maak 1 keuze)?
2) Staffel voor één affiliate Lysander (10929)

Lead programma's ID of advertentie ID (oud en nieuw): 
Lysander moet standard in de hoogste staafel komen bij Bikesplaza.
Id leadprogramma: (3870)

Wat moet er precies gebeuren?
Lysander moet standaard in de hoogste staffel komen, ongeacht de aantallen. Lead promgramma is 3870

Startdatum: 08-02-2010
Einddatum: geen
*/
UPDATE
	lead
SET
	lead_program_id = 3870
WHERE
	lead_program_id IN (3742, 3869) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 10929 AND
	created >= '2010-02-08';

/* April 2 2010, Jan, ticket: #4786
Aanvrager: Wouter Groenewoud

Welk type staffel is het (maak 1 keuze)?
2) Prijsvergelijk (6387) moet in staffel 3869 beginnen. Echter wanneer er meer dan 19 sales zijn moet hij naar programma 3870 gaan.
*/
UPDATE
	lead
SET
	lead_program_id = 3869
WHERE
	lead_program_id IN (3742) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6387;
	
/* January 22 2010, Jan, ticket: #4488
Aangevraagd door: Wouter G.
Zou je de volgende staffel voor bikesplaza (17443) erin kunnen zetten?

Adverteerder staat nog niet live, maar wil deze morgen live zetten.

3742 (1 t/m 9 sales)  
3869 (10 t/m 19 sales)
3870 (20 sales+)    
*/

UPDATE
	lead
SET
	lead_program_id = 3870
WHERE
	lead_program_id IN (3742, 3869) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3742, 3869, 3870) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(id) >= 20);
			
UPDATE
	lead
SET
	lead_program_id = 3869
WHERE
	lead_program_id IN (3742) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3742, 3869, 3870) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(id) BETWEEN 10 AND 19);	