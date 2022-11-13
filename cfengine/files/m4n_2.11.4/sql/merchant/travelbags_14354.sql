/* October 22 2009, Dineke:
Reported by Liesbeth:
Kun jij leadprogramma 3495 van Travelbags 14354
koppelen aan affiliate id 7905.

Update April 20 2010, Jan, ticket: #4841
Added Fashionchick(8880) to the deal.

Update December 14 2010, Jan, excluded zone ID 489326 from the deal for Fashionchick
*/

UPDATE 
    lead 
SET 
    lead_program_id = 3495
WHERE 
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 14354 AND id != 3495) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (7905);

UPDATE 
    lead 
SET 
    lead_program_id = 3495
FROM
	click
WHERE 
	lead.click_id = click.id AND
	lead.lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 14354 AND id != 3495) AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.affiliate_id = 8880 AND
	click.zone_id != 489326;