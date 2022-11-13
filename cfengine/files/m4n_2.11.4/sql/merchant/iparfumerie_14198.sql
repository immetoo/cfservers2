/* November 24 2010, Jan, ticket: #6333
Zou jij affliiate E-commerce (ID 12961) standaard aan leadprogramma ID 3112 van adverteerder iParfumerie (ID 14198 ) kunnen hangen?
Het is een staffel en zij zitten nu dan standaard in de tweede groep. Wanneer ze 20+ producten genereren moeten ze wel nog naar staffel 3 kunnen (Lp 3113, 12%)
Graag vanaf vandaag t/m 17 december.
*/

UPDATE
	lead
SET
	lead_program_id = 3112
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 3111 AND
	created >= '2010-11-17' AND
	created < '2010-12-18' AND
	affiliate_id = 12961;
	
/** July 24 2009, Dineke: Ticket #3555
Regular staffel, starts from 7th of September
3111	8% commissie tot 10 sales 
3112	10% commissie 10 - 20 sales  	
3113	12% commissie 20 of meer sales 	
**/
UPDATE
	lead
SET
	lead_program_id = 3112
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 3111 AND
	created > '2009-09-08' AND
	click_created < '2011-01-01' AND
	affiliate_id IN ( 
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3111, 3112, 3113) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status = 'ACCEPTED'
		GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 10 AND 19
	);
	
UPDATE
	lead
SET
	lead_program_id = 3113
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (3111, 3112) AND
	created > '2009-09-08' AND
	click_created < '2011-01-01' AND
	affiliate_id IN ( 
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3111, 3112, 3113) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status = 'ACCEPTED'
		GROUP BY affiliate_id HAVING COUNT(id) >=20
	);
		