/** 
 123inkt 
 id: 12408 
*/

/* 9 Januari 2009, Dineke: Special deal for mailing parties:
they always go to program 2557
*/

UPDATE
	lead
SET
	lead_program_id = 2557
WHERE
	lead_program_id IN (2490,2528,2529,2530) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 105;

/* April 13 2010, Dineke
 * reported by Tim
 * Special deal Yellow Industries (16163): always gets leadprogramma 2530
*/
UPDATE
	lead
SET
	lead_program_id = 2530
WHERE
	lead_program_id IN (2490,2528,2529) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 16163;

/* 16 July 2010, Jan, ticket: #5482
Zou jij voor de adverteerder 123inkt (id 12408) de affiliate shopkorting (id 12307) standaard in lp 2529 kunnen laten vallen? De staffel moet verder wel gelden, 
alleen de ondergrens is dit lp.
Kun je dit per vandaag instellen?

NOTE: Exception was added to staffel below for Shopkorting, if this special deal is removed, the exception must be removed as well.
*/
UPDATE
	lead
SET
	lead_program_id = 2530
WHERE
	lead_program_id IN (2490, 2528, 2529) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 12307 AND
	created >= '2010-07-06';
	
/*
Offer id 2490: 0-20 orders per maand 7% commissie voor de affiliate
Offer id 2528: 21-40 orders per maand 8% commissie voor de affiliate
Offer id 2529: 41-60 orders per maand 9% commissie voor de affiliate
Offer id 2530: 61 orders of meer per maand 10% commissie voor de affiliate

Update: April 13 2010, Jan
Changed staffel to also count ON_HOLD and TO_BE_APPROVED leads

Update: September 3 2010, Jan
Removed the possibility to fall back one level in the staffel
*/
	
	

/** Offerid 2528 21-40 **/
UPDATE 
    lead
SET 
    lead_program_id = 2528
WHERE 
    lead_program_id IN (2490) AND
    status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE
				         lead_program_id IN (2490,2528,2529,2530) AND
				         status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
				     GROUP BY 
				         affiliate_id 
				     HAVING 
				     	COUNT(id) BETWEEN 21 AND 40
				     ) AND
	affiliate_id NOT IN (12307);
				     
/** Offerid 2529: 41-60 **/
UPDATE 
    lead
SET 
    lead_program_id = 2529
WHERE 
    lead_program_id IN (2490, 2528) AND
    status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE
	                     lead_program_id IN (2490,2528,2529,2530) AND
				         status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
				     GROUP BY 
				         affiliate_id 
				     HAVING 
				     	COUNT(id) BETWEEN 41 AND 60
				     );
				     
/** Offerid 2530: 61 or more **/
UPDATE 
    lead
SET 
    lead_program_id = 2530
WHERE 
    lead_program_id IN (2490, 2528, 2529) AND
    status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE
	                     lead_program_id IN (2490,2528,2529,2530) AND
				         status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
				     GROUP BY 
				         affiliate_id 
				     HAVING 
				     	COUNT(id) > 60 
				     );