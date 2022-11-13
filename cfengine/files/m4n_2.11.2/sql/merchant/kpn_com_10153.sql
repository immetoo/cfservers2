/* November 4 2010, Dineke, #6204:
 * Requested by Mirte:
 * Zou je alle leads die binnenkomen op zone ID 826101 van exploitant Zinngeld (ID 5575) omzetten naar leadprogramma ID 3900?
  (Mailing wordt morgen of zaterdag verstuurd)
*/
UPDATE
	lead
SET
	lead_program_id = 3900, description3 = lead_program_id::text
FROM
	click
WHERE
	click.merchant_id = 10153 AND
	click.id = click_id AND
	click.zone_id = 826101 AND
	lead_program_id != 3900 AND
	lead.affiliate_id = 5575 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

	
/* November 11 2009, Dineke: Zinngeld special deal for zone
Aanvrager: Mirte
clicks by Zinngeld (5575) from zone 826101 are changed to advertisement 412222 */
UPDATE 
	click
SET 
	advertisement_id = 412222
WHERE 
	advertisement_id NOT IN (412222) AND
	advertisement_id IN (SELECT id FROM advertisement WHERE merchant_id = 10153 AND status = 0) AND 
	affiliate_id IN (5575) AND
	zone_id = 826101 AND
	status = 'ACCEPTED' AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* December 20 2010, Dineke, #6473:
 * Requested by Patrick:
 * Zou je alle leads die binnenkomen voor exploitant Euroclix (105) kunnen omzetten naar leadprogramma ID 3993? for now until Feb. 1st:
*/
UPDATE
	lead
SET
	lead_program_id = 3993, description3 = lead_program_id::text, status = 'ACCEPTED'
WHERE
	lead_program_id IN (SELECT lead_programs(10153)) AND
	lead_program_id != 3993 AND
	lead.affiliate_id = 105 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-12-20' AND '2011-02-01';

	
/* December 20 2010, Dineke, #6473:
 * Requested by Patrick:
 * Zou je alle leads die binnenkomen voor exploitant Jiggy (11524) kunnen omzetten naar leadprogramma ID 3900? for now until Feb. 1st:
*/
UPDATE
	lead
SET
	lead_program_id = 3900, description3 = lead_program_id::text, status = 'ACCEPTED'
WHERE
	lead_program_id IN (SELECT lead_programs(10153)) AND
	lead_program_id != 3900 AND
	lead.affiliate_id = 11524 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-12-20' AND '2011-02-01';
	
/* October 26 2010, Dineke, #6130:
 * Special deal for mailing Interactieve TV from Moneymiljonair (307), 
 * zone_id 822066
 * October 27, requested by Mirte: also add zone_id 822772
 * December 20, Dineke, #6473: for now until Feb. 1st: upgrade all MoMo leads
 */
UPDATE
	lead
SET
	lead_program_id = 4896, description3 = lead_program_id::text, status = 'ACCEPTED'
WHERE
	lead.affiliate_id = 307 AND
	lead.payment_period_id IN (SELECT id FROM payment_period where processed = false) AND
	lead_program_id IN (SELECT lead_programs(10153)) AND
	lead_program_id != 4896 AND
	created BETWEEN '2010-12-20' AND '2011-02-01';
	
/* September 2 2010, Dineke: #5825
 * Hoi Dineke,
Wij hebben KPN.com via een vergelijker lopen namelijk Beslist.nl id 3987
Zou jij alle leads die via deze vergelijker binnenkomen op LP 4634 kunnen zetten.

Thanx!!
Met vriendelijke groet,
Patrick Emmen
Account Manager Telecom
*/
UPDATE
	lead
SET
	lead_program_id = 4634, description3 = lead_program_id::text
WHERE
	lead_program_id IN (SELECT lead_programs(10153)) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 3987;

/* July 27th 2010, Jan, ticket: #5584
 * Oktober 29, Dineke, Reported by Patrick: add affiliate 21058 to deal 
Reported by Patrick E.
Zou jij alle leads die binnenkomen via Kelkoo01 id 20988 voor KPN.com id 10153 op leadprogramma 4634 (o euro ) kunnen zetten. 
*/
UPDATE
	lead
SET
	lead_program_id = 4634, description3 = lead_program_id::text
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 10153 AND id != 4634) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (20988, 21058);

/* June 29 2009, Dineke:
Kan je voor KPN 10153 de sale programma’s 2429 + 2438  standaard € 100,- orderwaarde meegeven?
Met vriendelijke groet,

Tim Markestein */
UPDATE
	lead
SET
	price = 100
WHERE
	lead_program_id IN (2429, 2438) AND
	price != 100 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
