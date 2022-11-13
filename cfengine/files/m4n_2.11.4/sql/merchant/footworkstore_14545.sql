
/**
 * Andre Cesta.
 * Ticket #4062.  Echte staffel. 
 * 
 * December 10, 2009, Jan, ticket: #4368
 * Reported by Liesbeth
 * Zou jij voorFootworkstore (id 14545) de volgende willen aanpassen: 
 * lp 3442 standaard vergoeding 
 * lp 3443 laten ingaan bij meer dan 10 sales per maand. 
 */ 
UPDATE
    lead
SET 
    lead_program_id = 3443
WHERE
	lead_program_id = 3442 AND
	status = 'ACCEPTED' AND
	created > '2009-10-15' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3442, 3443) AND 
				         status = 'ACCEPTED' AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 10);

