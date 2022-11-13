/* 18 August 2009, Dineke:
Reported by Liesbeth:
Moneymiljonair (307) krijgt een hogere vergoeding bij de Veronica campagne (id 14421)
Offerid 3240: EUR 4,50 voor bestellingen. 
*/
UPDATE
	lead
SET
	lead_program_id = 3240
WHERE
	affiliate_id = 307 AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 14421 AND id != 3240) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
/* January 11 2011, Jan, ticket: #6521
Zou jij in het account van Veronicamagazine (14421), Shopbuddie (14070) kunnen kunnen koppelen aan Lpid 6158
*/
UPDATE
	lead
SET
	lead_program_id = 6158
WHERE
	affiliate_id = 14070 AND
	lead_program_id = 3723 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);