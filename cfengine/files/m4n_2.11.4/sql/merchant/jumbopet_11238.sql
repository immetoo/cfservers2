/* March 2 2009, Dineke:
staffel Jumbopet, reported by Liesbeth February 27th

All orders with a price of 100 euros and up are promoted to lead_program 2059
*/

UPDATE lead
	SET lead_program_id = 2059
	WHERE status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		lead_program_id = 2069 AND
		price >= 100;