/* August 26 2010, Jan, ticket: #5764
Zoals zojuist besproken wil Bax-shop pre en backorders automatisch goed gaan keuren, maar dan tegen een lagere vergoeding. Nu is het zo dat Bax-shop een staffel hanteert en deze orders mogen wel qua aantallen in deze staffel meedraaien.

Ik heb hiervoor 3 aparte leadprgramma’s voor aangemaakt.

Lead ID: 4764   0-9 sales.
Lead ID: 4768   10-49 sales.
Lead ID: 4769   50> sales

De beschrijving die zij meegeven in description 3 is: “pre-backorder”.
*/

/*2480 -> 4764*/
UPDATE 
    lead 
SET 
    lead_program_id = 4764,
    status = 'ACCEPTED'
WHERE 
	lead_program_id IN (2480)  AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-08-27' AND 
	description3 = 'pre-backorder' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (2480, 3557, 3558, 4764, 4768, 4769) AND 
				         status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY 
			         	affiliate_id 
			         HAVING 
			         	COUNT(id) < 10
			        );

/*3557 -> 4768*/
UPDATE 
    lead 
SET 
    lead_program_id = 4768,
    status = 'ACCEPTED'
WHERE 
	lead_program_id IN (2480, 3557, 4764)  AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-08-27' AND 
	description3 = 'pre-backorder' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (2480, 3557, 3558, 4764, 4768, 4769) AND 
				         status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY 
			         	affiliate_id 
			         HAVING 
			         	COUNT(id) BETWEEN 10 AND 49
			        );
			       
/*3558 -> 4769*/
UPDATE 
    lead 
SET 
    lead_program_id = 4769,
    status = 'ACCEPTED'
WHERE 
	lead_program_id IN (2480, 3557, 3558, 4764, 4768)  AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-08-27' AND 
	description3 = 'pre-backorder' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (2480, 3557, 3558, 4764, 4768, 4769) AND 
				         status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY 
			         	affiliate_id 
			         HAVING 
			         	COUNT(id) >= 50
			        );
			        
/**
 * Ticket #4203 Baxshop.
 * Andre Cesta.  Implementation date: 6th-Nov-2009.
 */
UPDATE 
    lead 
SET 
    lead_program_id = 3557
WHERE 
	lead_program_id = 2480 AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2009-11-09' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (2480, 3557, 3558, 4764, 4768, 4769) AND 
				         status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 10 AND 49);

UPDATE 
    lead 
SET 
    lead_program_id = 3558
WHERE 
	lead_program_id IN (2480, 3557) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2009-11-09' AND	
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (2480, 3557, 3558, 4764, 4768, 4769) AND 
				         status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 50);
 