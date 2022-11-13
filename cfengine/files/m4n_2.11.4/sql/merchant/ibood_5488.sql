/*
* Staffel IBood #
*/
UPDATE lead 
	SET lead_program_id = 2305
	WHERE lead_program_id = 918 
	AND status = 'ACCEPTED' AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
	AND affiliate_id 
		NOT IN (7723, 307, 6404, 327, 105, 3205, 7723, 10059, 11597, 531, 9592, 7452, 7718)
;
