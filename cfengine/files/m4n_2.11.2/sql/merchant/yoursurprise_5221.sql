/* June 24 2010, Jan, ticket: #5410
Requested by: Liesbeth
Leads with a 'Belevenis' as description3 should be moved to lead program 4549, starting May 24th.
*/
UPDATE 
    lead
SET 
    lead_program_id = 4549
WHERE 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2272, 2341, 2342) AND	
	description3 = 'Belevenis';
