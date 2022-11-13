/* June 7 2010, Jan, ticket: #5294
Aanvrager: Robert Oerlemans
Adverteerder:Pvda
ID Adverteerder: 20398

Exploitanten (in geval van special deal. Username + id):
Money Miljonair 307

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
4417 Special Deal Money Miljonair

Wat moet er precies gebeuren?
Er moet een special deal aangemaakt worden voor Money Miljonair

Startdatum: 4 Juni
Einddatum: Geen
*/

UPDATE
	lead
SET
	lead_program_id = 4417
WHERE
	lead_program_id = 4418 AND
	affiliate_id = 307 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false); 