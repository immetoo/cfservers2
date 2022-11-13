/* June 9 2010, Jan, ticket: #5163
Bonprix (id 12079) aan lpid 4493, zwemkleding.nl (id 17860) en affiliate 9181
*/
UPDATE
	lead
SET
	lead_program_id = 4493
WHERE
	lead_program_id IN (2324, 2620, 2621) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id IN (17860, 9181) AND
	created >= '2010-06-01';

/* May 20 2010, Jan, ticket: #5137 
Zou jij affiliate 12307 (Shopkorting.nl) vanaf vandaag automatisch kunnen koppelen aan lp 2621, zodat hij in de hoogste staffel valt voor 
Bonprix (id 12079)?
*/
UPDATE
	lead
SET
	lead_program_id = 2621
WHERE
	lead_program_id IN (2324, 2620) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 12307 AND
	created >= '2010-05-20';

/* July 6 2010, Jan, ticket: #5487
Zou jij de volgende special deal voor Bonprix (id 12079) kunnen instellen voor affiliate Zinngeld (id 5575):

- LP 4601: standaard (bruto)
- LP 4600: bij 200 sales per maand (bruto)

Per vandaag laten ingaan aub.
Update September 7 2010, ticket: #5865 : Reduce staffel amount for Zinngeld to 150 sales
Update September 10 2010, ticket: #5889: Added affiliate Fourpeople(8639)
*/
UPDATE
	lead
SET
	lead_program_id = 4601
WHERE
	lead_program_id IN (2324, 2620, 2621) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id IN (5575, 8639) AND
	created >= '2010-07-06';
	
UPDATE 
	lead 
SET 
	lead_program_id = 4600
WHERE
	lead_program_id = 4601 AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED')	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
		(
			SELECT
				affiliate_id
			FROM 
				lead
			WHERE 
				lead_program_id IN (4601, 4600) AND 
				status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
				payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
				affiliate_id = 5575 AND
				created >= '2010-07-06'
			GROUP BY 
				affiliate_id 
			HAVING 
				COUNT(id) > 200
		) AND
	created >= '2010-07-06' AND
	created < '2010-09-07';
	
UPDATE 
	lead 
SET 
	lead_program_id = 4600
WHERE
	lead_program_id = 4601 AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED')	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
		(
			SELECT
				affiliate_id
			FROM 
				lead
			WHERE 
				lead_program_id IN (4601, 4600) AND 
				status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
				payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
				affiliate_id IN (5575, 8639) AND
				created >= '2010-07-06'
			GROUP BY 
				affiliate_id 
			HAVING 
				COUNT(id) >= 150
		) AND
	created >= '2010-09-07';
	
/**
February 5 2009, Dineke: new staffel!
2621 Premium segment 9% commissie 20+ sales
2620 Gold segment 8% commissie 10-20 sales
2324 de hoofd vergoeding. Silver segment 7% commissie 0-10 sales
*/

/** 11 up to 20 sales? --> Gold! (2620) **/
UPDATE lead 
SET lead_program_id = 2620
WHERE
	lead_program_id IN (2324, 2621) AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (2324, 2620, 2621) AND status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 20
		);
	
/* February 19 2009, Dineke: No Search accounts count together in the deal. */
UPDATE lead SET lead_program_id = 2620
	WHERE lead_program_id = 2324 AND 
		affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
		status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		(SELECT COUNT(*) FROM lead WHERE lead_program_id IN (2324, 2621, 2620) AND
										status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)
		) BETWEEN 11 AND 20;

/* 21 sales and up? --> Premium! (2621) */
UPDATE lead 
SET lead_program_id = 2621
	WHERE
	lead_program_id IN (2324, 2620) AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED')	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (2324, 2620, 2621) AND 
			status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY affiliate_id HAVING COUNT(id) > 20
		);
		
/** February 19 2009, Dineke: No Search accounts count together in the deal. */
UPDATE lead SET lead_program_id = 2621
	WHERE lead_program_id IN (2324, 2620) AND 
		affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
		status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		(SELECT COUNT(*) FROM lead WHERE lead_program_id IN (2324, 2621, 2620) AND
										status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)
		) > 20;
		
/* October 15th 2010, Jan, ticket: #6050
Zou jij de volgende special deal willen aanmaken voor Bonprix.

Zou je onderstaande affiliates kunnen hangen aan leadprogramma ID 4866 van adverteerder Bonprix (ID 12079)
Wanner ze 50 of meer sales doen voor Bonprix vallen ze in dit leadprogramma!

- Onlinepostorder		ID 3893
- 37cadeau				ID 8131
- Marlon				ID 547
*/
UPDATE
	lead
SET
	lead_program_id = 4866
WHERE
	lead_program_id IN (2324, 2620, 2621) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (2324, 2620, 2621, 4866) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
			affiliate_id IN (547, 8131, 3893) 
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 50
	);		

