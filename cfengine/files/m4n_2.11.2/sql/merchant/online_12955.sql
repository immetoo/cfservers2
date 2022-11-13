/* June 4 2010, Jan, ticket: #5287
Is het mogelijk alle clicks en leads die vanaf vandaag t/m 20 juni worden gezet en toebehoren aan leadprogramma 2652 (single play) over te hevelen 
naar leadprogramma 4469 (single play tijdelijke actie)?
*/
UPDATE
	lead
SET
	lead_program_id = 4469
WHERE
	lead_program_id = 2652 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-06-04' AND
	created < '2010-07-13';


/* March 15 2010, Dineke:
 * Hoi Dineke zou je alle leads van DMG (14878) voor Online (12955) op het volgende programma willen zetten?
Leads die binnen komen op:

2652 naar 3988
bepaalde omschrijvingen naar 3989
per 15 maart 2010
*/
	
UPDATE
	lead
SET
	lead_program_id = 3988
WHERE
	lead_program_id = 2652 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 14878 AND
	created > '2010-03-15';

UPDATE
	lead
SET
	lead_program_id = 3989
WHERE
	lead_program_id IN (2652, 2757, 3988) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 14878 AND
	description2 IN ('adsl_extra_telefonie_totaal', 'adsl_extra_telefonie_basis', 'aetb_familyhd', 'aett_entertainmenthd') AND
	created > '2010-03-15';	

/**
 * Staffel Online
 **/

/* December 15, Jan, ticket: #4384
Reported by Jonas
Zou je de volgende staffel willen doorvoeren. Het gaat om Online (12955).

Leads die het volgende meekrijgen in beschrijving 2 dienen op het volgende leadprogramma gezet te worden: 3738

adsl_extra_telefonie_totaal
adsl_extra_telefonie_basis
aetb_familyhd
aett_entertainmenthd

De leads die via de special deal binnenkomen blijven gewoon op dat programma staan en  hoeven niet te verhuizen (krijgen dus geen extra 10)

January 15 2010, Dineke: addition: promote to lead_program 3216 instead of 3738 for this group of affiliates:

 * Moneymiljonair (307)
 * Search Factory (12796)
 * Zinngeld (5575)
 * Search2Sale (16341)
 * Dekatoo (11315)
*/
UPDATE
	lead
SET
	lead_program_id = CASE WHEN affiliate_id IN (307, 12796, 5575, 16341, 11315) THEN 3216 ELSE 3738 END
WHERE
	lead_program_id IN (2652, 2757) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	description2 IN ('adsl_extra_telefonie_totaal', 'adsl_extra_telefonie_basis', 'aetb_familyhd', 'aett_entertainmenthd') AND
	created >= '2009-12-14';		

/* December 1st 2009, Dineke: 100+ goedgekeurde sales: programma 2757 */
UPDATE 
    lead 
SET 
    lead_program_id = 2757
WHERE 
	lead_program_id = 2652 AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (2652, 2757, 3738) AND 
				         status = 'ACCEPTED' AND 
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 100);
			         
/* April 6 2010, Dineke:
 Zou je alle leads die op programma 2652 wordt gezet op programma 4070 willen zetten en leads die op programma 3738 binnenkomen op programma 4071 willen zetten?
Dit vanaf vandaag t/m 12 april.
 */
UPDATE
	lead
SET
	lead_program_id =	CASE	WHEN lead_program_id = 2652 THEN 4070
								WHEN lead_program_id = 3738 THEN 4071
						END
WHERE
	lead_program_id IN (2652, 3738) AND
	created BETWEEN '2010-04-06' AND '2010-04-13' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

 