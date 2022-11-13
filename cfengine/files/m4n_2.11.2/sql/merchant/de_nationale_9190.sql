/* December 17, Jan, ticket: #4388
Zou je vanaf 1 december alle sales die binnen komen bij de nationale (9190) op leadprogramma 1689 door kunnen sturen naar leadprogramma 3082?

Met vriendelijke groet,

Bart van Raak
*/
UPDATE
	lead
SET
	lead_program_id = 3082
WHERE
	lead_program_id = 1689 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2009-12-01';