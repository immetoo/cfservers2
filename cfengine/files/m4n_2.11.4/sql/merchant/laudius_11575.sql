/* October 26 2010, Jan, ticket: #6129
Staffelverzoek voor adverteerder Laudius (11575), geldig voor alle affiliates:

1 t/m 6 sales: 4887
7+ sales: 4889

Mag direct ingaan, maar ik verwacht de eerste conversies in januari 2011.
*/

UPDATE
	lead
SET
	lead_program_id = 4889
WHERE
	lead_program_id = 4887 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4887, 4889) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 7
	);