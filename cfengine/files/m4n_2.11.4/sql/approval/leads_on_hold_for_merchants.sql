/* March 30 2009, Dineke: Put all leads from these merchants on hold.
	This one is executed at the end of the month, right before "accept_leads_one_month_old" 
	
	Set all leads on hold from the merchants with these accountmanagers:
	* 11217 (Diederick Ubels)
	* 10317 (Tim Markestein; M4N-Mark)
	* 17759 (Tim Markestein; Business Development)
	* 5667 (Patrick Emmen en Jonas Sluijs)

*/

UPDATE
	lead
SET
	status = 'ON_HOLD'
WHERE
	status = 'TO_BE_APPROVED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id IN 
							(SELECT user_id FROM invoice_settings WHERE account_manager_user_id IN (11217, 10317, 17759, 5667))
						);
						
/* Set all leads on hold from these merchants: */
UPDATE
	lead
SET
	status = 'ON_HOLD'
WHERE
	status = 'TO_BE_APPROVED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id IN
							(2608,	--Gsm Stunter
							 16754--AnderZorg
							)
						);