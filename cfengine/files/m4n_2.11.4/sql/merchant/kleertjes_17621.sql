/* July 6 2010, Jan, ticket: #5484
Zou jij alle sales van kleertjes.com (id 17621) voor besteconsumentenkoop (id 9181) automatisch in lp 4212 kunnen laten vallen?
De eerste sale hiervan is 7 juni binnengekomen. Graag alle sales aanpassen.
*/
UPDATE
	lead
SET
	lead_program_id = 4212
WHERE
	lead_program_id IN (3803, 4211, 4210) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-06-07' AND
	affiliate_id = 9181;


/* April 12 2010, Jan, ticket: #4806
Zou jij de volgende staffel voor Kleertjes.com (id 17621) kunnen aanmaken:

Standaard: lp 3803
21 t/m 40 sales: lp 4211
41 t/m 100 sales: lp 4210
101 en meer sales: lp 4212 

Alles weer op bruto sales, dus alle statussen behoren tot de verhoging van een staffel. 
De staffel moet op 1 mei in gaan.
*/
UPDATE
	lead
SET
	lead_program_id = 4211
WHERE
	lead_program_id IN (3803) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-05-01' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3803, 4211, 4210, 4212) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			click_created < '2011-01-01' AND
			created >= '2010-05-01'
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) BETWEEN 21 AND 40
	);

/* 41 t/m 100 sales: lp 4210 */
UPDATE
	lead
SET
	lead_program_id = 4210
WHERE
	lead_program_id IN (3803, 4211) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-05-01' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3803, 4211, 4210, 4212) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			click_created < '2011-01-01' AND
			created >= '2010-05-01'
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) BETWEEN 41 AND 100
	);
	
/* 101 en meer sales: lp 4212 */
UPDATE
	lead
SET
	lead_program_id = 4212
WHERE
	lead_program_id IN (3803, 4211, 4210) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-05-01' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3803, 4211, 4210, 4212) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			click_created < '2011-01-01' AND
			created >= '2010-05-01'
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) > 100
	);