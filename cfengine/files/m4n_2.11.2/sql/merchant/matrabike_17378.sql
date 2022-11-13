/* October 13th 2010, Jan, ticket: #6035
Kunnen de volgende affiliates Wielmaas (6892) en mrcmssn (22000) standaard in leadprogramma (4441) bij Matrabike (17378) komen.

Ingangsdatum 12 oktober. 
*/
UPDATE
	lead
SET
	lead_program_id = 4441
WHERE
	lead_program_id IN (3734, 4440) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (6892, 22000) AND
	created >= '2010-10-12';
/* May 26 2010, Jan, ticket: #5172
Graag zou ik een staffel voor Matrabike (17378) willen aanvragen.

1 t/m 4 sales -> 3734
5 t/m 9 sales -> 4440
    10+ sales -> 4441
    
Staffel gaat vanaf 26 mei in.
*/

/* 5 t/m 9 sales -> 4440 */
UPDATE
	lead
SET
	lead_program_id = 4440
WHERE
	lead_program_id = 3734 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	created >= '2010-05-26' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3734, 4440, 4441) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			click_created < '2011-01-01' AND
			created >= '2010-05-26'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) BETWEEN 5 AND 9
	);

/*     10+ sales -> 4441 */
UPDATE
	lead
SET
	lead_program_id = 4441
WHERE
	lead_program_id IN (3734, 4440) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	created >= '2010-05-26' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3734, 4440, 4441) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			click_created < '2011-01-01' AND
			created >= '2010-05-26'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10
	);


/* June 22 2010, Jan, ticket: #5396
Zou je de volgende (klik) staffel bij Matrabike (17378) erin kunnen zetten?

Instap: €0,00 CPC en 8% CPS (0 sales)
Brons: €0,03 CPC en 8% CPS (1-4 sales)
Zilver: €0,03 CPC en 9% CPS (5-9 sales)
Goud: €0,03 CPC en 10% CPS (meer dan 10 sales)

Er wordt dus geen cpc uitgekeerd, wanneer iemand geen sales heeft gedaan. 
*/
BEGIN;

INSERT INTO lead (
	click_id, 
	lead_program_id, 
	description1,
	price, 
	status,  
	referrer, 
	ip_address, 
	user_agent, 
	payment_period_id, 
	affiliate_id, 
	click_created,
	created
)

SELECT
	MAX(id) AS click_id,
	 4443 AS lead_program_id,
	 'Nieuwe bonuslead' AS description1,
	 0 AS price,
	 'ACCEPTED'::approval_status AS status,
	 'automatic lead'::text AS referrer,
	 '127.0.0.1'::inet AS ip_address,
	 'inserted by m4n'::text AS user_agent,
	 (SELECT MAX(id) FROM payment_period WHERE processed = false) AS payment_period_id,
	 affiliate_id AS affiliate_id,
	 MAX(created) AS click_created,
	 now() - interval '7 hours' 
FROM
	click
WHERE
	created >= '2010-07-01' AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	advertisement_id IN 
		(SELECT 
	    	id 
		FROM 
			advertisement 
		WHERE 
			merchant_id = 17378 AND 
			id NOT IN (SELECT advertisement_id FROM advertisement_affiliate)) AND
	NOT EXISTS (
		SELECT
			affiliate_id
		FROM
			lead AS bonus_leads
		WHERE
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			bonus_leads.lead_program_id = 4443 AND
			click.affiliate_id = bonus_leads.affiliate_id
	) AND
	EXISTS (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 17378) AND
			click.affiliate_id = affiliate_id AND
			status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
			created >= '2010-07-01'
	)
GROUP BY
	affiliate_id;
	
UPDATE
	lead
SET
	description1		= bonuses.description1,
	description2		= bonuses.description2,
	price				= bonuses.price,
	payment_period_id	= bonuses.payment_period_id
FROM
	(SELECT
		affiliate_id,
		'bonus laatst uitgerekend ' || now()::date AS description1,
		'bonus voor ' || COALESCE(clicks, 0) || ' clicks' AS description2,
		clicks * 0.03 as price,
		(SELECT MAX(id) FROM payment_period) AS payment_period_id
	FROM
		(SELECT 
			COUNT(*) AS clicks, 
			affiliate_id 
		FROM 
			click
		WHERE 
			status = 'ACCEPTED' AND 
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			advertisement_id IN 
				(SELECT 
			    	id 
				FROM 
					advertisement 
				WHERE 
					merchant_id = 17378 AND 
					id NOT IN (SELECT advertisement_id FROM advertisement_affiliate)
				) AND
			created >= '2010-07-01'
		GROUP BY
			affiliate_id
		) as total
	) as bonuses
WHERE
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 4443 AND
	lead.affiliate_id = bonuses.affiliate_id;
	
COMMIT;

