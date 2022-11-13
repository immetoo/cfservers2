/* May 12 2010, Jan, ticket #5062

Ik zou graag de staffel van Sneltoner alsvolgt instellen:

Alle sales laten binnenkomen op lp 4314 als:
Description 2 > 0.00

Alle sales laten binnenkomen op lp 4315 als:
Description 3 > 0.00 en Description 2 = 0.00

Volgens mij heb ik zo alles afgevangen toch? :-)

Thank you!
*/

UPDATE
	lead
SET
	lead_program_id = 4315
WHERE
	lead_program_id = 4314 AND
	description2 = '0.00' AND
	description3 != '0.00' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);