/* March 24 2010, Jan, ticket: #4747
Special deal for Euroclix(105) starting 30-03-2010: all leads on 3419 are to be moved to 4090

Update March 24 2010, Jan
Added lead program 2129 to the deal
*/

UPDATE
	lead
SET
	lead_program_id = 4090
WHERE
	lead_program_id IN (3419, 2129) AND
	affiliate_id = 105 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-03-30';

/* April 2 2010, Jan, ticket: #4782
Reported by Bart
kan jij deze staffel er in zetten bij MoneYou (11503), waarbij 2129 de basis is.

2129 1-15 sales
4141 16-30 sales
4142 30+ sales
*/
UPDATE
	lead
SET
	lead_program_id = 4141
WHERE
	lead_program_id IN (2129) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-02-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (2129, 4141, 4142) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-02-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING
			COUNT(id) BETWEEN 16 AND 30
	);
	
/* 4142 30+ sales */
UPDATE
	lead
SET
	lead_program_id = 4142
WHERE
	lead_program_id IN (2129, 4141) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-02-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (2129, 4141, 4142) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-02-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING
			COUNT(id) > 30
	);