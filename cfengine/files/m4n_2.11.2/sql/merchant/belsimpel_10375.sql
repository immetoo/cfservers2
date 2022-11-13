/* 17 December 2009, Dineke:
reported by Jonas: Zou je Portable Gear (578 )automatisch in de 20+ staffel (3546 )van Belsimpel (10375 )willen zetten?
*/
UPDATE
	lead
SET
	lead_program_id = 3546
WHERE
	lead_program_id = 1788 AND
	affiliate_id = 578 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* Feb 23, Dineke, #6793:
	Special deal webaholics (13435): always gets lead_program_id = 3547
*/
UPDATE
	lead
SET
	lead_program_id = 3547
WHERE
	lead_program_id = 1788 AND
	affiliate_id = 13435 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
