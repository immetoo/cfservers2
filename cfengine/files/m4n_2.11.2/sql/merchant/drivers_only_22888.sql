/* November 29 2010, Jan, ticket: #6351
Kun jij een special deal aanmaken voor MoneyMiljonair (307) voor de adverteerder DriversOnly (22888).

Leadprogramma 4924 op ID 5020
Leadprogramma 4925 op ID 5021
*/
UPDATE
	lead
SET
	lead_program_id = 5020
WHERE 
	lead_program_id = 4924 AND
	affiliate_id = 307 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
UPDATE
	lead
SET
	lead_program_id = 5021
WHERE 
	lead_program_id = 4925 AND
	affiliate_id = 307 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);