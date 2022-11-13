/* June 24 2010, Jan, ticket: #5411
Er is voor Deal-factory (11025) een aparte vergoeding indien de bestelnummers van bestellingen een prefix hebben met VA, FA, TA, RA of SA.
Zou je leads die hierop binnekomen in leadprogramma (ID 4551) kunnen zetten?
*/

UPDATE
	lead
SET
	lead_program_id = 4551
WHERE
	lead_program_id IN (2111, 2499, 2500) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-06-24' AND
	(
		description1 LIKE 'VA%' OR
		description1 LIKE 'FA%' OR
		description1 LIKE 'TA%' OR
		description1 LIKE 'RA%' OR
		description1 LIKE 'SA%'
	);
	

/**
* 9 December 2008, Dineke
* Deal factory (#2371)
*/

/* 26 up to 50 leads: lead_program_id 2499 */
UPDATE 
    lead 
SET 
    lead_program_id = 2499
WHERE 
    status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2111, 2500) AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE 
	                     lead_program_id IN (2111, 2499, 2500) AND 
						 status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND 
						 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
					 GROUP BY 
					     affiliate_id 
					 HAVING 
					     COUNT(id) BETWEEN 26 AND 50
				     );

/* 51 leads and up: lead_program 2500 */
UPDATE 
    lead 
SET 
    lead_program_id = 2500
WHERE 
    status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2111, 2499) AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE 
	                     lead_program_id IN (2111, 2499, 2500) AND 
						 status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND 
						 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
					 GROUP BY 
					     affiliate_id 
					 HAVING 
					    COUNT(id) > 50
					 );
  