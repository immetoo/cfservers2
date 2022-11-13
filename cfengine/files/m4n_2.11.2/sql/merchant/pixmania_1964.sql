/* February 17 2011, Jan
Aanvrager: Wouter Groenewoud

Adverteerder:Pixmania
ID Adverteerder:  1964

Exploitanten (in geval van special deal. Username + id):
Shopkorting 12307

Welk type staffel is het (maak 1 keuze)?

2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):  Leads die voor Shopkorting binnen komen binnen op ID: 2166 moeten nu naar lead ID 6264

Wat moet er precies gebeuren? Zie bovenstaande

Startdatum: 17-02-2011
Einddatum onbekiend

Update March 8 2011, Jan, Added lead program 481 to the deal
*/
UPDATE 
	lead 
SET 
	lead_program_id = 6264
WHERE
	lead_program_id IN (481, 2166) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 12307 AND
	created >= '2011-02-17';

/* June 9 2010, Jan, ticket: #5311
Special deal voor Kortingkorting(8420) starting 09-06-2010 -> 4486

Update October 15th 2010, Jan, ticket: #6047 Added besteconsumentenkoop (9181) to the deal
*/

UPDATE 
	lead 
SET 
	lead_program_id = 4486
WHERE
	lead_program_id IN (481, 2167, 2166) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 8420 AND
	created >= '2010-06-09';

UPDATE 
	lead 
SET 
	lead_program_id = 4486
WHERE
	lead_program_id IN (481, 2167, 2166) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 9181 AND
	created >= '2010-10-13';

/* September 10 2010, Jan, ticket: #5890
Kan de besteonline (19186) voor de volgende shops in een speial programma komen:
Bij Pixmania (1964) in programma (481) maar als er meer dan 25 sales zijn in (2167)
Ingangsdatum 9 september
*/

UPDATE 
	lead 
SET 
	lead_program_id = 481
WHERE
	lead_program_id = 2166 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 19186;
	
/* 28 January 2009, Dineke: staffel pixmania

	2167  	Premium segment 26+ sales 4%  	
	481 	Gold segment 11-25 sales 3%
	2166 	Silver segment 1-10 sales 2,5% 	
*/

UPDATE lead 
SET lead_program_id = 481
WHERE
	lead_program_id IN (2167, 2166) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') 	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (481, 2167, 2166, 1474) AND status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 25
	);


UPDATE lead 
SET lead_program_id = 2167
WHERE
	lead_program_id IN (481, 2166) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') 	AND
	click_created < '2011-01-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (481, 2167, 2166, 1474) AND status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) > 25
	);	

/* Special deal */	
UPDATE lead SET lead_program_id = 2167 
WHERE affiliate_id = 6387 AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 1964) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
