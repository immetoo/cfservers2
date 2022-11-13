/* April 22 2010, Jan, ticket: #4870 
Aangevraagd door Liesbeth
Babywalz (id 6714) heeft een nieuwe staffel. Zou jij deze kunnen implementeren:
Als in beschrijving 2: 'Code' staat, moet daar lead programma 4307 aan hangen, als er 'Nocode' staat in beschrijving 2, dan moet de reguliere staffel gelden (standaard in lp 1229 vallen).

Kun je dit vanaf vandaag laten ingaan?
Update April 26 2010, 'Nocode' should go 4307 instead of 'Code' 
*/
UPDATE 
	lead 
SET 
	lead_program_id = 4307
WHERE 
    lead_program_id IN (1229, 1378, 1655) AND
   	description2 = 'Nocode' AND
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    created >= '2010-04-22';

/** babywaltz  6 up to 15 leads **/
UPDATE 
    lead
SET 
    lead_program_id = 1378
WHERE 
    lead_program_id IN (1229, 1655) AND
    status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE 
		                 lead_program_id IN (1229,1378,1655,1657) AND 
		                 status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	                 GROUP BY 
	                     affiliate_id 
	                 HAVING 
	                     COUNT(id) BETWEEN 6 AND 15
	                 );
	
/** babywaltz  16 leads and up **/
UPDATE 
	lead 
SET 
	lead_program_id = 1655
WHERE 
    lead_program_id IN (1229,1378) AND
    status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    (affiliate_id IN (SELECT
		                  affiliate_id
	                  FROM 
		                  lead
 	                  WHERE 
		                  lead_program_id IN (1229,1378,1655,1657) AND 
		                  status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
		                  click_created < '2011-01-01' AND
		                  payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
	                  GROUP BY 
	                      affiliate_id 
	                  HAVING 
	                      COUNT(id) >= 16
	                  ) 
	               OR affiliate_id = 575 /** special deal voor gebruiker 575 (Henrik)**/
	); 
	

