/* February 10 2011, Jan, ticket: #6757
Kan je Shopkorting (12307) toevoegen aan lpid:6244 bij adverteerder 112supplies (21218)?
*/
UPDATE
	lead
SET
	lead_program_id = 6244
WHERE
	lead_program_id = 4626 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 12307;