/**
* Staffel Ulla Popken
**/

/* 28 August 2009, Dineke: Correction: starting from this month, the staffel is calculated manually.
   Reported by Liesbeth
*/

/** 
* Ticket #1935: 6 t/m 20 sales --> 2202, more than 20 sales --> 2203
*/
UPDATE 
	lead 
SET 
	lead_program_id = 2202
WHERE 
	lead_program_id IN (2128, 2203) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT 
			affiliate_id 
		FROM 
			lead
		WHERE
			lead_program_id IN (2128, 2202, 2203) AND 
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND	
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 6 AND 20
	);

UPDATE 
	lead 
SET 
	lead_program_id = 2203
WHERE 
	lead_program_id IN (2128, 2202) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT 
			affiliate_id 
		FROM 
			lead	
		WHERE 
			lead_program_id IN (2128, 2202, 2203) AND 
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) > 20
	);
	
/* June 9 2010, Jan, ticket: #5163
Ulla Popken (id 11502) aan lpid 2203 (standaard hoogste staffel), voor zwemkleding.nl (id 17860) en affiliate 9181
*/
UPDATE
	lead
SET
	lead_program_id = 2203
WHERE
	lead_program_id = 2128 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id IN (17860, 9181) AND
	created >= '2010-06-01';

/* February 19 2009, Dineke: No Search accounts count together in the deal. */
/* February 27 2009, Dineke: UPDATE: No Search accounts always get the highest program */
UPDATE 
	lead 
SET 
	lead_program_id = 2203
WHERE 
	lead_program_id IN (2128, 2202) AND 
	affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/**
 * Ticket #2665. Andre Cesta. Special deal for affiliate Marlon, id 547.
 */
/* August 28 2009, Dineke: Also for Onlinepostorder.nl (3893) and XXLmaten (8582) 
*/
UPDATE 
	lead
SET 
	lead_program_id = 2203
WHERE 
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2128, 2202) AND
	affiliate_id IN (547, 3893, 8582);
