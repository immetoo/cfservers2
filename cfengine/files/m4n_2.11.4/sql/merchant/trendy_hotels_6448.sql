/**
* Staffel Trendy-Hotels (6448)
*
* Per 01-10 zal Trendy Hotels (Id 6448) een nieuwe vergoedingsstructuur invoeren voor een bepaald aantal hotels.
Als volgt: met commissie structuur:
0 – 5 boekingen > offid 2236
6 – 10 boekingen > offid 2237
> 10 boekingen > offid 2238
**/

/** 6 - 10 leads --> offid 2237 **/
UPDATE 
	lead 
SET 
	lead_program_id = 2237
WHERE 
	lead_program_id IN (2236, 2238) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2236, 2237, 2238) AND
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 6 AND 10
	);

/** More than 10 leads --> offid 2238 **/	
UPDATE 
	lead 
SET 
	lead_program_id = 2238
WHERE 
	lead_program_id IN  (2236, 2237) AND
	status = 'ACCEPTED'	AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2236, 2237, 2238) AND
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
	GROUP BY affiliate_id HAVING COUNT(id) > 10
	);

/** Special Deal: some affiliates always get lead program 2238 ***/
UPDATE 
	lead 
SET 
	lead_program_id = 2238
WHERE 
	lead_program_id IN  (2236, 2237) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (6429, 8149);


