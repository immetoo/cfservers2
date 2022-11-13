--Store the leads which are in stock at a certain moment. Must be run at least monthly, right at the beginnen of the new payment period.
INSERT INTO
	history.in_stock (created, payment_period_id, merchant_id, status, number_of_leads, lead_cost, lead_reward)
(SELECT
	now(),
	(SELECT max(id) FROM payment_period),
	merchant_id,
	status,
	COUNT(*),
	SUM(cost),
	SUM(reward)
FROM
	lead,
	lead_program
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program.id = lead_program_id
GROUP BY
	status,
	merchant_id);