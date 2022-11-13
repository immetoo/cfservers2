/* August 2nd 2010, Jan, ticket: #5840
Zou je per 2 september t/m 30 september leadprogramma ID 4492 van adverteerder Dress-for-less (ID  6415) kunnen koppelen aan de volgende banner ID's:
- 672205
- 288717
- 288715
- 243480
- 243476
- 243473

Update February 2 2011, Jan, Extended deal until 15-02-2011. 
*/

UPDATE
	lead
SET
	lead_program_id = 4492
FROM
	click
WHERE
	lead.click_id = click.id AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 6415) AND
	lead.created >= '2011-01-06' AND
	lead.created < '2011-02-15' AND
 	click.advertisement_id IN (672205, 288717, 288715, 243480, 243476, 243473);

/* June 15 2010, Jan, ticket: #5346
Zou jij ervoor willen zorgen dat alle sales die bij Dress-for-Less (ID 6415) binnenkomen via Imbull (ID 11033) automatisch worden afgekeurd?
*/
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	lead_program_id IN (SELECT id FROM lead_program where merchant_id = 6415) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	affiliate_id = 11033;

/* May 21 2010, Jan, ticket: #5143
Kun je affiliate ID 5540 (Het Merkkleding team) aan leadprogramma 4431 koppelen.
Dit leadprogramma hoort bij de adverteeder Dress-for-Less ID 6415.
Graag per vandaag, 21 mei 2010.
*/

UPDATE 
	lead 
SET 
	lead_program_id = 4431
WHERE 
	lead_program_id IN (1047, 3446, 3447) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 5540 AND
	created >= '2010-05-21';	

/* June 8 2010, Jan, ticket: #5295
Kun jij leadprogramma ID 4431 koppelen aan de volgende affiliates:

Fashionchick: ID 8880
Welovesites ID: 9070
ELF-Snijder ID: 6059

Per maandag 7 juni (gisteren dus) als het kan!
*/
UPDATE 
	lead 
SET 
	lead_program_id = 4431
WHERE 
	lead_program_id IN (1047, 3446, 3447) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (8880, 9070, 6059) AND
	created >= '2010-06-07';
	
/* February 24 2010, Jan, ticket: #4648
Hierbij de staffel van Dressforless (id 6415) die geimplementeerd moet worden:
- Standaard 6% vergoeding: lp 1047
- Omzet in M4N van EUR 1298 tot EUR 3896 netto per maand (dus goedgekeurd): lp 3446
- Omzet in M4N vanaf 3896 netto per maand (dus goedgekeurd): lp 3447
*/

UPDATE 
	lead 
SET 
	lead_program_id = 3446
WHERE 
	lead_program_id = 1047 AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (1047, 3446, 3447) AND 
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
		GROUP BY 
			affiliate_id 
		HAVING 
			SUM(price) >= 1298 AND 
			SUM(price) < 3896
	);
	

UPDATE 
	lead 
SET 
	lead_program_id = 3447
WHERE 
	lead_program_id IN (1047, 3446) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (1047, 3446, 3447) AND 
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
		GROUP BY 
			affiliate_id 
		HAVING 
			SUM(price) >= 3896
	);

/* October 8th 2010, Jan
Zou je leadprogramma ID 3447 van adverteerder Dress-for-less (ID 6415)
kunnen koppelen aan affiliate FourPeople (ID 8639)

Ingang: 01 oktober 2010.
*/	
UPDATE 
	lead 
SET 
	lead_program_id = 3447
WHERE 
	lead_program_id IN (1047, 3446) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 8639 AND
	created >= '2010-10-01';
	
/* October 27 2010, Jan, ticket: #6139
Kun jij affiliate Plop en Co (ID 3918) hangen aan leadprogramma 3446 van adverteerder Dress-for-less (ID 6415)
Deze affiliate krijgt standaard 8% ipv 6% en wanneer er meer dan EUR 3000 aan orderwaarde gegenereerd wordt 10% (LP 3447)
*/
UPDATE 
	lead 
SET 
	lead_program_id = 3446
WHERE 
	lead_program_id = 1047 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 3918 AND
	created >= '2010-10-27';
	
UPDATE 
	lead 
SET 
	lead_program_id = 3447
WHERE 
	lead_program_id = 3446 AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-10-27' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (1047, 3446, 3447) AND 
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			created >= '2010-10-27' AND
			affiliate_id = 3918
		GROUP BY 
			affiliate_id 
		HAVING 
			SUM(price) >= 3000
	);

