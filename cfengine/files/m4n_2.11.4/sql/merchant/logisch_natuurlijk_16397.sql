/**
 * Ticket 4193: echte staffel based on price, not on quantity.
 * Andre Cesta.  Implementation date: 2009-11-06.
 */ 
UPDATE lead SET 
	lead_program_id = 3537    
WHERE 
	status = 'ACCEPTED' AND
	created > '2009-11-04' AND
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
    lead_program_id = 3493 AND 
    price between 51 and 80;


UPDATE lead SET 
	lead_program_id = 3538    
WHERE 
	status = 'ACCEPTED' AND
	created > '2009-11-04' AND	
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
    lead_program_id = 3493 AND 
    price between 80 and 110;

UPDATE lead SET 
	lead_program_id = 3540    
WHERE 
	status = 'ACCEPTED' AND
	created > '2009-11-04' AND		
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
    lead_program_id = 3493 AND 
    price >= 110;
