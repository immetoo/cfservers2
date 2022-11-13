/* March 2 2010, Jan, ticket: #6889
Zou jij affiliate Fashionchick (ID 8880) en fashionsites (ID 6059) willen hangen aan lpid 6294 van adverteerder bySmits.com (ID 21586)

Ingangsdatum is: 15 mrt 2011. Einddatum onbekend.
Update March 14th, excluded advertisement 688479 from the deal 
*/

UPDATE
	lead
SET
	lead_program_id = 6294
FROM
	click
WHERE
	click.id = lead.click_id AND
	lead.lead_program_id = 4738 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.affiliate_id IN (8880, 6059) AND
	lead.created >= '2011-03-15' AND
	click.advertisement_id != 688479;

/* November 24 2010, Jan, ticket: #6336
Kun jij affiliate Fashion Media (ID 18620) standaard hangen aan lp ID 4998 van adverteerder bySmits.com (ID 21586)

Ingang: 9 nov. 2010. Geen einddatum.
*/

UPDATE
	lead
SET
	lead_program_id = 4998
WHERE
	lead_program_id = 4738 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 18620 AND
	created >= '2010-11-09';
	
/* November 26 2010, Jan, ticket: #6345
Kun jij de volgende special deal aanmaken.

Affiliate uggsfanzone (ID 22805) hangen aan

lpid: 5015 Special deal, 1-20 sales: 12,5%
lpid: 5016 Special deal, 20+ sales: 15%

Van adverteerder: bySmits (ID 21586)

Periode: 19-11-2010 t/m 31-01-2010
*/
	
UPDATE
	lead
SET
	lead_program_id = 5015
WHERE
	lead_program_id = 4738 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 22805 AND
	created >= '2010-11-19' AND 
	created < '2011-02-01';
	
/* December 14 2010, Jan, ticket: #6436
Zou jij affiliate Stribe (ID 21958) willen hangen aan lpid 6056
van adverteerder bySmits.com (ID 21586)
*/
	
UPDATE
	lead
SET
	lead_program_id = 6056
WHERE
	lead_program_id = 4738 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 21958;
	
/* March 23 2011, Jan, ticket: #7077
Zou jij affiliate uggsfanzone 22805 aan lpid 4998 van adverteerder bySmits (ID 21586) kunnen hangen.
Ingang: 1 maart 2011.
*/

UPDATE
	lead
SET
	lead_program_id = 4998
WHERE
	lead_program_id = 4738 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 22805 AND
	created >= '2011-03-01';