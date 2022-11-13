/* November 9 2010, Dineke, #6230
Requested by Fleur:

Special deal:
5423 ratje10

Standaard in de hoogste staffel :
1. 2718 à 2721
2. 2719 à 2723

Startdatum: 9-11-2010
Einddatum: NVT
*/
--1. 2718 à 2721
UPDATE
	lead
SET
	lead_program_id = 2721
WHERE
	lead_program_id = 2718 AND
	affiliate_id = 5423 AND
	created > '2010-11-09' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

	--2. 2719 à 2723
UPDATE
	lead
SET
	lead_program_id = 2723
WHERE
	lead_program_id = 2719 AND
	affiliate_id = 5423 AND
	created > '2010-11-09' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
 
/** 17 December 2008, Dineke: reject leads by priceboy (6404) **/
UPDATE lead SET status = 'REJECTED'
	WHERE affiliate_id = 6404 AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  AND
	lead_program_id = 1078;
	

/** Ticket#2634: 06 March 2008, Andre: Echte Staffel. **/
/**  Ticket#2634: brons= 11-14 sales goes from lead program: 2718 to 2720 **/
UPDATE lead 
SET lead_program_id = 2720
WHERE
	lead_program_id IN (2718, 2721) AND 
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id in (2718, 2720) AND
		status = 'ACCEPTED' AND
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 14
	);
	
 /** Ticket#2634: silver >= 15 sales goes from lead program: 2718, 2720 to 2721. **/
UPDATE lead 
SET lead_program_id = 2721
WHERE
	lead_program_id IN (2718, 2720) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2718, 2720, 2721) AND status = 'ACCEPTED' AND
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 15
	);
	
/**  Ticket#2634: brons= 11-14 sales goes from lead program: 2719 to 2722 **/
UPDATE lead 
SET lead_program_id = 2722
WHERE
lead_program_id IN (2719, 2723)
AND status = 'ACCEPTED' 	
AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
AND click_created < '2011-01-01' AND 
affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2719, 2722) AND status = 'ACCEPTED' AND
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 14
	);
	
 /** Ticket#2634: silver >= 15 sales goes from lead program: 2719, 2722 to 2723. **/
UPDATE lead 
SET lead_program_id = 2723
WHERE
	lead_program_id IN (2719,2722) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2719, 2722, 2723) AND status = 'ACCEPTED' AND
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 15
	);
