/* August 18 2010, Jan, ticket: #5704
Kunnen alle leads van affiliate mr. Pabo (21641) voor de adverteerder Pabo (4714) worden afgekeurd.

Dit betreft namelijk een aparte deal. 
*/

UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	status IN ('ON_HOLD', 'TO_BE_APPROVED') AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 4714) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 21641;

	

/*
 * Voor affiliate Corien (22443) heb ik een special deal afgesproken met adverteerder PABO (4714). 

	Normaal gesproken geeft Pabo een vergoeding van 15% op elk verkocht product. Affiliate Corien krijgt 16% vergoeding op elk verkocht product. Dit wordt ingehouden van onze marge zodat Pabo geen extra vergoeding hoeft te betalen.
	
	Dit gaat per direct in en heeft geen einddatum. Verder kan deze deal uiteraard op verborgen worden gezet.
	Ik heb het leadprogramma aangemaakt. Het lead ID is 4834.
	
December 22 2010, Jan, ticket: #6479
Added affilate Imbull (11033) and Actiepag (3571) to the deal.
*/
	
UPDATE
	lead
SET
	lead_program_id = 4834
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 4714 and id != 4834) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (22443, 11033, 3571);
	
