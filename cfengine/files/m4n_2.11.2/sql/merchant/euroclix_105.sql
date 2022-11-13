/**
* 22-5-2008 Staffel Euroclix (105)
* Gaat in op 22-5-2008 
**/
UPDATE 
    lead
SET 
    lead_program_id = 1919
WHERE
    lead_program_id = 702 AND 
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    affiliate_id IN (9583,9946);