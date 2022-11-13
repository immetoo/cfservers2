/* September 13 2010, Dineke, Ticket #5893:
Requested by Mirte:

Alle leads van Euroclix (ID 105) vanaf 13/09 naar leadprogramma 4794 voor de adverteerder 333Travel (ID 21010).
*/
UPDATE
	lead
SET
	lead_program_id = 4794
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 21010 AND id != 4794) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 105 AND
	created > '2010-09-13';