/* May 31 2010, Jan, ticket: #5229
Alle leads van affiliate Werksite (6948) bij adverteerder JobTrack (9620) op leadprogramma 1591 moeten worden omgezet naar leadprogramma 4451.
*/

UPDATE
	lead
SET
	lead_program_id = 4451
WHERE
	lead_program_id = 1591 AND
	affiliate_id = 6948 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
/* October 28 2010, Dineke: reject leads from affiliate 11079 */
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	affiliate_id = 11079 AND
	lead_program_id IN (SELECT lead_programs(9620)) AND
	created > '2010-10-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status NOT IN ('BLOCKED', 'REJECTED');