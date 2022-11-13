/* May 28 2010, Dineke, Ticket #5211:
 * Requested by Michiel: 
 * Hoi Staffel,
Zouden per direct (1 mei) de leads van affiliate 19963 bij adverteerder 17783 overgezet kunnen worden op een ander lead ID:
ID 3829 wordt ID 4445
Alvast bedankt! 
 */
UPDATE lead
 	SET lead_program_id = 4445
 	WHERE	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 			lead_program_id IN (3829) AND
 			affiliate_id = 19963 AND
 			created > '2010-05-01';
 