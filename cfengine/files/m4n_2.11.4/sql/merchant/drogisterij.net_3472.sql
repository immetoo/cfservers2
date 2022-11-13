/* January 17 2011, Jan, ticket: #6562
Zou jij de volgende special deal willen aanmaken.

Wil jij deze affiliates:
- Actiepag (ID 3571)
- Imbull (ID 11033)
hangen aan lpid 6157 van adverteerder Drogisterij.net (ID 3472)

Per vandaag, 11-01-2011. 
*/

UPDATE 
    lead 
SET 
    lead_program_id = 6157
WHERE 
	lead_program_id IN (686, 3381, 3382, 3896) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (3571, 11033) AND
	created >= '2011-01-11';

/* January 11 2011, Jan, ticket: #6522
Kan je in het account van Drogisterij.net (3472), shopkorting (12307) koppelen aan lpid 6157

Zij krijgen voor elke order een vast percentage commissie. Kan je dit met terugwerkende kracht vanaf 1 januari invoeren?
*/

UPDATE 
    lead 
SET 
    lead_program_id = 6157
WHERE 
	lead_program_id IN (686, 3381, 3382, 3896) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 12307 AND
	created >= '2011-01-01';

/* January 27 2010, Jan, ticket: #4508
Aanvrager: Wouter Groenewoud
Adverteerder: Drogisterij.net
ID Adverteerder: 3472

Welk type staffel is het (maak 1 keuze)?
2) Staffel voor alle affiliates

Lead programma's ID of advertentie ID (oud en nieuw): 
oude programma
686  1 tot 29 sales   8%
3381 30 tot 39 sales  9%
3382 40 sales of meer 10%
 
Nieuw:
686 01 t/m 15 sales     10%
3381 16 t/m 25 sales     11%
3382 26 t/m 35 sales     12%
3896 boven 36 sales 13%
 

Wat moet er precies gebeuren?
Er moet een nieuw leadprogramma ID worden toegevoegd. en de “oude” Id’s moeten met andere aantallen/vergoedingen worden ingezet.

Startdatum: 01-02-2010
Einddatum: geen
*/
/* 3381 16 t/m 25 sales */
UPDATE 
    lead 
SET 
    lead_program_id = 3381
WHERE 
	lead_program_id IN (686) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-02-01'	AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT	
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (686, 3381, 3382, 3896) AND
			created >= '2010-02-01' AND 
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 16 AND 25
	);
	
/* 3382 26 t/m 35 sales */
UPDATE 
    lead 
SET 
    lead_program_id = 3382
WHERE 
	lead_program_id IN (686, 3381) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-02-01'	AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT	
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (686, 3381, 3382, 3896) AND
			created >= '2010-02-01' AND 
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 26 AND 35
	);

/* 3896 boven 36 sales */
UPDATE 
    lead 
SET 
    lead_program_id = 3896
WHERE 
	lead_program_id IN (686, 3381, 3382) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-02-01'	AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT	
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (686, 3381, 3382, 3896) AND
			created >= '2010-02-01' AND 
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 36
	);
/*
 *  November 3 2010, Arjan, ticket: #6202
	Ik heb nog een special deal die vanaf vandaag ingaat (voor dezelfde affiliate):
	Shopkorting  (21941) komt in de hoogste staffel van Drogisterij.net. Dat is in dit geval lpid: 3382
*/
			         UPDATE 
    lead 
SET 
    lead_program_id = 3382
WHERE 
	lead_program_id IN (686, 3381, 3382,3896) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 21941;			         