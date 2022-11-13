/* July 12 2010, Jan, ticket: #5504
Jeansonline (ID 9675) heeft een special deal met Fashionchick waarin ze alleen €0,15 CPC vergoeding betalen.
Kun jij leadprogramma ID 4612  koppelen aan het account van Fashionchick: ID 8880
Daar staat de vergoeding van de affiliates op 0. 

Update December 14 2010, Jan, Excluded zone 350753 from the deal
*/
UPDATE
	lead
SET
	lead_program_id = 4612
FROM
	click
WHERE
	lead.click_id = click.id AND
	lead.lead_program_id = 1618 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.affiliate_id = 8880 AND
	click.zone_id != 350753;
	
/* August 12 2009, Dineke:
Reported by Liesbeth:
Zou jij de affiliates

Welovesites (9070)
Winkelpower (52)
en Fashionchick (8880)

kunnen koppelen aan offerid 3224 van adverteerder Jeansonline (9675).

Per direct!
**/

UPDATE
	lead
SET
	lead_program_id = 3224
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 9675 AND id != 3224) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (52, 9070) AND
	created > '2009-08-12';

/* January 21 2011, Jan, ticket: #6622
Kun jij affiliate Ilse Media (ID 430) hangen aan lp 6187 van adverteerder Jeansonline ID 9675

Looptijd: 22/01 t/m 31/01.
*/
UPDATE
	lead
SET
	lead_program_id = 6187 
WHERE
	affiliate_id = 430 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 1618 AND
	created >= '2011-01-22' AND
	created < '2011-02-01';