/* November 10 2009, Dineke: Special deal requested by Jonas:
Zou je de affiliate GSM helpdesk (14570) standaard in de volgende staffel willen zetten vanaf 5-10 (als het nog mogelijk is)?
-          Femmefone (6285) leadprogramma 3592 (zou je dit leadprogramma op 42.50 aff en 58.82 totaal willen zetten?)
Staffel geldt voor de alle leadprogramma’s behalve:
Femmefone: 2381
Update 30th of July 2010, Jan, corrected 3281 to 2381 in special deal exclusion and description
*/
UPDATE
	lead
SET
	lead_program_id = 3592
WHERE
	affiliate_id = 14570 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 6285 AND id NOT IN (3592, 2381)) AND
	created > '2009-10-05';
	
/** femmephone tussen 4 en 9 leads **/
UPDATE 
    lead
SET 
    lead_program_id = 1303
WHERE 
    lead_program_id IN (1382,1365,1304,1305,1027) AND
    status = 'ACCEPTED' AND
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE 
		                 lead_program_id IN (1303,1382,1365,1304,1305,1027,2381) AND 
		                 status = 'ACCEPTED' AND
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	                 GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 4 AND 9);
	
/** femmephone tussen 10 en 19 leads **/
UPDATE 
	lead 
SET 
	lead_program_id = 1304
WHERE 
    lead_program_id IN (1303,1382,1365,1305,1027) AND 
    status = 'ACCEPTED' AND
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
	 	                 lead
	                 WHERE 
		                 lead_program_id IN (1303,1304,1382,1365,1305,1027,2381) AND 
		                 status = 'ACCEPTED' AND
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	                 GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 10 AND 19);
	
/** femmephone 20 en meer leads **/
UPDATE 
    lead
SET 
    lead_program_id = 1305
WHERE 
    lead_program_id IN (1303,1304,1382,1365,1027) AND 
    status = 'ACCEPTED' AND
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE 
		                 lead_program_id IN (1303,1304,1382,1365,1305,1027,2381) AND 
		                 status = 'ACCEPTED' AND
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)	
	                 GROUP BY affiliate_id HAVING COUNT(id) >= 20);