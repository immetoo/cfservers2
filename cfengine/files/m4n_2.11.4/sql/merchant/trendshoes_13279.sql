/* September 15 2010, Jan, ticket: #5909
Zou jij voor mij de volgende staffel kunnen instellen voor adverteerder Trenshoes (ID 13279)

Lp ID: 2800 --> 1-10 sales (7%)
LP ID: 4801 --> 10-40 sales (8%)
LP ID: 4802 --> 40+ sales (9%)

Mag ingaan per vandaag.
*/

/* LP ID: 4801 --> 10-40 sales (8%) */
UPDATE
	lead
SET
	lead_program_id = 4801
WHERE
	lead_program_id = 2800 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-09-14' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (2800, 4801, 4802) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created >= '2010-09-14'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) BETWEEN 10 AND 39
	);

/* LP ID: 4802 --> 40+ sales (9%) */
UPDATE
	lead
SET
	lead_program_id = 4802
WHERE
	lead_program_id IN (2800, 4801) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-09-14' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (2800, 4801, 4802) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created >= '2010-09-14'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 40
	);