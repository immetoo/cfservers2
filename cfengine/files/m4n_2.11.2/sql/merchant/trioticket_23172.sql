/* March 21 2011, Dineke, #7080:
 *
 *Adverteerder: Trioticket ID Adverteerder: 23172 Welk type staffel is het (maak 1 keuze)? Special deal

Wat moet er precies gebeuren?

Voor sales met description 2 FashionDays? April 2011 geldt:

4984 à 6360 Startdatum: 14-3-2011 Einddatum:4-4-2011
*/
UPDATE
	lead
SET	
	lead_program_id = 6360
WHERE
	lead_program_id = 4984 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	description2 LIKE '%FashionDays%' AND
	created BETWEEN '2011-03-14' AND '2011-04-05';
	