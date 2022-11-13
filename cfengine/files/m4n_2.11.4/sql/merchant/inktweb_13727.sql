/* March 11 2010, Jan, ticket: #4706
Aanvrager:Leonne

Adverteerder:Inktweb
ID Adverteerder:13727

Exploitanten (in geval van special deal. Username + id):Euroclix + ID 105

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):Lead programma ID:4059   

Wat moet er precies gebeuren? Euroclix krijgt een hogere vergoeding voor hun mailing. Zij moeten op deze speciale deal komen te staan automatisch.

Startdatum: 15/03/2010
Einddatum: 15/03/2011
*/

UPDATE
	lead
SET
	lead_program_id = 4059
WHERE
	lead_program_id = 2966 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 105 AND
	created >= '2010-03-15' AND
	created < '2011-03-15';