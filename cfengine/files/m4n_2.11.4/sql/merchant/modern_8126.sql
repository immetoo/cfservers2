/* April 26 2010, Jan, ticket: #4889
Aanvrager: Jesse le Grand
Hierbij een aanvraag voor een special deal.

Het is voor 2 affiliates:

- actiepag 3571
- Imbull 11033

- Modern 8126
alle leads moeten van 1262 naar 4327 voor beide affiliates
*/
UPDATE
	lead
SET
	lead_program_id = 4327
WHERE
	lead_program_id = 1262 AND
	affiliate_id IN (3571, 11033) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* March 24 2010, Jan, ticket: #4746
Aanvrager: Jesse le Grand
Adverteerder: modern.nl
ID Adverteerder: 8126

Exploitanten (in geval van special deal. Username + id): aanbiedingtop10 8147

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
Van 24-03-10 tot en met 30-06-10
From: 1262 to: 4088

Van 30-06-10 tot geen einddatum
From: 1262 to: 4089

Wat moet er precies gebeuren?
Alle sales van aid 8147 moeten op lpid 4088 worden gezet. Vanaf 30 juni moet dit lpid 4089 worden.

Startdatum: 24-03-10
Einddatum: geen

Update March 31 2010, Jan, ticket: #4776
Added debesteonline(19186) to the deal, starting on 1-4-2010.

Update April 8 2010, Jan
Affiliate debesteonline(19186) should get lead program 3518 instead of 4088.

*/

UPDATE
	lead
SET
	lead_program_id = 4088
WHERE
	lead_program_id = 1262 AND
	affiliate_id = 8147 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-03-24' AND
	created < '2010-06-30';
	
UPDATE
	lead
SET
	lead_program_id = 3518
WHERE
	lead_program_id = 1262 AND
	affiliate_id = 19186 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-04-01' AND
	created < '2010-06-30';

UPDATE
	lead
SET
	lead_program_id = 4089
WHERE
	lead_program_id = 1262 AND
	affiliate_id IN (8147, 19186) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-06-30';
	
/* March 26 2010, Jan, ticket: #4761
37cadeau (id 8131) zal per vandaag een special deal krijgen voor Modern (id 4089).
Kun jij id 8131 koppelen aan leadprogramma 4089 t/m 30 juni.
Daarna valt hij weer in de reguliere staffel waar hij nu in staat.
 */
UPDATE
	lead
SET
	lead_program_id = 4089
WHERE
	lead_program_id = 1262 AND
	affiliate_id = 8131 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created < '2010-07-01';
	
	
/* Dineke, April 24 2009:
	kun je voor mij het affiliate id 9181 kunnen koppelen aan het offid nr 2697 kunnen koppelen bij Modern 8126 vanaf vandaag?
*/
UPDATE lead
	SET lead_program_id = 2697
	WHERE 	lead_program_id = 1262 AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			affiliate_id = 9181;	

			
/* March 22 2010, Jan, ticket: #4732
Aanvrager: Jesse le Grand
Exploitanten (in geval van special deal. Username + id): fkasbergen 11745

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
From: 1262 to: 3518

Wat moet er precies gebeuren?
Alle sales van aid 11745 moeten op lpid 3518 worden gezet.

Startdatum: 23-03-10
Einddatum: geen
*/		

UPDATE
	lead
SET
	lead_program_id = 3518
WHERE
	lead_program_id = 1262 AND
	affiliate_id = 11745 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-03-23' AND
	created < '2010-07-01';

/* September 1st 2009, Dineke
Update March 1st 2010, Jan: 
	Changed minimum sales for staffel

	Reported by Jesse:
	Staffel (instead of bonus) as follows:
*          0 – 30 orders       	1262
*          31 orders and up		3285

Update May 17 2010, change minimum sales starting 17-05-2010
0-15 sales           1262
15 + sales            3285
*/
UPDATE 
	lead 
SET 
	lead_program_id = 3285
WHERE
	lead_program_id = 1262 AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created < '2010-05-17' AND
	affiliate_id IN 
		(SELECT	affiliate_id
		FROM 
			lead
		WHERE
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			lead_program_id IN (3285, 1262) AND 		  
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 31
	);

/* Starting 17-05-2010 */
UPDATE 
	lead 
SET 
	lead_program_id = 3285
WHERE
	lead_program_id = 1262 AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-05-17' AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(SELECT	affiliate_id
		FROM 
			lead
		WHERE
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			lead_program_id IN (3285, 1262) AND 	
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 15
	);

/* April 20 2010, Jan, ticket: #4853
Aanvrager: Jesse le Grand

Exploitanten (in geval van special deal. Username + id): 98hulse 19895

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
From: 1262 to: 4088

Startdatum: 20-04-10
Einddatum: geen
*/
	
UPDATE
	lead
SET
	lead_program_id = 4088
WHERE
	lead_program_id = 1262 AND
	affiliate_id = 19895 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-04-20';
