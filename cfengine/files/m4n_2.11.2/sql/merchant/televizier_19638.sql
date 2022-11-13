/* June 1st 2010, Dineke, #5258:
 * Aanvrager: Fleur

Special deal
Affiliate Euroclix (105)  krijgt standaard de hogere staffel 4456 ipv 4180

Startdatum: 1-6-2010
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 4456
WHERE
	affiliate_id = 105 AND
	lead_program_id = 4180 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-06-01';
	

/* April 22 2010 Dineke #4866
Aanvrager: Fleur

Adverteerder: Televizier
ID Adverteerder: 19638

Welk type staffel is het (maak 1 keuze)?
Special deal

Affiliate: Money Miljonair (307)  

Wat moet er precies gebeuren?
Affiliate Money Miljonair (307)  krijgt standaard de hogere staffel (4317) ipv 4180

Startdatum: 20-4-2010
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 4317
WHERE
	affiliate_id = 307 AND
	lead_program_id = 4180 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-04-20';
	
/* April 23 2010 Dineke
Aanvrager: Fleur

Welk type staffel is het (maak 1 keuze)?
Special deal

Affiliate: actieplein 17162

Wat moet er precies gebeuren?

Affiliate actieplein (17162)  krijgt standaard de hogere staffel (4322) ipv 4180

Startdatum: 20-4-2010
Einddatum: NVT
*/
 UPDATE
	lead
SET
	lead_program_id = 4322
WHERE
	affiliate_id = 17162 AND
	lead_program_id = 4180 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-04-20';