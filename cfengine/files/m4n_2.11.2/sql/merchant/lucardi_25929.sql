/* March 14 2011, Jan, ticket: #7030
Kan jij ervoor zorgen dat de sales van dekatoo (id: 11315) voor Lucardi (id: 25929) van leadprogramma 6190 op het leadprogramma voor adwords 
(id:6336) terecht komen?

Dank alvast!
*/

UPDATE
	lead
SET
	lead_program_id = 6336
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 6190 AND
	affiliate_id = 11315;