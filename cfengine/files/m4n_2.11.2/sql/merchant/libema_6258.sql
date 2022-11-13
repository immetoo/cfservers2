/* July 28th 2010, Jan, ticket: #5601
Aanvrager: Wouter

Exploitanten (in geval van special deal. Username + id):
hansrinsma (5133)

Welk type staffel is het (maak 1 keuze)?
1) special deal

Wat moet er precies gebeuren?
Leads verplaatsen naar lpid 2617

Startdatum: 28/07/2010
Einddatum: 28/07/2012
*/

UPDATE 
	lead
SET 
	lead_program_id = 2617
WHERE
	lead_program_id IN (1228, 4032, 4033) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id  = 5133 AND
	created >= '2010-07-28' AND
	created < '2012-07-28';

/* June 30 2010, Dineke:
Aanvrager: wouter

Exploitanten (in geval van special deal. Username + id):
* sizl: 630

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Wat moet er precies gebeuren?
Update leads from this user to highest lead_program, 2617.
*/
UPDATE
	lead
SET
	lead_program_id = 2617
WHERE
	lead_program_id IN (1228, 4032, 4033) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (630);

/* March 21 2011, Dineke, #7072:
 * Aanvrager: Liesbeth

Exploitanten (in geval van special deal. Username + id): Vakantieparken.nl (id 16709)

Welk type staffel is het (maak 1 keuze)?

2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 6371 1228

Wat moet er precies gebeuren? Alle sales van vakantieparken.nl (id 16709) moeten in lp 6371 vallen.

Startdatum: 17-03-2011
Einddatum: oneindig
*/
UPDATE
	lead
SET
	lead_program_id = 6371
WHERE
	lead_program_id IN (SELECT lead_programs(6258)) AND
	lead_program_id != 6371 AND
	affiliate_id = 16709 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2011-03-17';