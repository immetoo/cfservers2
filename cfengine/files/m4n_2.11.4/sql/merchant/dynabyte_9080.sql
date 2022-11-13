/* January 27 2011, Jan, ticket: #6647
Kan je in het account van Dynabyte (9080):

Affiliate Shopkorting (12307) koppelen aan lpid: 3747

Gaat in vanaf 24 januari
*/

UPDATE
	lead
SET
	lead_program_id = 3747
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 1450 AND
	affiliate_id = 12307 AND
	created >= '2011-01-24';
	
/* December 16, 2009, Jan, ticket: #4386
Aanvrager: Jesse le Grand

Adverteerder: dynabyte
ID Adverteerder: 9080

Exploitanten (in geval van special deal. Username + id): lysander 10929

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
From: 1450 to: 3747

Wat moet er precies gebeuren?
Alle sales van expl. 10929 moeten op lpid 3747 worden gezet.

Startdatum: 16-12-09
Einddatum: geen
*/
UPDATE
	lead
SET
	lead_program_id = 3747
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 1450 AND
	affiliate_id = 10929 AND
	created >= '2009-12-16';