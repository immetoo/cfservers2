/* February 22 2011, Jan, ticket: #6857
Kan jij in het account van Goldendeals.nl (25933), affiliate promodeals (10963) koppelen aan leadprogramma 6281?

Promodeals krijgt vanaf 18 februari jl. een verhoogde vergoeding van 15%. 
*/

UPDATE
	lead
SET
	lead_program_id = 6281
WHERE
	lead_program_id = 6192 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 10963 AND
	created >= '2011-02-18';