/**
* 
* 16-06-2008 Ticket #1623
* File: staffel_tonetastic_10798.sql
*
* STAFFEL Tonetastic (ID 10798)
*
* Lead program ids 1889,2011,2012,2013,2014,2015
**/

	
/** Lead program 2011 10-99 leads **/
UPDATE 
	lead 
SET 
	lead_program_id = 2011
WHERE 
	lead_program_id IN  (1889,2012,2013,2014,2015) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1889,2011,2012,2013,2014,2015) AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 10 AND 99
	);
	
/** Lead program 2012 100-499 leads **/
UPDATE 
	lead 
SET 
	lead_program_id = 2012
WHERE 
	lead_program_id IN  (1889,2011,2013,2014,2015) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1889,2011,2012,2013,2014,2015) AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 100 AND 499
	);
	
/** Lead program 2013 500-999 leads **/
UPDATE 
	lead 
SET 
	lead_program_id = 2013
WHERE 
	lead_program_id IN  (1889,2011,2012,2014,2015) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1889,2011,2012,2013,2014,2015) AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 500 AND 999
	);
	
/** Lead program 2014 1000-9999 leads **/
UPDATE 
	lead 
SET 
	lead_program_id = 2014
WHERE 
	lead_program_id IN  (1889,2011,2012,2013,2015) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1889,2011,2012,2013,2014,2015) AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 1000 AND 9999
	);
	
/** Lead program 2015: 10000 leads and up (wow, that's a lot!) **/
UPDATE 
	lead 
SET 
	lead_program_id = 2015
WHERE 
	lead_program_id IN  (1889,2011,2012,2013,2014) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1889,2011,2012,2013,2014,2015) AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
	GROUP BY affiliate_id HAVING COUNT(id) >= 10000 
	);