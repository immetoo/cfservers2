/* January 11 2011, Jan, ticket: #6530
Affiliate ID: 14070 op het tarief van leadprogramma ID: 6161. Voor de duidelijkheid : leadprogramma ID: 6051 staat geïmplementeerd op de bedank 
pagina.
*/
UPDATE
	lead
SET
	lead_program_id = 6161
WHERE
	lead_program_id = 6051 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 14070 AND
	created >= '2011-01-11';