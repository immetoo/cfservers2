/* February 10 2009, Dineke
Primary segment for leads with description2 starting with 'VV-5'.
This goes for all affiliates
*/

UPDATE lead 
SET lead_program_id = 2614
WHERE lead_program_id = 2613 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	description2 like 'VV-5%';

/* Februari 12 2009, Dineke
Some affiliates get no click reward and are only allowed to use the special deal advertisements provided.
This query puts rewarded clicks back to one of these special deal advertisements.

Note: new affiliates should be added to BOTH 'IN(...)' CLAUSES

February 16 2009, Dineke: new affiliates for this deal: jakko (8281), prijzen-express (8378), voorniets (4501)
February 23 2009, Dineke: new affiliate: 12644
*/

UPDATE 
	click 
SET
	advertisement_id = 478180 
WHERE 
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	advertisement_id IN (
		SELECT 
			id 
		FROM 
			advertisement 
		WHERE
			merchant_id = 12843 AND
			id NOT IN (
				SELECT 
					advertisement_id 
				FROM 
					advertisement_affiliate 
				WHERE 
					affiliate_id IN (8523, 7718, 11224, 11605, 8281, 8378, 4501, 12644)
			) 
	) AND
	affiliate_id IN (8523, 7718, 11224, 11605, 8281, 8378, 4501, 12644);