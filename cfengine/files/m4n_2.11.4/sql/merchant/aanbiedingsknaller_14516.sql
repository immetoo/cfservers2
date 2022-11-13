/* January 29 2010, Jan, ticket: #4522
Aanvrager: Wouter Groenewoud
Adverteerder: Aanbiedingsknaller
ID Adverteerder: 14516

Welk type staffel is het (maak 1 keuze)?
2) Staffel voor alle affiliates

Lead programma's ID of advertentie ID (oud en nieuw): 
Als er een lead binnenkomt op ID 3902 hoger dan €100,- moet dit ID 3901 worden
Als er een lead binnenkomt op ID 3904 hoger dan €100,- moet dit ID 3903 worden
Als er een lead binnenkomt op ID 3906 hoger dan €100,- moet dit ID 3905 worden

Wat moet er precies gebeuren?
Leads die binnenkomen op ID 3902,3904 en 3906 moeten boven de €100,- naar 3901,3903 en 3905 worden gezet,
omdat er dan een andere commissie geldt.

Startdatum: 29-01-2010
Einddatum: geen
*/

UPDATE
	lead
SET
	lead_program_id = 3901
WHERE
	lead_program_id = 3902 AND
	price > 100 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-01-29';
	
UPDATE
	lead
SET
	lead_program_id = 3903
WHERE
	lead_program_id = 3904 AND
	price > 100 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-01-29';

UPDATE
	lead
SET
	lead_program_id = 3905
WHERE
	lead_program_id = 3906 AND
	price > 100 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-01-29';
	
/**
 * #Ticket 3667 - Echte staffel - Andre Cesta 2009-08-11. 
 */
UPDATE
	lead
SET
	lead_program_id = 3225
WHERE
	lead_program_id = 3194 AND
	price < 100 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2009-08-12';
