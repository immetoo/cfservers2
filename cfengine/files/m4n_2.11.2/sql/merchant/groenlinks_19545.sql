/* April 29 2010, Jan, ticket: #4915
Aanvrager: Daan Donders
Adverteerder: Groenlinks
ID Adverteerder: 19545

Exploitanten (in geval van special deal. Username + id):
Euroclix       105

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
4149 -> 4337
special deal Euroclix

Wat moet er precies gebeuren?
Er moet een special deal aangemaakt worden voor Euroclix, met een vergoeding van €18,- i.pv. €11,50

Startdatum: 29-4-2010
Einddatum:  29-4-2011
*/

UPDATE 
    lead 
SET 
    lead_program_id = 4337
WHERE 
	lead_program_id = 4149 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 105 AND
	created >= '2010-04-29' AND
	created < '2011-04-29';