/*July 15th 2010, Jan, ticket: #5530
Zou je bij klant ID 18401 alle leads van exploitant 19895 op LPID 3936 kunnen zetten?
--August 20 2010, Dineke. Update: reject all leads instead.
This affiliate gets his rewards manually. */
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	lead_program_id = 3938 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (19895) AND
	status NOT IN ('BLOCKED', 'REJECTED');

/*May 18 2010, Jan, ticket: #5106
Aanvrager: Paul Vogelzang

Adverteerder: wasmachine.nl
ID Adverteerder: 18401

Exploitanten (in geval van special deal. Username + id): 98hulse 19895 en besteconsumentenkoop.nl 9181 (is dezelfde affiliate alleen ander account)

Welk type staffel is het (maak 1 keuze)?
2) Special deal


Lead programma's ID of advertentie ID (oud en nieuw):  oud 3939

Wat moet er precies gebeuren?
De affiliate moet standaard in dit leadprogramma vallen. De affiliate ontvangt dan 3,5% over de orderwaarde ten alle tijden.

Startdatum: ASAP
Einddatum: - 
*/

UPDATE
	lead
SET
	lead_program_id = 3939
WHERE
	lead_program_id = 3938 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-05-17' AND
	affiliate_id IN (9181);
	
/* February 8 2010, Jan, ticket: #4554
Aanvrager: Paul Vogelzang

Adverteerder: wasmachine.nl
ID Adverteerder: 18401

Welk type staffel is het (maak 1 keuze)?
2) Staffel voor alle affiliates 

Lead programma's ID of advertentie ID (oud en nieuw):  
3938  0 - 15 sales per maand
3939  > 15 per maand

Wat moet er precies gebeuren?
Met id 3938 (0 - 15 sales)krijgt de affiliate een vergoeding van 2,5% en
bij 
id 3939(> 15 sales) krijgt  de affiliate een vergoeding van 3,5%.

Startdatum: 15-02-2010
Einddatum: geen
*/

UPDATE
	lead
SET
	lead_program_id = 3939
WHERE
	lead_program_id = 3938 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-02-15' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3938, 3939) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created >= '2010-02-15'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 15
	);