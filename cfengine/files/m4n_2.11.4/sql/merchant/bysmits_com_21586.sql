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