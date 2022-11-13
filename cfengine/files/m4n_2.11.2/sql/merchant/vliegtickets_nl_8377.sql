
/**
* Staffel vliegtickets.nl 8377
*/
 
/* 27 February 2009, Dineke:
Special deal for rolf (12920), Always gets lpid 1883, also for current open sales
UPDATE lead
SET lead_program_id = 1883
WHERE status = 2 AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (1306, 1882) AND 
	affiliate_id = 12920;
*/

/** Ticket 2640: 2009-03-06: Special deal for rolfo affiliate (12920).  Author: Andre. Cesta. Superseeds above.  **/
UPDATE 
	lead
SET 
	lead_program_id = 2146
WHERE 
	status = 'ACCEPTED' AND
	created > '2009-03-01' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (1883, 1306, 1882) AND
	affiliate_id = 12920;


/**
* Special deal Cridea (1117):
* altijd naar offerid 2146
*/

UPDATE lead
SET lead_program_id = 2146
WHERE status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (1306, 1882, 1883) AND 
	affiliate_id = 1117;


/** Offerid 1882 10 - 25 **/
UPDATE lead 
SET lead_program_id = 1882
WHERE
	lead_program_id IN (1306, 1883) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1306,1882,1883,2146) AND
		status = 'ACCEPTED' AND
		click_created < '2011-02-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 10 AND 25
	);
	
/** Offerid 1883 > 25 **/
UPDATE lead
SET lead_program_id = 1883
WHERE 
	lead_program_id IN  (1306,1882) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (1306,1882,1883,2146) AND
		status = 'ACCEPTED' AND
		click_created < '2011-02-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) > 	25
	);