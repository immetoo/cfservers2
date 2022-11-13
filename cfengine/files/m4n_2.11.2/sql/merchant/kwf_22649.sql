/* October 26 2010, Jan, ticket: #6133
Kan je de affiliate Babyinfo (Id: 13576 ) standaard op het leadprogramma 4898 van adverteerder KWF (id: 22649)?
*/

UPDATE
	lead
SET
	lead_program_id = 4898
WHERE
	lead_program_id = 4858 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id = 13576;

	--October 29 2010, Dineke, requested by Tim: lead from jiggy get lp 4932
UPDATE
	lead
SET
	lead_program_id = 4932
WHERE
	lead_program_id IN (SELECT lead_programs(22649)) AND lead_program_id != 4932 AND
	created > '2010-10-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11524;