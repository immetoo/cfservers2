/* January 21 2011, Jan, ticket: #6620

Zou jij de volgende special deal willen aanmaken?
Graag het account van Fashionchick (ID 8880) hangen aan leadprogramma 6186.
Deze leads krijgen nu standaard 0% CPA vergoeding toch?
Ze gebruiken namelijk de datafeed waar 0,15 CPC vergoeding aan hangt.

Looptijd: 24/01/11 tot 24/04/11
Update January 28 2011, Excluded zone from deal.
*/
UPDATE
	lead
SET
	lead_program_id = 6186 
FROM
	click
WHERE
	lead.click_id = click.id AND
	lead.affiliate_id = 8880 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 4937 AND
	lead.created >= '2011-01-24' AND
	lead.created < '2011-04-24' AND
	click.zone_id != 859289;
	
/* January 28 2011, Jan, ticket: #6657

Zou jij de volgende affiliates kunnen hangen aan lpid 6203 van adverteerder Sjoez (ID 22915).

Affiliates:
Welovesites (ID 9070)
Fashionsites (6059)

Per direct, 28 januari 2011.

*/
UPDATE
	lead
SET
	lead_program_id = 6203 
WHERE
	affiliate_id IN (6059, 9070) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 4937 AND
	created >= '2011-01-28';
	
/* March 16 2011, Jan, ticket: #7055
Kan jij Twenga (id: 11672) in de special deal zetten van Sjoez.nl (id: 22915)?

Graag van het standaard leadprogramma (id: 4937 ) naar de special deal (id: 6362 ) per vandaag 15.03.2011.
*/
	
UPDATE
	lead
SET
	lead_program_id = 6362 
WHERE
	affiliate_id = 11672 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 4937 AND
	created >= '2011-03-15';