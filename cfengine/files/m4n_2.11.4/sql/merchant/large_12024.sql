/* May 14 2010, Jan, ticket: #5082
Zou jij voor adverteerder Large (id 12024) alle sales die daarop binnenkomen en in description 3 'Ideal' hebben staan, automatisch kunnen laten goedkeuren?
Dit mag voor alles wat er nu nog in de accordeerlijst staat.
*/

UPDATE 
	lead 
SET 
	status = 'ACCEPTED' 
WHERE 
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 12024) AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	description3 = 'Ideal' AND 
	status = 'TO_BE_APPROVED';

/**
 * Ticket #3891, special deal.
 * Andre Cesta - 2009-09-23.
 */
UPDATE 
    lead 
SET 
    lead_program_id = 3387
WHERE 
	lead_program_id = 2343 AND 
	status = 'ACCEPTED' AND
	created > '2009-09-24' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11527;

UPDATE 
    lead 
SET 
    lead_program_id = 3385
WHERE 
	lead_program_id = 2297 AND 
	status = 'ACCEPTED' AND
	created > '2009-09-24' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11527;
