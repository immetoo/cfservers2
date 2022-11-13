/* April 29 2010, Jan, ticket: #4924
Zou jij alle sales van Menatwork (id 14458) vanaf deze maand voor de affiliate Zinngeld (id 5575) in leadprogramma 3886 kunnen laten vallen?
Dit moet vanaf nu altijd gelden, dus automatisch.
Thank you! 
*/
UPDATE
	lead
SET
	lead_program_id = 3886
WHERE
	lead_program_id IN (3173, 3174) AND
	affiliate_id = 5575 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-04-01' ;

/* April 16, 2010, Jan, ticket: #4831
Zou jij het id van Fashionchick (8880) aan lp 4295 van Menatwork kunnen hangen, per vandaag? Id menatwork 14458.
Update excluded zone 818560 from the deal.

Update December 14th 2010, Jan, Excluded zone 489507 from the deal 
*/
UPDATE
	lead
SET
	lead_program_id = 4295
FROM
	click
WHERE
	lead.click_id = click.id AND
	lead.lead_program_id IN (3173, 3174) AND
	lead.affiliate_id  = 8880 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.created >= '2010-04-16' AND
	click.zone_id NOT IN (818560, 489507);
	
/* January 26 2010, Jan, ticket: #4503
Aangevraagd door: Liesbeth
Verder nog special deals voor de volgende affiliates. Deze special deal gaat PER ACCOUNT:
- Fashion.nl id 10578
- Girlstyle id 6900

Ze moeten bij 75 goedgekeurde sales of meer in lp 3886 vallen, en 10,50% per sale krijgen.
*/
UPDATE
	lead
SET
	lead_program_id = 3886
WHERE
	lead_program_id IN (3173, 3174) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-02-01' AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3173, 3174, 3886, 4086) AND
			             affiliate_id IN (5575, 10578, 6900) AND 
				         status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
				         created >= '2010-02-01' 
			         GROUP BY 
			         	affiliate_id 
			         HAVING 
			         	COUNT(id) >= 75);
			         	
/* October 13th 2010, Jan, ticket: #6033
Op dit moment bestaat de volgende special deal:
Zinngeld (ID 5575) bij > 75 sales (netto) aan lp 3886 van adverteerder Menatwork (id 14458):
Kun je hier standaard van maken (dus niet pas vanaf 75 leads)

Kun je ook standaard Four People (ID 8639) koppelen aan lp 3886 van adverteerder Menatwork (id 14458).
Ingangsdatum 1 oktober.
*/			         	
UPDATE
	lead
SET
	lead_program_id = 3886
WHERE
	lead_program_id IN (3173, 3174) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-10-01' AND
	affiliate_id IN (5575, 8639);

/* December 10, 2009, Jan, ticket: #4366
Aanvrager: Liesbeth

Adverteerder: Menatwork
ID Adverteerder:  14458

Exploitanten (in geval van special deal. Username + id):
Ciao-shopping id 7905

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):  
3639 + 3640

Wat moet er precies gebeuren?
De affiliate aan de 2 leadprogramma's koppelen.
Lp 3639 bij 1 t/m 7 sales per maand
Lp 3640 vanaf 10 sales per maand.


Startdatum: 18/11
Einddatum: nvt
*/

UPDATE
	lead
SET
	lead_program_id = 3639
WHERE
	lead_program_id = 3173 AND
	affiliate_id = 7905 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
UPDATE 
    lead 
SET 
    lead_program_id = 3640
WHERE 
	lead_program_id = 3639 AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3639, 3640) AND 
				         status = 'ACCEPTED' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 10);

/* December 10, 2009, Jan, ticket: #4358
Reported by: Liesbeth
Zou jij de affiliate zinngeld (id 5575) kunnen koppelen aan het hoogste segment van Menatwork (id 14458) -> lp 3174, 
zodat de affiliate automatisch de hoogste vergoeding krijgt? 
*/

UPDATE
	lead
SET
	lead_program_id = 3174
WHERE
	lead_program_id = 3173 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 5575 AND
	created >= '2009-10-01';

/**
 * 2009-09-25  Andre Cesta
 * Echte Staffel 
 * 
 * December 10, 2009, Jan, ticket: #4367
 * Reported by Liesbeth
 * Zou jij voor Menatwork (id 14458) de volgende willen aanpassen:
 * lp 3173 standaard vergoeding
 * lp 3174 laten ingaan bij meer dan 10 sales per maand
 */
UPDATE 
    lead 
SET 
    lead_program_id = 3174
WHERE 
	lead_program_id = 3173 AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2009-09-25' and
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (3174, 3173, 4086) AND 
				         status = 'ACCEPTED' AND 
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) >= 10);
			         
/* August 31 2010, Jan, ticket: #5796
Aanvrager: Liesbeth

Exploitanten (in geval van special deal. Username + id):
Rickdebruin (id 14923)
Imbull (id 11033)

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):  
3886

Wat moet er precies gebeuren?

Extra staffel ingesteld voor deze 2 affiliates, bij meer dan 75 sales (netto) alle sales in lp 3886 laten vallen

Startdatum: 15 augustus (dus met terugwerkende kracht)
Einddatum: 15 oktober (De special deals die verder staan ingesteld voor Menatwork moeten ook allemaal als einddatum 15 oktober hebben en op netto orders worden berekend.)

Update September 10 2010, Jan, ticket: #5889
Added affiliate Fourpeople (8639) to the deal
*/
       
UPDATE 
    lead 
SET 
    lead_program_id = 3886
WHERE 
	lead_program_id IN (3173, 3174)  AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-08-15' AND
	affiliate_id IN (
		SELECT	
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (3174, 3173, 4086) AND 
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			created >= '2010-08-15' AND
			affiliate_id IN (14923, 11033, 8639)
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 75
	);
