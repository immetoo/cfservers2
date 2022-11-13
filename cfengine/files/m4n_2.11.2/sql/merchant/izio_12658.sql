/* March 17 2010, Jan, ticket: #4717
Aangevraagd door: Bart
Kan jij deze staffel aanmaken bij iZio (12658) waarbij 3793 de basis is.

3793 - 0 t/m 5 sales
4072 - 6 t/m 10 sales
4073 - > 10 sales

Dit mag per 12 maart 2010.

Update March 30 2010, Jan: adjusted start date to the 1st of March.
*/

UPDATE
	lead
SET
	lead_program_id = 4072
WHERE
	lead_program_id = 3793 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-03-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3793, 4072, 4073) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			created >= '2010-03-01'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) BETWEEN 6 AND 10
	);
	
/* > 10 sales */

UPDATE
	lead
SET
	lead_program_id = 4073
WHERE
	lead_program_id IN (3793, 4072) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-03-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3793, 4072, 4073) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			created >= '2010-03-01'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 10
	);