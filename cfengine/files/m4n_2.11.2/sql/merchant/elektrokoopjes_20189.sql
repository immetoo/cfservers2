/* June 9 2010, Jan, ticket: #5313
Kun je voor mij een special deal aanmaken voor Kortingkorting (8420) Deze is bedoeld voor elektrokoopjes (20189)

Leads van Kortingkorting (5420) mogen bij Elektrokoopjes (20189) dus binnen komen op (8420)
 
Startdatum is: 1 juli 2010 
*/

UPDATE
	lead
SET
	lead_program_id = 4495
WHERE
	lead_program_id = 4367 AND
	affiliate_id = 8420 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-06-01';
		
/* November 8 2010, Jan, ticket: #6214
Aanvrager: Wouter G.
Zou de volgende staffel kunnen worden geïmplementeerd voor Elektrokoopjes 20189

Lead ID 4366  5 of minder leads
Lead ID 4947 5 t/m 9 leads
Lead ID 4948 10 leads of meer

Met ingang van maandag 8 november 
*/

/* Lead ID 4947 5 t/m 9 leads */
UPDATE
	lead
SET
	lead_program_id = 4947
WHERE
	lead_program_id = 4367 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-10-01' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4367, 4947, 4948) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			click_created < '2011-01-01' AND
			created >= '2010-10-01'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 5 AND
			COUNT(id) < 10
	);

/* Lead ID 4948 10 leads of meer */
UPDATE
	lead
SET
	lead_program_id = 4948
WHERE
	lead_program_id IN (4367, 4947) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-10-01' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4367, 4947, 4948) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			click_created < '2011-01-01' AND
			created >= '2010-10-01'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 11
	);