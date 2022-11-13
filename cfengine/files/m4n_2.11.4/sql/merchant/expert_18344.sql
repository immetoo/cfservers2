/* July 13 2010, Jan, ticket: #5516
Aanvrager: Jesse Le Grand
Zou jij alle sales van ID 19895 bij klant 18344 op LPID 4618 kunnen zetten?
*/

UPDATE
	lead
SET
	lead_program_id = 4618
WHERE 
	lead_program_id IN (3926, 3927, 3928) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 19895;

/* March 19 2010, Jan, ticket: #4725 
Aanvrager: Wouter Groenewoud
Adverteerder: Expert
ID Adverteerder: 18344

Welk type staffel is het (maak 1 keuze)?
2) Voor één maand moet iedere lead in de hoogste staffel terecht komen.

Lead programma's ID of advertentie ID (oud en nieuw): 
Leadprogramma ID hoogste staffel 3928

Wat moet er precies gebeuren?
Alle leads die in de periode 18 maart t/m 16 april voor Expert worden gezet moet in de hoogste staffel worden geplaatst.
Het ID hiervoor is: 3928 

Startdatum: 18-02-2010
Einddatum:  16-04-2010

UPDATE May 14 2010, Jan
Extended deal until June 17th 2010.
*/

UPDATE
	lead
SET
	lead_program_id = 3928
WHERE 
	lead_program_id IN (3926, 3927) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-03-18' AND
	created < '2010-06-18';
	
/* February 3 2010, Jan, ticket: #4538
Aanvrager: Wouter Groenewoud

Adverteerder: Expert
ID Adverteerder: 18344

Welk type staffel is het (maak 1 keuze)?
2) Staffel voor alle affiliates

Lead programma's ID of advertentie ID (oud en nieuw): 
Lead ID 3926 0 tot 10 sales 3% vergoeding
Lead ID 3927 10 tot sales 4% vergoeding
Lead ID 3928 20 sales of meer 5% vergoeding

Wat moet er precies gebeuren?
Er moet een staffel komen qua percentages en aantallen. Zie bovenstaande.

Startdatum: 05-02-2010
Einddatum: geen
*/
UPDATE
	lead
SET
	lead_program_id = 3927
WHERE
	lead_program_id IN (3926, 3923) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(SELECT 
			affiliate_id
		FROM 
			lead 
		WHERE 
			lead_program_id IN (3926, 3927, 3928, 3923) AND 
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 10 AND 19);
				
UPDATE
	lead
SET
	lead_program_id = 3928
WHERE
	lead_program_id IN (3926, 3927, 3923) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(SELECT 
			affiliate_id
		FROM 
			lead 
		WHERE 
			lead_program_id IN (3926, 3927, 3928, 3923) AND 
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 20);