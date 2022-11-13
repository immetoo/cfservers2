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
	
