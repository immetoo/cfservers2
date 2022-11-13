/* September 9 2009, Dineke, Ticket #3791:
 * reported by Jesse
 * Zou je aff ID mickey123(11015) kunnen koppelen aan offid 3304 bij klant Shopkorting(12307). Per morgen aub.
*/

UPDATE
	lead
SET
	lead_program_id = 3304 
WHERE
	affiliate_id = 11015 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 12307 AND id != 3304) AND
	created > '2009-09-10';
	
/* August 207 2010, Dineke, requested by Diederick:
Kun je de leads die voor de adverteerder Shopkorting.nl uit de account van Media inkoop VA komen op leadprogramma 4771 laten binnen komen?

August 27 2010, Jan, requested by Tim: 
Alle leads van Beverly Hills Edition (ID: 19610) voor adverteerders Shopkorting (ID:12307) standaard in leadprogramma 4771.
*/
UPDATE
	lead
SET
	lead_program_id = 4771
WHERE
	affiliate_id IN (17063, 19610) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 12307 AND id != 4771);
 