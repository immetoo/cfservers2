/* 30 December, 2009, Jan, ticket: #4419



IMPORTANT NOTE: This staffel is based on the click creation date rather than the lead creation date. Since the cookie time for LOI is one year,
                this means that this staffel MUST stay in the system until after the 31st of October 2011!   



Reported by: Michiel Bakker
Hierbij hetzelfde verzoek als vanochtend voor de LOI. LOI Kidzz (13010) wil alle affiliates van 28 december 2009 tot 15 februari 2010 automatisch in het GOUD segment plaatsen.

Dit geldt voor 4 staffels:

    * offID 2686 (brons) wordt dus 2688 (goud)
    * 2689 wordt 2691
    * 2692 wordt 2694
    * 3497 wordt 3797 (juiste vergoedingen worden nog ingesteld bij deze)
	* 3498 wordt 3800
	* 
	*

Update: 17 February 2010, Jan
Deal extended until the 14th of March 2010.

UPDATE: August 17 2010, Jan, ticket:#5700 Reactivated staffel for the period of 16-8-2010 t/m 31-10-2010

1: 2686 -> 2688
*/
UPDATE
	lead
SET
	lead_program_id = 2688
WHERE
	lead_program_id IN (2686, 2687) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	(	
		click_created BETWEEN '2009-12-28' AND '2010-03-14' OR
		click_created BETWEEN '2010-08-16' AND '2010-11-01'
	);
	
/* 2: 2689 -> 2691 */
UPDATE
	lead
SET
	lead_program_id = 2691
WHERE
	lead_program_id IN (2689, 2690) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	(	
		click_created BETWEEN '2009-12-28' AND '2010-03-14' OR
		click_created BETWEEN '2010-08-16' AND '2010-11-01'
	);

/* 3: 2692 -> 2694 */
UPDATE
	lead
SET
	lead_program_id = 2694
WHERE
	lead_program_id IN (2692, 2693) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	(	
		click_created BETWEEN '2009-12-28' AND '2010-03-14' OR
		click_created BETWEEN '2010-08-16' AND '2010-11-01'
	);

/* 4: 3497 -> 3797 */
UPDATE
	lead
SET
	lead_program_id = 3797
WHERE
	lead_program_id IN (3497, 3796) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	(	
		click_created BETWEEN '2009-12-28' AND '2010-03-14' OR
		click_created BETWEEN '2010-08-16' AND '2010-11-01'
	);
	
/* 5: 3498 -> 3800 */
UPDATE
	lead
SET
	lead_program_id = 3800
WHERE
	lead_program_id IN (3498, 3799) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	(	
		click_created BETWEEN '2009-12-28' AND '2010-03-14' OR
		click_created BETWEEN '2010-08-16' AND '2010-11-01'
	);

/* 30 December, 2009, Jan, ticket: #4418
Reported by: Michiel Bakker
Twee nieuwe staffels voor LOI Kidzz (13010), waarbij tijdelijk tot 15 februari ook iedereen in GOUD terecht moet komen zoals in vorig verzoek:
brons - zilver - goud:

3498 - 3799 - 3800
en
3497 - 3796 - 3797

1: 5-8 sales 3498 -> 3799
*/
UPDATE
	lead
SET
	lead_program_id =  3799
WHERE
	lead_program_id IN (3498) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-28' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (3498, 3799, 3800) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 5 AND 8
	);
	
/* 1: 9+ sales 3497 -> 3796 */ 
UPDATE
	lead
SET
	lead_program_id = 3800
WHERE
	lead_program_id IN (3498, 3799) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-28' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (3498, 3799, 3800) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 9
	);
	
/* 2: 5-8 sales 3497 -> 3796*/ 
UPDATE
	lead
SET
	lead_program_id = 3796
WHERE
	lead_program_id IN (3497) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-28' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (3497, 3796, 3797) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 5 AND 8
	);
	
/* 2: 9+ sales 3497, 3796 -> 3797 */ 	
UPDATE
	lead
SET
	lead_program_id = 3797
WHERE
	lead_program_id IN (3497, 3796) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-28' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (3497, 3796, 3797) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 9
	);

/* Ticket 2616 
25 February 2009, Dinele
Aanvrager: Michiel Bakker
Adverteerder: LOI ID Adverteerder: 13009

Leadprogramma's: 1: - 2686 > 2687 > 2688 
				 2: - 2689 > 2690 > 2691
				 3: - 2692 > 2693 > 2694 

Wat moet er precies gebeuren?
3 staffels op basis van de volgende aantallen leads: Segment 1 = 0 t/m 4 sales Segment 2 = 5 t/m 8 sales Segment 3 = 9+ sales
*/

/* Staffel 1 */
/** 5 up to 8 sales: 2686 > 2687 **/
UPDATE lead 
SET lead_program_id = 2687
WHERE
	lead_program_id IN (2686, 2688) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-28' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2686, 2687, 2688) AND status = 'ACCEPTED'  AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 5 AND 8
	);
	
/** 9 sales and up 2687 > 2688 **/
UPDATE lead 
SET lead_program_id = 2688
WHERE
	lead_program_id IN (2686, 2687) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-28' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2686, 2687, 2688) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 9
	);
	
/* Staffel 2 */
/** 5 up to 8 sales: 2689 > 2690 **/
UPDATE lead 
SET lead_program_id = 2690
WHERE
	lead_program_id IN (2689, 2691) AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-28' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2689, 2690, 2691) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 5 AND 8
	);
	
/** 9 sales and up 2690 > 2691 **/
UPDATE lead 
SET lead_program_id = 2691
WHERE
	lead_program_id IN  (2689, 2690) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-28' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2689, 2690, 2691) AND status = 'ACCEPTED' AND 
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 9
	);
	
/* Staffel 3 */
/** 5 up to 8 sales: 2692 > 2693 **/
UPDATE lead 
SET lead_program_id = 2693
WHERE
	lead_program_id IN (2692, 2694) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-28' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2692, 2693, 2694) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 5 AND 8
	);
	
/** 9 sales and up 2693 > 2694 **/
UPDATE lead 
SET lead_program_id = 2694
WHERE
	lead_program_id IN  (2692, 2693) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-28' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2692, 2693, 2694) AND status = 'ACCEPTED' AND 
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 9
	);