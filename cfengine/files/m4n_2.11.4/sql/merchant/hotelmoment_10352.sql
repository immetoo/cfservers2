/* June 23 2009, Dineke: Ticket #3040
Aanvrager: Fleur
Adverteerder: Hotelmoment ID Adverteerder: 10352

Welk type staffel is het (maak 1 keuze)? 2)Special deal

Exploitanten (in geval van special deal. Username + id): Vakantie (11159)

Wat moet er precies gebeuren?

Standaard in de hoogste staffel :
1785 à 2253

 Startdatum: 23-6-2009 Einddatum: NVT
*/

UPDATE
	lead
SET
	lead_program_id = 2253
WHERE
	lead_program_id = 1785 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2009-06-23' AND
	affiliate_id = 11159;

/* June 23 2009, Dineke: Ticket #3040
Aanvrager: Fleur
Wat moet er precies gebeuren? Echte staffel:
1785: 0-10 boekingen 2252: 11-20 boekingen 2253: 20 + boekingen
*/
UPDATE
	lead 
SET
	lead_program_id = 2252
WHERE
	lead_program_id = 1785 AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id in (1785, 2252, 2253) AND 	
			click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY
		affiliate_id HAVING COUNT(id) BETWEEN 11 AND 20
	);
 
UPDATE
	lead 
SET
	lead_program_id = 2253
WHERE
	lead_program_id IN (1785, 2252) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id in (1785, 2252, 2253) AND 	
			click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY
		affiliate_id HAVING COUNT(id) > 20
	);
