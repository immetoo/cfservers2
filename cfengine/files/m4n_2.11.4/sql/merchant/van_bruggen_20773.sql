/* June 18 2010, Jan, ticket: #5373
Kan jij deze er in zetten voor Van Bruggen (20773)?
1-24 leads -> 4498
 25+ leads -> 4530
*/

UPDATE
	lead
SET
	lead_program_id = 4530
WHERE
	lead_program_id IN (4498) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED') AND
	click_created < '2011-02-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4498, 4530) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-02-01' AND
			status IN ('ACCEPTED')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) >= 25
	);