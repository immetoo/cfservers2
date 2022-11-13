/* February 15 2011, Jan, ticket: #6804
Aanvrager: Diederick Ubels

Adverteerder: Thuisapotheek
ID Adverteerder: 13267

Exploitanten (in geval van special deal. Username + id):

Welk type staffel is het (maak 1 keuze)?

2) Special deal
Lead programma's ID of advertentie ID (oud en nieuw):  
6256


Wat moet er precies gebeuren?
Kunnen de leads die gegenereerd worden door onderstaande partijen in de staffel vallen?

105
307
5575
11524


Startdatum:  15-2-2011
*/

UPDATE
	lead
SET
	lead_program_id = 6256
WHERE
	lead_program_id = 6138 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (105, 307, 5575, 11524) AND
	created >= '2011-02-15';