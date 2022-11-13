/* October 28 2010, Dineke, #6149
 * Requested by Michiel:
 * Zou je alle clicks kunnen afkeuren van affiliate 18736 voor adverteerder 10197, van 1 oktober tot eh.. ergens eind november? Deze affiliate misbruikt een hoge CPC vergoeding.
 */
UPDATE
	click
SET
	status = 'REJECTED'
WHERE
	affiliate_id = 18736 AND
	merchant_id = 10197 AND
	created BETWEEN '2010-10-01' AND '2010-12-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED';
	