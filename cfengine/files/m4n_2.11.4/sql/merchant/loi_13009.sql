/*  January 12 2010, Dineke:
Reported by Michiel:
Bij de volgende affiliates moeten leads met offid 2685 bij adverteerder 13009 (LOI) automatisch afgekeurd worden.

7723
8281
9869
6678
7284
7718
6404
17656
8098
6625
*/
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2685 AND
	affiliate_id IN (	7723,
						8281,
						9869,
						6678,
						7284,
						7718,
						6404,
						17656,
						8098,
						6625 );
							
/* December 29, 2009, Jan, ticket: #4414


IMPORTANT NOTE: This staffel is based on the click creation date rather than the lead creation date. Since the cookie time for LOI is one year,
                this means that this staffel MUST stay in the system until after the 31st of October 2011!  



LOI (13009) wil alle affiliates van 28 december 2009 tot 15 februari 2010 automatisch in het GOUD segment plaatsen.

Dit geldt voor 3 staffels:
    * offID 2667 (brons) wordt dus 2675 (goud)
    * 2676 wordt 2678
    * 2679 wordt 2681 
  
UPDATE February 12, 2010, Jan:
Er is op dit moment een script actief dat affiliates van LOI (13009) automatisch in de hoogste staffel plaatst. Dit script zou tot 15 februari 
moeten lopen, maar mag nu doorlopen tot zondag 14 maart.
UPDATE UPDATE! En nu tot en met 28 maart!

UPDATE UPDATE UPDATE! August 6 2010, Jan, ticket:#5654 Reactivated staffel for the period of 16-8-2010 t/m 31-10-2010
1:
*/
UPDATE
	lead
SET
	lead_program_id = 2675
WHERE
	lead_program_id IN (2667, 2674) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	(
		click_created BETWEEN '2009-12-28' AND '2010-03-29' OR
		click_created BETWEEN '2010-08-16' AND '2010-11-01'
	);

/* 2: */
UPDATE
	lead
SET
	lead_program_id = 2678
WHERE
	lead_program_id IN (2676, 2677) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	(
		click_created BETWEEN '2009-12-28' AND '2010-03-29' OR
		click_created BETWEEN '2010-08-16' AND '2010-11-01'
	);
	
/* 3: */
UPDATE
	lead
SET
	lead_program_id = 2681
WHERE
	lead_program_id IN (2679, 2680) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	(
		click_created BETWEEN '2009-12-28' AND '2010-03-29' OR
		click_created BETWEEN '2010-08-16' AND '2010-11-01'
	);

/* Ticket 2616 
25 February 2009, Dineke
Aanvrager: Michiel Bakker
Adverteerder: LOI ID Adverteerder: 13009

Leadprogramma's: 1: - 2667 > 2674 > 2675 
				 2: - 2676 > 2677 > 2678
				 3: - 2679 > 2680 > 2681
				 4: - 2682 > 2683 > 2684

Wat moet er precies gebeuren?
4 staffels op basis van de volgende aantallen leads: Segment 1 = 0 t/m 4 sales Segment 2 = 5 t/m 8 sales Segment 3 = 9+ sales
*/

/* Staffel 1 */
/** 5 up to 8 sales: 2667 -> 2674 **/
UPDATE lead 
SET lead_program_id = 2674
WHERE
	lead_program_id IN (2667) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-27' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2667, 2674, 2675) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 5 AND 8
	);
	
/** 9 sales and up 2674 -> 2675 **/
UPDATE lead 
SET lead_program_id = 2675
WHERE
	lead_program_id IN (2667, 2674) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-27' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2667, 2674, 2675) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 9
	);
	
/* Staffel 2 */
/** 5 up to 8 sales: 2676 > 2677 **/
UPDATE lead 
SET lead_program_id = 2677
WHERE
lead_program_id IN (2676) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-27' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2676, 2677, 2678) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 5 AND 8
	);
	
/** 9 sales and up 2677 > 2678 **/
UPDATE lead 
SET lead_program_id = 2678
WHERE
	lead_program_id IN  (2676, 2677) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND	
	click_created <= '2010-12-27' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2676, 2677, 2678) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 9
	);
	
/* Staffel 3 */
/** 5 up to 8 sales: 2679 > 2680 **/
UPDATE lead 
SET lead_program_id = 2680
WHERE
	lead_program_id IN (2679) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2679, 2680, 2681) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 5 AND 8
	);
	
/** 9 sales and up 2680 > 2681 **/
UPDATE lead 
SET lead_program_id = 2681
WHERE
	lead_program_id IN  (2679, 2680) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-27' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2679, 2680, 2681) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 9
	);

/* Staffel 4 */
/** 5 up to 8 sales: 2682 > 2683 **/
UPDATE lead 
SET lead_program_id = 2683
WHERE
	lead_program_id IN (2682) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-27' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2682, 2683, 2684) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 5 AND 8
	);
	
/** 9 sales and up 2683 > 2684 **/
UPDATE lead 
SET lead_program_id = 2684
WHERE
	lead_program_id IN  (2682, 2683) AND
	status = 'ACCEPTED'	AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created <= '2010-12-27' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (2682, 2683, 2684) AND status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) >= 9
	);