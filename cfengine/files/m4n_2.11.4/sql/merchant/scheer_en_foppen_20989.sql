/* August 25 2010, Jan, ticket: #5751
Kan er een special deal worden gemaakt voor Scheer en Foppen (20989) en Hoeknet. Hoeknet (7863)moet standaard in leadprogramma 4556 komen ongeacht het aantal leads.

Ingangsdatum: 25 aug. 10

Update September 1 2010, Jan, ticket: #5809
Kun je een special deal aanmaken voor Besteconsumentenkoop 9181 en Scheer en Foppen 20989
Besteconsumentkoop moet standaard in lead programma 4556 vallen. 
*/
UPDATE
	lead
SET
	lead_program_id = 4556
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 20989) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (7863, 9181) AND
	created >= '2010-08-25';
