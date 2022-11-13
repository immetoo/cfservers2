/* July 6 2010, Jan, ticket: #5485
Zou jij voor het programma van Scapino (id 20873) affiliate 37cadeau (id 8131) alle sales in lp 4602 kunnen laten vallen?
Kun je dit per vandaag in laten gaan?
Thanks!
*/
UPDATE
	lead
SET
	lead_program_id = 4602
WHERE
	lead_program_id IN (4525, 4526, 4527) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (8131) AND
	created >= '2010-07-06';

/* June 30 2010, Jan, ticket: #5435
Zou jij alle sales van Scapino (id 20873) die binnenkomen via affiliate fgielen (id 6305) standaard op lp 4527 binnen laten komen?
Update July 30th 2010, Jan, Added affiliate actiepag ID 3571 
*/
UPDATE
	lead
SET
	lead_program_id = 4527
WHERE
	lead_program_id IN (4525, 4526) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (3571, 6305);

/* June 18 2010, Jan, ticket: #5364
Zou jij de volgende staffel in kunnen zetten voor adverteerder Scapino (id 20873)

lp 4525: bij 1-5 sales
lp 4526: bij 6-15 sales
lp 4527: bij 15+ sales

Alles op bruto sales alsjeblieft.
*/

/* lp 4526: bij 6-15 sales */
UPDATE
	lead
SET
	lead_program_id = 4526
WHERE
	lead_program_id IN (4525) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4525, 4526, 4527) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) BETWEEN 6 AND 15
	);
	
/* lp 4527: bij 15+ sales */
UPDATE
	lead
SET
	lead_program_id = 4527
WHERE
	lead_program_id IN (4525, 4526) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4525, 4526, 4527) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) > 15
	);