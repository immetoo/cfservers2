/**
* Staffel Ticketcounter
*
September 24 2010, Dineke, #5942
Requested by Fleur:

Welk type staffel is het (maak 1 keuze)?
Special deal

Affiliate: sizlsizl 630

Wat moet er precies gebeuren?
Affiliate krijgt standaard de hogere staffel
4285 à 4814

Startdatum:24-9
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 4814
WHERE
	lead_program_id = 4285 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 630 AND
	created > '2010-09-24';
	