/* November 30 2010, Jan, ticket: #6374
Zou je alle leads die binnenkomen op zone ID 836589  om willen zetten naar leadprogramma 5032?
*/
UPDATE
	lead
SET
	lead_program_id = 5032
FROM
	click
WHERE
	click.id = click_id AND
	lead_program_id = 4895 AND
	zone_id = 836589 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.created >= '2010-11-29';