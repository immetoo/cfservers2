/* December 7 2010, Jan, ticket: #6414
Zou jij affiliate Fashionchick (ID 8880) willen hangen aan lp 5038 van adverteerder Dressesonly (ID 11845)

Periode: 01-12-2010 tot 01-01-2011.

Zou jij ook de volgende zone ID's kunnen koppelen aan leadprogramma 2325.
489787
746506

Update: February 23 2011, Jan, extended special deal until 1-4-2011.
*/

UPDATE
	lead
SET
	lead_program_id = 5038
FROM
	click
WHERE
	lead.click_id = click.id AND
	lead.lead_program_id = 2325 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.affiliate_id = 8880 AND
	click.zone_id NOT IN (489787, 746506) AND
	lead.created >= '2010-12-01' AND
	lead.created < '2011-04-01';