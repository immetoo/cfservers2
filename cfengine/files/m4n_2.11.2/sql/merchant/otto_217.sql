/*
 * Accorderen
 */
UPDATE lead SET 
    status = 'ACCEPTED' 
WHERE 
    status = 'TO_BE_APPROVED'
    AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
    lead_program_id = 602 AND 
    price < 500.0;
    
UPDATE lead SET 
    status = 'ON_HOLD'
WHERE 
    status = 'TO_BE_APPROVED' AND
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
    lead_program_id = 602 AND 
    price >= 500.0;
    
/* May 26 2010, Jan, ticket: #5163
Zou je alle leads van exploitant 12307 bij otto (ID 217) van 602 naar 2804 kunnen zetten. Ingangsdatum per vandaag. 
*/
UPDATE
	lead
SET
	lead_program_id = 2804
WHERE
	lead_program_id = 602 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id = 12307 AND
	created >= '2010-05-25';
	
/* June 9 2010, Jan, ticket: #5163
Otto (id 217) aan lpid 2804, voor affiliate zwemkleding.nl (id 17860) en affiliate 9181
*/
UPDATE
	lead
SET
	lead_program_id = 2804
WHERE
	lead_program_id = 602 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id IN (17860, 9181) AND
	created >= '2010-06-01';