/* November 16 2010, Dineke, #6305
 * Special deal advertisements 683276 and 683277 (used by affiliate zinngeld (5575)).
 * Put all leads to lead_program_id 4991.
 */
UPDATE
	lead
SET
	lead_program_id = 4991
FROM
	click
WHERE
	click.id = click_id AND
	lead.affiliate_id = 5575 AND
	advertisement_id IN (683276, 683277) AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	merchant_id = 18552 AND
	lead_program_id != 4991;
