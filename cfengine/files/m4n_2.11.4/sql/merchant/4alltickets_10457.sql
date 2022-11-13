/* July 27th 2010, Jan, ticket: #5591
Adverteerder: 4Alltickets
ID Adverteerder: 10457

Welk type staffel is het (maak 1 keuze)?
Special deal

Affiliate:  lvelve ( 12914)

Wat moet er precies gebeuren?
Affiliate krijgt standaard de hogere staffel 1809 à 4646

Startdatum:27-7-2010
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 4646
WHERE
	lead_program_id IN (1809) AND
	affiliate_id = 12914 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-07-27';