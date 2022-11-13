/* October 26 2010, Jan, ticket: #6131
Wil jij een staffel aanmaken voor ID 22797:

0 t/m 9 sales	: 	4892
10+ sales		:	4893
*/

UPDATE
	lead
SET
	lead_program_id = 4893
WHERE
	lead_program_id = 4892 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4892, 4893) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10
	);