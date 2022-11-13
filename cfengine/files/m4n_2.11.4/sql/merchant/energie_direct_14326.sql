/* June 14 2010, Jan, ticket: #5340
Kun jij de volgende staffel implementeren? Het gaat om de adverteerder Energie Direct (14326) en geldt voor alle affiliates.

   < 25 sales	-> lead programma 3142
25 - 50 sales	-> lead programma 3143
    50+ sales	-> lead programma 4496
*/

/* 25 - 50 sales	-> lead programma 3143 */
UPDATE 
	lead 
SET 
    lead_program_id = 3143
WHERE 
	lead_program_id = 3142 AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2009-06-10' AND
	click_created < '2011-02-01' AND
	affiliate_id IN (
		SELECT 
			affiliate_id 
		FROM 
			lead 
		WHERE 
			lead_program_id IN (3142, 3143, 4496) AND
			status = 'ACCEPTED' AND
			payment_period_id IN  (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-02-01' AND
			created >= '2009-06-10'
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 25 AND 49
	);

/* 50+ sales	-> lead programma 4496 */
UPDATE 
	lead 
SET 
    lead_program_id = 4496
WHERE 
	lead_program_id IN (3142, 3143) AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2009-06-10' AND
	click_created < '2011-02-01' AND
	affiliate_id IN (
		SELECT 
			affiliate_id 
		FROM 
			lead 
		WHERE 
			lead_program_id IN (3142, 3143, 4496) AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-02-01' AND
			created >= '2009-06-10'
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 50
	);

/* 
	July 30th 2009
	Andre Cesta
	Ticket #3592  Echte staffel Energie Direct.
*/

UPDATE lead SET 
    lead_program_id = 3143
    WHERE status = 'ACCEPTED' AND 
    	  payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    	  lead_program_id = 3142 AND
    	  created > '2009-07-01' AND
    	  created < '2010-06-10' AND
    	  affiliate_id IN (SELECT affiliate_id FROM lead WHERE lead_program_id IN (3142, 3143) AND
    							status = 'ACCEPTED' AND
    							payment_period_id IN  (SELECT id FROM payment_period WHERE processed = false)
    							GROUP BY affiliate_id HAVING COUNT(id) >= 5);

