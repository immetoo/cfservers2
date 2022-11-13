/* August 31, Dineke: Ticket #5785
Aanvrager: Fleur

Welk type staffel is het (maak 1 keuze)?
Vergoeding is afhankelijk van de order waarde:

Dus afhankelijk van de “price”moet den LPid geslecteerd worden

* 0-100 euro = 4535
* 101-200 euro = 4559
* 201 of meer = 4560

Startdatum:26-6-2010 ( dus graag met terugwerkende kracht)
Einddatum: nvt
*/
UPDATE
	lead
SET
	lead_program_id = 4559
WHERE	
	lead_program_id IN (4535, 4560) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	price >= 101 AND price < 201;

UPDATE
	lead
SET
	lead_program_id = 4560
WHERE	
	lead_program_id IN (4535, 4559) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	price >= 201;