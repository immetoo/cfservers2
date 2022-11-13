/* March 16 2011, Jan, ticket: #7051
Kan je een special deal aanmaken voor ciao-shopping (id: 7905) vs Bruna (id: 21140)?

Alle sales van ciao-shopping moeten dan vanaf 1 april van het standaard leadprogramma (id: 4609) naar de special deal (leadprogramma: 6357) worden gezet.
*/

UPDATE
	lead
SET
	lead_program_id = 6357
WHERE 
	lead_program_id = 4609 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 7905 AND
	created >= '2011-04-01';