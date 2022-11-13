/* Christineleduc 
July 7 2009, Dineke:
put all negative leads on hold. Temp measurement: see #2689 for the whole negative lead problem
*/

UPDATE
	lead
SET
	status = 'ON_HOLD'
WHERE
	status IN ('TO_BE_APPROVED', 'ACCEPTED') AND
	price = -4.99 AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 5504) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
/*
 *	Voor affiliate Corien (22443) heb ik een special deal afgesproken met adverteerder Christine le duc (5504). 
 *	Normaal gesproken geeft  Christine le duc een vergoeding van 15% op elk verkocht product. Affiliate Corien krijgt 16% vergoeding op elk verkocht product.
 *	Dit wordt ingehouden van onze marge zodat Christine le duc geen extra vergoeding hoeft te betalen.
 *	
 *	Dit gaat per direct in en heeft geen einddatum. Verder kan deze deal uiteraard op verborgen worden gezet.
 *
 */
	
UPDATE
	lead
SET
	lead_program_id = 4835
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 5504 and id != 4835) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 22443;
