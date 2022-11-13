/* Jun 16 2009, Dineke: Special deal

Kan je Euroclix website. (ID: 11805) standaard in het leadprogramma 3031 zetten?
Vergoeding wordt € 30,- aff / € 35.714 adv.
same for affiliate trijman
*/

UPDATE lead 
	SET
		lead_program_id = 3031
	WHERE
		lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 12165 AND id != 3031 AND id != 2948) AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		affiliate_id IN (6401, 11805);
	
/* 23 June 2009, Dineke, ticket #3047:
Reported same day by Patrick T.
Zou je voor Mobiel.nl (id=12165) een staffel willen inbouwen en de vergoeding willen aanpassen?

Staffel #1                            Offid=2360                         0 t/m 49 sales       	        
Staffel#2                             Offid=3031                         50+ Sales                       
*/
UPDATE
	lead
SET
	lead_program_id = 3031
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2360 AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(SELECT
			affiliate_id
		FROM 
			lead
		WHERE
			lead_program_id IN (2360, 3031) AND 
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	    GROUP BY affiliate_id HAVING COUNT(id) >= 50
	);
	