/* 9 September 2009, Dineke, Ticket #3790:
reported by Jonas

Special deal staffel for affiliate vrijheidspers 8350:

Zou je een staffel willen aanmaken voor leadprogramma 3303 van adverteerder BELNU 6336.

De special deal geldt alleen voor vrijheidspers 8350.
De staffel geldt vanaf 50 leads.

Vergoeding: 42,50 affiliate Totale vergoeding: 53,57 
*/

UPDATE
	lead
SET
	lead_program_id = 3303
WHERE
	affiliate_id = 8350 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 6336 AND lead_program_id != 3303) AND
	(SELECT COUNT(*) FROM lead WHERE affiliate_id = 8350 AND
			payment_period_id IN (SELECT Id FROM payment_period WHERE processed = false) AND
			lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 6336) AND
			status = 'ACCEPTED') >= 50;

/** 17 December 2008, Dineke Staffel belnu **/
/* Two separate staffels: Sim-Only and Algemeen
*/


/* Algemeen 6 up to 9 --> 2521 */
UPDATE 
    lead
SET 
    lead_program_id = 2521
WHERE 
    lead_program_id IN (1036, 2521, 2524, 2526) AND
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE
	                     lead_program_id IN (1036, 2521, 2524, 2526) AND
				         status = 'ACCEPTED' AND 
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
				     GROUP BY 
				         affiliate_id 
				     HAVING 
				         COUNT(id) BETWEEN 6 AND 9
				     );
				
/* Algemeen 10 up to 19 --> 2524 */
UPDATE 
    lead
SET 
    lead_program_id = 2524
WHERE 
    lead_program_id IN (1036, 2521, 2526) AND	
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE
	                     lead_program_id IN (1036, 2521, 2524, 2526) AND
				         status = 'ACCEPTED' AND 
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
				     GROUP BY 
				         affiliate_id 
				     HAVING 
				         COUNT(id) BETWEEN 10 AND 19
				     );
				         
	/* Algemeen 20 and up --> 2526 */
UPDATE 
    lead
SET 
    lead_program_id = 2526
WHERE 
    lead_program_id IN (1036, 2521, 2524) AND	
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE
	                     lead_program_id IN (1036, 2521, 2524, 2526) AND
				         status = 'ACCEPTED' AND
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
				     GROUP BY 
				         affiliate_id 
				     HAVING 
				         COUNT(id) >= 20
				     );
				         
	/* Sim-Only  6 up to 9 --> 2523 */
UPDATE 
    lead
SET 
    lead_program_id = 2523
WHERE 
    lead_program_id IN (2463, 2525, 2527) AND
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE
	                     lead_program_id IN (2463, 2523, 2525, 2527) AND
				         status = 'ACCEPTED' AND
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
				     GROUP BY 
				         affiliate_id 
				     HAVING 
				         COUNT(id) BETWEEN 6 AND 9
				     );
				         
	/* Sim-Only 10 up to 19 --> 2525 */
UPDATE 
    lead
SET 
    lead_program_id = 2525
WHERE
    lead_program_id IN (2463, 2523, 2527) AND 
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE
	                     lead_program_id IN (2463, 2523, 2525, 2527) AND
				         status = 'ACCEPTED' AND 
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
				     GROUP BY 
				         affiliate_id 
				     HAVING 
				         COUNT(id) BETWEEN 10 AND 19
				     );
				         
	/* Sim-Only 20 and up --> 2527 */
UPDATE 
    lead
SET 
    lead_program_id = 2527
WHERE 
    lead_program_id IN (2463, 2523, 2525) AND
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
	affiliate_id IN (SELECT 
	                     affiliate_id 
	                 FROM 
	                     lead 
	                 WHERE
	                     lead_program_id IN (2463, 2523, 2525, 2527) AND
				         status = 'ACCEPTED' AND
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
				     GROUP BY 
				         affiliate_id 
				     HAVING 
				         COUNT(id) >= 20
				     );