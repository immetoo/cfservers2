/* December 10 2010, Jan, ticket: #6429
Score (19413) heeft vanaf 1 december tot en 24 december voor elke affiliate een verhoogde vergoeding van 11%. Dit is staffel 4122. 

Daarna komt elke affiliate weer in de gebruikelijke staffel.
*/
UPDATE
	lead
SET
	lead_program_id = 4122
WHERE
	lead_program_id IN (4108, 4121) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-12-01' AND
	created < '2010-12-25';
	
/* June 23 2010, Jan, ticket: #5400
Kun jij alle sales voor de Score (id 19413) die binnenkomen via
- Welovesites (id 9070)
- Ilse media (id 430)

op lp 4537 zetten?

Kun je dit per 19 juni (dus met terugwerkende kracht) instellen?
*/

UPDATE
	lead
SET
	lead_program_id = 4537
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 19413) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (430, 9070) AND
	created >= '2010-06-19';

/* August 3 2010, Jan, ticket: #5636
Vandaag weer een special deal voor affiliate 37cadeau (id 8131) voor de adverteerder Score (19413):
Standaard lp: 4674
11-25 orders: lp 4675
26-40 orders: lp 4676
>40 orders: lp 4677

Alles op brutosales please! 
Kun je dit vanaf vandaag instellen?

Update September 8 2010, Jan, ticket: #5879
Changed staffel amounts per 7-9-2010
*/

/* Standaard lp: 4674 */
UPDATE
	lead
SET
	lead_program_id = 4674
WHERE
	lead_program_id IN (4108, 4121, 4122, 4123) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 8131 AND
	created >= '2010-08-03';
	
/* 11-25 orders: lp 4675 */
UPDATE
	lead
SET
	lead_program_id = 4675
WHERE
	lead_program_id IN (4674) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created < '2010-09-07' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4674, 4675, 4676, 4677) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) BETWEEN 11 AND 25
	);
	
/* 26-40 orders: lp 4676 */	
UPDATE
	lead
SET
	lead_program_id = 4676
WHERE
	lead_program_id IN (4674, 4675) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created < '2010-09-07' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4674, 4675, 4676, 4677) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) BETWEEN 26 AND 40
	);
	
/* >40 orders: lp 4677 */	
UPDATE
	lead
SET
	lead_program_id = 4677
WHERE
	lead_program_id IN (4674, 4675, 4676) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created < '2010-09-07' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4674, 4675, 4676, 4677) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) > 40
	);

/* 11-15 orders: lp 4675 */
UPDATE
	lead
SET
	lead_program_id = 4675
WHERE
	lead_program_id IN (4674) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-09-07' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4674, 4675, 4676, 4677) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) BETWEEN 11 AND 15
	);
	
/* 16+ orders: lp 4676 */	
UPDATE
	lead
SET
	lead_program_id = 4676
WHERE
	lead_program_id IN (4674, 4675) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-09-07' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4674, 4675, 4676, 4677) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) >= 16
	);
	
/* March 30 2010, Jan, ticket: #4771
Zou jij de volgende staffel van Score in het systeem kunnen zetten:
lp 4108: 1-10 orders per maand
lp 4121: 11 - 25 orders per maand
lp 4122: 26 - 40 orders per maand
lp 4123: 40+ orders per maand

Alles op bruto orders, dus dat betekent dat orders die op status 0 en 1 staan ook meegeteld moeten worden in de staffel.
Wanneer een affiliate bijvoorbeeld in staffel 2 valt en een sale wordt afgekeurd waardoor hij eigenlijk in staffel 1 zou moeten vallen, mag hij toch in staffel 2 blijven vallen.

Dus ongeacht de status, 0, 1, 2 en 3 moet samen tot de bepaalde staffel komen.

Update September 8 2010, Jan, ticket: #5879
Changed staffel amounts per 7-9-2010
*/

/* lp 4121: 11 - 25 orders per maand */
UPDATE
	lead
SET
	lead_program_id = 4121
WHERE
	lead_program_id IN (4108) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created < '2010-09-07' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4108, 4121, 4122, 4123) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) BETWEEN 11 AND 25
	);
	
/* lp 4122: 26 - 40 orders per maand */	
UPDATE
	lead
SET
	lead_program_id = 4122
WHERE
	lead_program_id IN (4108, 4121) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created < '2010-09-07' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4108, 4121, 4122, 4123) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) BETWEEN 26 AND 40
	);
	
/* lp 4123: 40+ orders per maand */	
UPDATE
	lead
SET
	lead_program_id = 4123
WHERE
	lead_program_id IN (4108, 4121, 4122) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created < '2010-09-07' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4108, 4121, 4122, 4123) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) > 40
	);
	
/* lp 4121: 11 - 15 orders per maand */
UPDATE
	lead
SET
	lead_program_id = 4121
WHERE
	lead_program_id IN (4108) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-09-07' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4108, 4121, 4122, 4123) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) BETWEEN 11 AND 15
	);
	
/* lp 4122: 16+ orders per maand */	
UPDATE
	lead
SET
	lead_program_id = 4122
WHERE
	lead_program_id IN (4108, 4121) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-09-07' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4108, 4121, 4122, 4123) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD')
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) >= 16
	);