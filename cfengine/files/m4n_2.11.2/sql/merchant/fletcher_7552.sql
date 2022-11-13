/* November 24 2010, Dineke, Ticket #6330:
 * Aanvrager: Fleur

Welk type staffel is het (maak 1 keuze)?
Special deal

Wat moet er precies gebeuren?
Alle affiliates krijgen bij een boeking met in description 1” F46” een dubbele vergoeding.

Dus wanneer description 1 bevat : F46 altijd LPID 5007

Startdatum: 19-11-2010
Einddatum: 31-12-2010
*/
UPDATE
	lead
SET
	lead_program_id = 5007
WHERE
	lead_program_id IN (SELECT lead_programs(7552)) AND
	description1 LIKE '%F46%' AND
	created BETWEEN '2010-11-19' AND '2011-01-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
/*
 * Staffel #3742. Fletcher.
 * Affiliate ingedemunnik (202) always gets at least lead program 2215
 * Andre Augusto Cesta.  2009-08-28.
 */
UPDATE 
    lead 
SET 
    lead_program_id = 2215
WHERE 
	lead_program_id = 2214 AND 
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 202;

/* July 19 2010, Dineke, #5552:
 * All affiliates get the highest staffel in the period 17 July up to September 31!
 */
UPDATE 
    lead 
SET 
    lead_program_id = 2216
WHERE 
	lead_program_id IN (2214, 2215) AND 
	created BETWEEN '2010-07-17' AND '2010-10-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* July 19 2010, Dineke, #5552:
 * Regular staffel:
 	* 2214: 0 - 10 sales
  	* 2215: 11 - 20 sales
    * 2216: 21 sales and up 
*/
--11 - 20? --> 2215
UPDATE
	lead 
SET
	lead_program_id = 2215
WHERE
	lead_program_id = 2214 AND
	status = 'ACCEPTED' AND 	
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id IN (2214, 2215, 2216) AND 		 
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 20
	);

-- > 20? --> 2216
UPDATE
	lead 
SET
	lead_program_id = 2216
WHERE
	lead_program_id IN (2214, 2215) AND
	status = 'ACCEPTED' AND 	
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id IN (2214, 2215, 2216) AND 		
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) > 20
	);
