/* July 1 2010, Jan, ticket: #5448
Aanvrager:Paul Vogelzang
Adverteerder: Villavino
ID Adverteerder: 18374

Exploitanten (in geval van special deal. Username + id): 

Welk type staffel is het (maak 1 keuze)?
2) Special deal


Lead programma's ID of advertentie ID (oud en nieuw):  

Wat moet er precies gebeuren?
Alle affiliates mogen in de maand juli standaard in de hoge staffel vallen, leadprogramma 3933 ipv van de standaard staffel 3932. Hierdoor krijgen 
alle affiliates ipv 5% commissie, 6,5% commissie.

Startdatum: 1 juli
Einddatum: 31 juli

*/
UPDATE
	lead
SET
	lead_program_id = 3933
WHERE
	lead_program_id = 3932 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-07-01' AND
	created < '2010-08-01';
	
/* March 5 2010, Jan, ticket: #4679
Zou jij een special deal willen aanmaken voor Fred Gielen, Affiliate id: 6305 dat hij standaard in het leadprogramma: ID 3933 valt voor de 
adverteerder Villavino. 

Alvast bedankt

Paul Vogelzang
*/
UPDATE
	lead
SET
	lead_program_id = 3933
WHERE
	lead_program_id = 3932 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6305;

/* February 5 2010, Jan, ticket: #4549
Aanvrager: Paul Vogelzang

Adverteerder: villavino
ID Adverteerder: 18374

Welk type staffel is het (maak 1 keuze)?
2) Staffel voor alle affiliates 

Lead programma's ID of advertentie ID (oud en nieuw):  
3932 0-10 sales 
3933 11 sales of meer 

Wat moet er precies gebeuren?
Op het moment dat er bij Villavino meer dan 10 sales verkocht moet er id
3933 actief worden gezet. 

Startdatum: 08-01-2010
Einddatum: geen
*/
	
UPDATE
	lead
SET
	lead_program_id = 3933
WHERE
	lead_program_id = 3932 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3932, 3933) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 11
	);