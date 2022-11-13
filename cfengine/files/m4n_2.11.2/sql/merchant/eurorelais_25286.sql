/* February 22 2011, Dineke, #6854
Aanvrager: Liesbeth

Exploitanten (in geval van special deal. Username + id): eRCeeMedia, id 14580

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): lp 6072, 6087 en 6280

Wat moet er precies gebeuren? Alle sales die normaal op 6072 of 6087 binnenkomen, moeten op 6280 worden gezet.

Startdatum: 22-02-2011 Einddatum: t/m 31-05-2011
*/
UPDATE
	lead
SET
	lead_program_id = 6280
WHERE
	lead_program_id IN (6072, 6087) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 14580 AND
	created BETWEEN '2011-02-22' AND '2011-06-01';