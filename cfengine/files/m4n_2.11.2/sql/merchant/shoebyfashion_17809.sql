/* May 31 2010, Jan, ticket: #5233
Zou jij alle sales die op clicks binnenkomen vanaf vandaag t/m 6 juni standaard in lp 3824 kunnen laten vallen (hoogste staffel)
*/
UPDATE
	lead
SET
	lead_program_id = 3824
WHERE
	lead_program_id IN (3820, 3823) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-05-31' AND
	created < '2010-06-07';
	
/* October 13th 2010, Jan, ticket: #6034
Zou jij affiliate E-commerce: ID 12961 willen koppelen aan leadprogramma 3824 van adverteerder Shoebyfashion (ID 17809)

Per 12 oktober 2010 aub.
*/
UPDATE
	lead
SET
	lead_program_id = 3824
WHERE
	lead_program_id IN (3820, 3823) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 12961 AND
	created >= '2010-10-12';
	
/* January 8 2010, Jan, ticket: #4452
Aanvrager: Liesbeth
Ook nog een staffel voor nieuwe adverteerder Shoebyfashion. Is nog niet live, dus kijk maar als je een keertje even tijd hebt.

Shoebyfashion (id 17809)

lp: 3820 Standaard 7,5 % commissie
lp: 3823 Meer dan  10 sales per maand 9% commissie
lp: 3824 Meer dan 20 sales per maand 11% commissie

Updated March 26 2010, Jan, 
Changed staffel so that it counts ACCEPTED, ON_HOLD and TO_BE_APPROVED leads.
*/ 
UPDATE
	lead
SET
	lead_program_id = 3823
WHERE
	lead_program_id IN (3820) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3820, 3823, 3824) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) BETWEEN 11 AND 20
	);
	

/* Meer dan 20 sales */
UPDATE
	lead
SET
	lead_program_id = 3824
WHERE
	lead_program_id IN (3820, 3823) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3820, 3823, 3824) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) > 20
	);