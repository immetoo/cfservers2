/* April 28 2010, Jan, ticket: #4794
Updated May 19 2010, Jan, Changed staffel levels -> see ticket: #5109

Aanvrager: Wouter Groenewoud
Adverteerder: Icentre
ID Adverteerder: 19636

Welk type staffel is het (maak 1 keuze)?
2) Staffel voor alle affiliates

Lead programma's ID of advertentie ID (oud en nieuw): 
Lead ID 4172 0 t/m 15 leads 2,5% vergoeding
Lead ID 4173 16+ leads 2,5% vergoeding 

Wat moet er precies gebeuren?
Standaard komen de leads binnen op ID 4172, maar als er 11 t/m 20 leads goedgekeurde zijn, moeten die
vallen in ID 4173. Als er meer dan 21 leads zijn dan moeten deze vallen in ID 4176

Startdatum: 09-04-2010
Einddatum: geen
*/

UPDATE
	lead
SET
	lead_program_id = 4173
WHERE
	lead_program_id IN (4172) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-04-09' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4172, 4173, 4176) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created >= '2010-04-09'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 16
	);
	
