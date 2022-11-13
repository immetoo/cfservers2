/* January 27 2010, Dineke: Special deal mailing Euroclix (105):
all normal leads (program 127) are promoted to 3895 */
UPDATE
	lead
SET
	lead_program_id = 3895
WHERE
	lead_program_id = 127 AND
	affiliate_id = 105 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* November 10 2009, Dineke: Special deal requested by Jonas:
Zou je de affiliate GSM helpdesk (14570) standaard in de volgende staffel willen zetten vanaf 5-10 (als het nog mogelijk is)?
-          Typhone (60) leadprogramma 3590 (zou je dit leadprogramma op 42.50 aff en 58.82 totaal willen zetten?)
Staffel geldt voor de alle leadprogramma’s behalve:
Typhone: 1364
*/
UPDATE
	lead
SET
	lead_program_id = 3590
WHERE
	affiliate_id = 14570 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 60 AND lead_program_id NOT IN (3590, 1364)) AND
	status != 'BLOCKED' AND
	created > '2009-10-05';
	
/* Ticket #108: staffel Typhone (id 60)

These programs count for the staffel:

1380  	Sim Only - Telt mee voor de staffel  								€ 25.0 	€ 36.71   	
1364 	Los product - Telt mee voor de staffel, vergoeding blijft gelijk 	€ 5.0 	€ 7.35 	
1063 	Toestel + Abonnement - Staffels: 20+ sales 	wijzigen 				€ 40.0 	€ 58.82 	
1062 	Toestel + Abonnement - Staffels: 10 - 19 sales					 	€ 35.0 	€ 51.47 	
1061 	Toestel + Abonnement - Staffels: 4 - 9 sales 						€ 30.0 	€ 44.12 	
127 	Toestel + Abonnement - Staffels: 1 - 3 sales						€ 25.0 	€ 36.71

But program 1364 should never be updated to another program, this has been happening in the past
Now (September 25 2008) we changed the staffel and will compensate where necessary
*/

UPDATE 
	lead 
SET 
	lead_program_id = 1061
WHERE 
	lead_program_id IN (127,1380,1062,1063) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (127,1364,1380,1061,1062,1063) AND
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 4 AND 9
	);
	
UPDATE 
	lead 
SET 
	lead_program_id = 1062
WHERE 
	lead_program_id IN (127,1380,1061,1063) AND 
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (127,1364,1380,1061,1062,1063) AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 10 AND 19
	);
	
UPDATE 
	lead 
SET 
	lead_program_id = 1063
WHERE 
	lead_program_id IN (127,1380,1061,1062) AND 
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (127,1364,1380,1061,1062,1063) AND
		status = 'ACCEPTED' AND 
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
	GROUP BY affiliate_id HAVING COUNT(id) > 19
	);
	
/* 10 november 2009: Kan je 11174 – fgmedia in de hoogste staffel van Typhone zetten? (Excl. Los product) */
/* October 29 2009, Dineke: requested by Jonas: add affiliate Portable Gear (578) to deal */
UPDATE lead
SET lead_program_id = 1063
WHERE lead_program_id IN (127, 1380, 1061, 1062) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (11174, 578);