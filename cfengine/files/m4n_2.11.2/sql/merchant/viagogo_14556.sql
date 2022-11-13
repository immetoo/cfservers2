/*July 27th 2010, Jan, ticket: #5587
Adverteerder: Viagogo
ID Adverteerder: 14556

Welk type staffel is het (maak 1 keuze)?
Special deal

Affiliate:  leadmedia 9321

Wat moet er precies gebeuren?
Affiliate krijgt standaard een hogere staffel   3222 à 3850

Startdatum:26-7-2010
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 3850
WHERE
	lead_program_id IN (3222) AND
	affiliate_id = 9321 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-07-26';


/* May 11 2010, Dineke, Ticket #5032:
Reported by Fleur:

Welk type staffel is het (maak 1 keuze)?
Special deal

Affiliate: Midsol ID 8106
 * May 14 2010, Dineke Ticket #5074:
 * Reported by Fleur: added affiliate Marca (10315) to deal, starting May 10th
 * 
Wat moet er precies gebeuren?

Affiliate krijgt standaard de hogere staffel 3222à 3221

Startdatum: 3-5-2010
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 3221
WHERE
	lead_program_id IN (3222) AND
	affiliate_id IN (8106, 10315) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-05-10';

/* May 18th 2010, Dineke: Ticket #5098:
Reported by Fleur:
Affiliate Marca's leads can be promoted to lead_program 4411, but only when
the referrer of the click is 'concertkaartjesonline.nl'
*/
UPDATE
	lead
SET
	lead_program_id = 4411
FROM
	click
WHERE
	lead_program_id IN (3222, 3221) AND
	lead.affiliate_id = 10315 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click.id = click_id AND
	click.referrer LIKE '%concertkaartjesonline.nl%' AND
	lead.created > '2010-05-10';

/* July 5, Dineke, Ticket #5476:
 * Requested by Fleur:
 * Bovenstaande staffel wijzigt aangezien er onderscheid wordt gemaakt op website niveau. Er zijn 2 websites bijgekomen voor een nieuwe LP ID
Affiliate:  Marca 10315

Wat moet er precies gebeuren?
Verschillende vergoeding per website

Huidig

www.ticketstarter.nl ( en evt overig) : 3222 à 3221  ( onderstaande staffel)
www.concertkaartjesonline.nl    3222 à 4411

Nieuw: cabaretkaartjesonline.nl + soccertickets.nl = 3222à 4596  met ingang van 1-7-2010
 */
UPDATE
	lead
SET
	lead_program_id = 4596
FROM
	click
WHERE
	lead_program_id IN (3222, 3221) AND
	lead.affiliate_id = 10315 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click.id = click_id AND
	(click.referrer LIKE '%cabaretkaartjesonline.nl%' OR
	 click.referrer LIKE '%soccertickets.nl%') 	AND
	lead.created > '2010-07-01';
