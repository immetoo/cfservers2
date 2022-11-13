/** 20 January 2009, Dineke: staffel Credit Europe
 
ID        Omschrijving

2585    > 200 sales
2144    Spaarrekening geopend (dit is dus het hoofdprogramma, draait al)

more than 200 sales: 2585 **/

UPDATE 
    lead
SET 
    lead_program_id = 2585
WHERE 
    lead_program_id = 2144 AND
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    affiliate_id IN (SELECT
                         affiliate_id 
                     FROM 
                         lead 
                     WHERE 
                         lead_program_id IN (2144, 2585) AND 
                         status = 'ACCEPTED' AND 
                         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
                     GROUP BY 
                         affiliate_id 
                     HAVING 
                         COUNT(id) > 200
                     );
