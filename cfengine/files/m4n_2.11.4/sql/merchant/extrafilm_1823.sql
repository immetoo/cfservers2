/* February 15 2010, Jan, ticket: #4593
Aanvrager: Wouter Groenewoud

Adverteerder: Extrafilm
ID Adverteerder: 1823

Welk type staffel is het (maak 1 keuze)?
2) Staffel voor alle affiliates

Lead programma's ID of advertentie ID (oud en nieuw): 
oude programma
489         €6,50 vergoeding.

Nieuw:
489       € 7,- vergoeding  (cijfer 5)
3965      € 5,- vergoeding  (cijfer 1)
3967      € 4,-  vergoeding (cijfer 2)
3968      € 3,- vergoeding  (cijfer 3)
3969      € 2,- vergoeding  ( cijfer 4)

Wat moet er precies gebeuren?
Extra film geeft in beschrijving 2 een cijfer mee 1 t/m, 5 . Dit cijfer geeft aan in welk leadprogramma de lead moet vallen.  

Startdatum: 10-02-2010
Einddatum: geen
*/

/* 3965      € 5,- vergoeding  (cijfer 1) */
UPDATE
	lead
SET
	lead_program_id = 3965
WHERE
	lead_program_id = 489 AND
	description2 = '1' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-02-10';

/* 3967      € 4,-  vergoeding (cijfer 2) */
UPDATE
	lead
SET
	lead_program_id = 3967
WHERE
	lead_program_id = 489 AND
	description2 = '2' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-02-10';

/* 3968      € 3,- vergoeding  (cijfer 3) */
UPDATE
	lead
SET
	lead_program_id = 3968
WHERE
	lead_program_id = 489 AND
	description2 = '3' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-02-10';
	
/* 3969      € 2,- vergoeding  ( cijfer 4) */
UPDATE
	lead
SET
	lead_program_id = 3969
WHERE
	lead_program_id = 489 AND
	description2 = '4' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-02-10';