/* Jul 9 2010, ticket: #5497
Zou jij vanaf 1 juli (dus met terugwerkende kracht) alle binnengekomen leads op ID 4407 kunnen laten landen op lead ID 3478?

Het gaat om adverteerder E.ON (16352).
*/

UPDATE
	lead
SET
	lead_program_id = 3478
WHERE
	lead_program_id = 4407 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-07-01';
	