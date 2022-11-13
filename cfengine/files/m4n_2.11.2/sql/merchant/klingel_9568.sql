/* Dineke, bij deze wilde ik je vragen of alle leads automatisch in het nieuwe leadprogramma (ID 4024) terecht kunnen komen vanaf 2 Maart? */
UPDATE
	lead
SET
	lead_program_id = 4024
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 9568 AND id != 4024) AND
	created > '2010-03-02';

