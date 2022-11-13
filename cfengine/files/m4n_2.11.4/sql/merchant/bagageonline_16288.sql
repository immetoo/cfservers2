/* July 29th 2010, Jan, ticket: #5603
Aanvrager:Karin
Adverteerder: Bagageonline
ID Adverteerder: 16288

Exploitanten (in geval van special deal. Username + id): 37cadeau id: 8131

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): Leadprogramma ID 3994

Wat moet er precies gebeuren?
Er moet een special deal aangemaakt worden van bagageonline, voor de affiliate sebastiaanjump2jobs.
De vergoeding van de special deal moet 8% worden in plaats van 7%

Startdatum: 29 Juli 2010
Einddatum:  22 Februari 2012

3457 -> 3994
*/
UPDATE
	lead
SET
	lead_program_id = 3994
WHERE
	lead_program_id = 3457 AND
	affiliate_id = 8131 AND
	created < '2012-02-22' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* May 25 2010, Jan, ticket: #5146
Aanvrager:Bagageonline
 
Exploitanten (in geval van special deal. Username + id):
MasterCard/MXM                      13283

Welk type staffel is het (maak 1 keuze)?
2) Special deal
 
Lead programma's ID of advertentie ID (oud en nieuw): 
ID leadprogramma 4426

Wat moet er precies gebeuren?
Er moet een special deal worden aangemaakt voor de exploitant.
En de special deal moet gelden voor  1 product.
De adverteerder geeft de volgende waardes mee in description2.
Als de waarde 1 heeft, dat betekent dat men in ieder geval het desbetreffende product heeft gekocht. Waarde 0 is het product niet gekocht. 
 
Startdatum:    21 Mei 2010
Einddatum:     18 Juni 2010
*/
UPDATE
	lead
SET
	lead_program_id = 4426
WHERE
	lead_program_id = 3457 AND
	affiliate_id = 13283 AND
	created >= '2010-05-21' AND
	created < '2010-06-18' AND
	description2 = '1' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);