/* November 9 2009, Jan and Dineke, ticket #4209

Welk type staffel is het (maak 1 keuze)?
 
1) Echte staffel
 
The staffel needs to be changed into the following:
 
3202  1-10 sales 
3203  11-50 sales
3204  50+ sales
 
 Startdatum: 06/11,2009
 
Einddatum: nvt
*/

UPDATE lead
 	SET lead_program_id = 3203
 	WHERE status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 3202 AND
 	affiliate_id IN 
 		(SELECT
 			affiliate_id
 		FROM
 			lead
 		WHERE
 			lead_program_id IN (3202, 3203, 3296) AND 
 			status = 'ACCEPTED' AND
 			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 		GROUP BY
 			affiliate_id HAVING COUNT(id) BETWEEN 11 AND 50
 		);

 										
UPDATE lead
 	SET lead_program_id = 3204
 	WHERE status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id in (3202, 3203) AND
 	affiliate_id IN 
 		(SELECT
 			affiliate_id
 		FROM
 			lead
 		WHERE
 			lead_program_id IN (3202, 3203, 3204, 3296) AND 
 			status = 'ACCEPTED' AND
 			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 		GROUP BY affiliate_id HAVING COUNT(id) > 50
 		);	