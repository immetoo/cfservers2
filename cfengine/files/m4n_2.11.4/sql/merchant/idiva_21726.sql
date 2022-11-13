/* September 3 2010, Jan, ticket: #5844
Gaarne de volgende special invoeren:

Geldquiz 531 moet in leadprgramma 4786 bij Idiva 21726 komen te vallen.

Dit mag ingaan per vandaag. 
*/

UPDATE
	lead
SET
	lead_program_id = 4786
WHERE
	lead_program_id = 4756 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 531;