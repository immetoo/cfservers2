/* December 20 2010, Jan, ticket: #6459
Kan jij bij adverteerder MoneYou Hypotheken (18095) alles leads die binnen komen met een click na 7 december van affiliate homefinance (9897) op 
leadprogramma 3878 laten landen op 3877
*/
UPDATE
	lead
SET
	lead_program_id = 3877
WHERE
	lead_program_id = 3878 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created >= '2010-12-07' AND
	affiliate_id = 9897;
	