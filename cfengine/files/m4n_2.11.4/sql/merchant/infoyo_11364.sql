/* December 16, 2009, Jan, ticket: #4385
Reported by Karin
Zou je ervoor kunnen zorgen dat affiliate ID 7360(thuiswerkbaan) bij adverteerder ID 11364 voortaan alle leads krijgt die vallen in off_id 3745?
*/

UPDATE
	lead
SET
	lead_program_id = 3745
WHERE
	lead_program_id = 2095 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 7360;
