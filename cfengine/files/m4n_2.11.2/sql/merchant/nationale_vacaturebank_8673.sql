/* December 29 2010, Jan, ticket: #6492
Requested by: Leonne

Leads from affiliate Werksite(6948) for Nationale Vacaturebank (8673) that have been registered through advertisement 685752 should be moved from
lead program 1347 to lead program 6093.
*/

UPDATE
	lead
SET
	lead_program_id = 6093
FROM
	click
WHERE
	click.id = click_id AND
	lead.lead_program_id = 1347 AND
	click.advertisement_id = 685752 AND
	lead.affiliate_id = 6948 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.created >= '2010-12-01';