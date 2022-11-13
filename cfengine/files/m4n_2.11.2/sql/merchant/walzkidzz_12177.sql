/* April 23 2010, Jan, ticket: #4884
Aangevraagd door Liesbeth
Voor Babywalz had je dit al gedaan, maar dit moet nu ook voor Walzkidzz gebeuren
Als in beschrijving 2: 'Code' staat, moet daar lead programma 4326 aan hangen, als er 'Nocode' staat in beschrijving 2, dan moet de reguliere staffel
gelden (standaard in lp 2362 vallen).

Zou je dit ook per direct in kunnen laten gaan?
Update April 26 2010, 'Nocode' should go 4326 instead of 'Code' 
*/
UPDATE 
	lead 
SET 
	lead_program_id = 4326
WHERE 
    lead_program_id IN (2362, 2460, 2461) AND
   	description2 = 'Nocode' AND
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    created >= '2010-04-23';

/* November 27, 2009, Jan, ticket #4316
Reported by Natasja
Graag de affiliate HJKV80 id 7747 in hoger segment plaatsen bij adverteerder Walzkidzz id 12177

Leadprogramma van het hogere segment:
2461 Premium 2: vanaf 16 sales per maand

Gaat om deze vergoedingen

01-jan-2010 13-dec-2011 12,00% 15,60%
01-nov-2009 31-dec-2009 13,50% 17,55%

Graag per 30 okt 2009

Update March 2 2010, Jan, ticket: #4663
Reported by Liesbeth
Affiliate Lysander added to deal
*/

UPDATE
	lead
SET
	lead_program_id = 2461
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    lead_program_id IN (2362, 2460) AND
    affiliate_id IN (7747, 10929) AND
    created >= '2009-10-30';

/* 28 november 2008 Dineke

Offer id 2461: 16 sales of meer 7% commissie    	5.915 %    	9.1 %
Offer id 2460: 6-15 sales 6% commissie           	5.07 %      7.8 %         
Offer id 2362: 1-5 sales 5% commissie             	4.225 %     6.5 %  
*/

UPDATE 
    lead 
SET 
    lead_program_id = 2460
WHERE 
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    lead_program_id IN (2362, 2461) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (
    	SELECT 
        	affiliate_id 
        FROM 
            lead 
        WHERE 
            status = 'ACCEPTED' AND
            click_created < '2011-01-01' AND
		    lead_program_id IN (2362, 2460, 2461)
        GROUP BY 
            affiliate_id 
        HAVING 
            COUNT(id) BETWEEN 6 AND 15
	);
							
UPDATE 
    lead 
SET 
    lead_program_id = 2461
WHERE 
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    lead_program_id IN (2362, 2460) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (
    	SELECT 
            affiliate_id 
        FROM 
            lead 
        WHERE 
        	status = 'ACCEPTED' AND
        	click_created < '2011-01-01' AND
            lead_program_id IN (2362, 2460, 2461)
		GROUP BY 
            affiliate_id 
        HAVING 
            COUNT(id) >= 16
    );
						