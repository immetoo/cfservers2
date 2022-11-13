/* March 10 2011, Jan, ticket: #7022
Kan jij Gratiz 128 koppelen aan lpid 6327? Het oorspronkelijke lpid waar deze leads op binnen komen is 4375. Dit zijn namelijk 
nieuwsbriefinschrijvingen.

Kan jij Clansman 630 en Promodeals 10963 koppelen aan lpid 6327? Het oorspronkelijke lpid waar deze leads op binnen komen is 4375. 
*/
UPDATE
	lead
SET
	lead_program_id = 6327
WHERE
	lead_program_id = 4375 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (128, 630, 10963) AND
	created >= '2011-03-09';

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
	
/* March 23 2011, Jan, ticket: #7066
Kan je in het programma van Groupdeal (20171):

afiiliate Main Adv. ( 26593 ) toevoegen aan de volgende lpid's:

- 6136
- 6228
- 6229

Startdatum is 15 maart.
*/
UPDATE
	lead
SET
	lead_program_id = 6136
WHERE
	lead_program_id IN (4372, 4373, 4374, 6228, 6229) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 26593 AND 
	created >= '2011-03-15' AND
	price < 15;

/* Sale waarbij prijs => 15 < 40 - lp 6228 */
UPDATE
	lead
SET
	lead_program_id = 6228
WHERE
	lead_program_id IN (4372, 4373, 4374, 6136, 6229) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 26593 AND 
	created >= '2011-03-15' AND
	price >= 15 AND price < 40;
	
/* Sale waarbij prijs => 40 - lp 6229 */
UPDATE
	lead
SET
	lead_program_id = 6229
WHERE
	lead_program_id IN (4372, 4373, 4374, 6136, 6228) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 26593 AND 
	created >= '2011-03-15' AND
	price >= 40;

