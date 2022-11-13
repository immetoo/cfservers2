/** special lead deal for user ROAS.nl  **/

UPDATE lead
SET lead_program_id = 1405
WHERE 
	affiliate_id = 11684 AND 
	status IN ('TO_BE_APPROVED', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 1396;
	
/** special lead deal voor actie banners **/
UPDATE 
	lead
SET 
	lead_program_id = 1405
WHERE 
	click_id IN (SELECT click_id FROM click WHERE advertisement_id IN (423997,424004,424008,424011)) AND 
	status IN ('TO_BE_APPROVED', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	lead_program_id = 1396;
