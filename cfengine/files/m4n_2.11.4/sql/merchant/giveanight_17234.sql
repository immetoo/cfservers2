/* April 29 2010, Dineke, Ticket #4920
SAME AS DEAL BELOW, CAN BE MERGED AFTER 2 MONTHS
Aanvrager: Fleur

Welk type staffel is het (maak 1 keuze)?
Special deal 

Affiliate: bon-cadeau ( 5253)

Wat moet er precies gebeuren?
Affiliate  bon-cadeau ( 5253) krijgt standaard de hogere staffel 3841 ipv standaard 3695

Startdatum: 29-4-2010
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 3841
WHERE
	lead_program_id = 3695 AND
	affiliate_id = 5253 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-04-29';
 

/* #4521 January 29 2010, Dineke:

Aanvrager: Fleur
Adverteerder: giveanight

ID Adverteerder: 17234

Welk type staffel is het (maak 1 keuze)?
Specials deal

Affiliate: 37cadeau (8131)

Wat moet er precies gebeuren?
Standaard in de hoogste staffel
3695à 3841

Startdatum: 25-1-2010 ( dus graag met terugwerkende kracht)
Einddatum: nvt
*/
UPDATE
	lead
SET
	lead_program_id = 3841
WHERE
	lead_program_id = 3695 AND
	affiliate_id = 8131 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
