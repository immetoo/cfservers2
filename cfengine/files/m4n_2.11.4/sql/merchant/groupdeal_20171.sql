/* May 18 2010, Jan, ticket: #5108
Zou jij de volgende staffel voor GroupDeal kunnen implementeren? (id 20171)

Sale waarbij prijs < 15,0 - lp 4372
Sale waarbij prijs => 15 < 40 - lp 4373
Sale waarbij prijs => 40 - lp 4374

Volgens mij had ik deze nog niet doorgegeven, maar deze adverteerder staat wel al live :).
*/

/* Sale waarbij prijs => 15 < 40 - lp 4373 */
UPDATE
	lead
SET
	lead_program_id = 4373
WHERE
	lead_program_id = 4372 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	price >= 15 AND price < 40;

/* Sale waarbij prijs => 40 - lp 4374 */ 
UPDATE
	lead
SET
	lead_program_id = 4374
WHERE
	lead_program_id IN (4372, 4373) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	price >= 40;
	
