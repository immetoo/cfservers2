/* February 2010, Dineke: Special deal reported by Jonas

Dineke zou je alle leads van:
* Jiggy 11524
* Euroclix 105
* Money Miljonair 307

Die voor GSMtopdeal (18075) worden gezet op programma 4015 willen zetten?
Vanaf 24-2-10
*/
UPDATE	
	lead
SET
	lead_program_id = 4015
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 18075 AND id != 4015) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (11524, 105, 307) AND
	created > '2010-02-24';

/* July 1 2010, Dineke, Ticket #5457:	
Requested by Paul Vogelzang

Welk type staffel is het (maak 1 keuze)? 1) Echte staffel

Lead programma's ID of advertentie ID (oud en nieuw): nieuw 4575

Wat moet er precies gebeuren?

GSMtopdeal gaat met een staffel werken per 1 juli. 
Leadprogramma 3872 is het standaard leadprogramma. 
T/m 24 leads krijgt de affiliate 26,25 CPL. 
25 sales of meer valt de affiliate in leadprogramma 4575 en krijgt dan 32,50 CPL.

Startdatum: per 1 juli 
Einddatum: -
*/
UPDATE	
	lead
SET
	lead_program_id = 4575
WHERE 
	lead_program_id IN  (3872) AND
	status = 'ACCEPTED'	AND
	created > '2010-07-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (3872, 4575) AND
		status = 'ACCEPTED' AND
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 25
	);

