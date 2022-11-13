/* 29 June 2010, Jan, ticket: #5431
Zou jij alle sales van Heine (id 11410) standaard op status 1 kunnen zetten?
Kun je dit per vandaag in laten gaan?
*/

UPDATE
	lead
SET
	status = 'ON_HOLD'
WHERE
	status = 'TO_BE_APPROVED' AND
	lead_program_id IN (select id from lead_program where merchant_id = 11410) AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/**
* Staffel van Heine, userid 11410
* ticket #1872
**/

/**
* 11 t/m 20 Offerid 2135
**/

UPDATE 
    lead
SET 
    lead_program_id = 2135
WHERE 
    lead_program_id IN (2134, 2136, 2137) AND
    status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (SELECT 
                         affiliate_id 
                     FROM 
                         lead
					 WHERE 
					     lead_program_id IN (2134, 2135) AND
					     status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
					     click_created < '2011-01-01' AND
					     payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
					GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 20);

/**
* 21 t/m 30 Offerid 2136
**/
UPDATE 
    lead
SET 
    lead_program_id = 2136
WHERE 
    lead_program_id IN (2134, 2135, 2137) AND
    status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (SELECT 
                         affiliate_id 
                     FROM 
                         lead
					 WHERE 
					     lead_program_id IN (2134, 2135, 2136) AND 
					     status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
					     click_created < '2011-01-01' AND
					     payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
					 GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 21 AND 30);
			
/**
* > 30 sales Offerid 2137
**/

UPDATE 
    lead
SET 
    lead_program_id = 2137
WHERE 
    lead_program_id IN (2134, 2135, 2136) AND
    status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (SELECT 
                         affiliate_id 
                     FROM 
                         lead
					 WHERE 
					     lead_program_id IN (2134, 2135, 2136, 2137) AND 
					     status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
					     click_created < '2011-01-01' AND
					     payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
					 GROUP BY affiliate_id HAVING COUNT(id) > 30);
			
/**
* July 6 2009, Dineke: Ticket #3087
Aanvrager Alexander:
Zou je Lysander (10929) standaard in de hoogste staffel (2137) voor heine (11410) kunnen doen?
Thanx! 
***/

UPDATE
	lead
SET
	lead_program_id = 2137
WHERE
	lead_program_id IN (2134,2135, 2136) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 10929 AND
	created > '2009-07-06';