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
