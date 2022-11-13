/* May 19th 2010, Dineke, Ticket #5111
Aanvrager: Paul Vogelzang

Adverteerder: Fonq.nl
ID Adverteerder: 18498

Exploitanten (in geval van special deal. Username + id): 13283 MasterCard?/MXM

Welk type staffel is het (maak 1 keuze)?

2) Special deal
Lead programma's ID of advertentie ID (oud en nieuw): nieuw 4410

Wat moet er precies gebeuren?

Affiliate krijgt in de periode van 21 mei tm 17 juni een vergoeding van 20%. Na deze periode moet de affiliate weer in de standaard leadprogramma vallen, namelijk: 3946
en ontvangt de affiliate weer 10%.

Startdatum: 21 mei
Einddatum: 17 juni 
*/

UPDATE
	lead
SET
	lead_program_id = 4410
WHERE
	lead_program_id = 3946 AND
	affiliate_id = 13283 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-05-21' AND '2010-06-18';
	
/*March 23 2010, Jan, ticket: #4734
Aanvrager: Paul Vogelzang

Exploitanten (in geval van special deal. Username + id): 37cadeau + 8131

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):  nieuw 4085

Wat moet er precies gebeuren?

37cadeau krijgt vanaf direct een special deal aangeboden t/m 30 juni. Hierdoor krijgt de affiliate een vergoeding van 11% over deze periode. Vanaf 
1 juli moet de affiliate, 37cadeau, weer in het oude leadprogramma vallen, id 3946, en krijgt de affiliate weer 10%. 

Startdatum: per direct
Einddatum: 30 juni
*/
	
UPDATE
	lead
SET
	lead_program_id = 4085
WHERE
	lead_program_id = 3946 AND
	affiliate_id = 8131 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-03-23' AND
	created < '2010-07-01';

/* April 13 2010, Jan, ticket: #4814
Aanvrager: paul vogelzang
Exploitanten (in geval van special deal. Username + id): Hoeknet   id: 7863

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):  nieuw leadprogramma: id 4215

Wat moet er precies gebeuren?
Affiliate Hoeknet krijgt in de periode 1 mei tm 1 juli een hogere commissie van 12%. Na deze periode valt deze affiliate weer in de reguliere 
vergoeding van 3946 en dat is 10% voor de affiliate

Startdatum: 1 mei	
Einddatum: 1 juli
*/
UPDATE
	lead
SET
	lead_program_id = 4215
WHERE
	lead_program_id = 3946 AND
	affiliate_id = 7863 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-05-01' AND
	created < '2010-07-01';

/* June 17 2010, Jan, ticket: #5359
Aanvrager: Paul Vogelzang

Exploitanten (in geval van special deal. Username + id): Hoeknet id: 7863

Welk type staffel is het (maak 1 keuze)?

2) Special deal


Lead programma's ID of advertentie ID (oud en nieuw):  oud 4085

Wat moet er precies gebeuren?

Affiliate hoeknet krijgt een special deal van leadprogramma 4085 in de periode van 1juli tm 31 juli. Momenteel zit hoeknet in een special deal met leadprogramma 4215, maar deze loopt op 31 juni af. 

Startdatum:  1 juli 
Einddatum:  31 juli
*/
UPDATE
	lead
SET
	lead_program_id = 4085
WHERE
	lead_program_id = 3946 AND
	affiliate_id = 7863 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-07-01' AND
	created < '2010-07-31';