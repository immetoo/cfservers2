/* September 13 2010, Jan, ticket: #5895
Kunnen jullie onderstaande staffel hanteren voor spreadshirt id:22108

< 10 orders per maand = leadprogramma 4795
> 10 orders per maand = leadprogramma 4796
> 20 orders per maand = leadprogramma 4797
> 30 orders per maand = leadprogramma 4798

Deze staffels kunnen zsm worden ingevoerd.
*/

/* > 10 orders per maand = 22,5% commissie = leadprogramma 4796 */

UPDATE	
	lead 
SET 
	lead_program_id = 4796
WHERE 
	lead_program_id IN (4795) AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT 
			affiliate_id 
		FROM 
			lead 
		WHERE 
			lead_program_id IN (4795, 4796, 4797, 4798) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 10 AND 
			COUNT(id) < 20
	);
	
/* > 20 orders per maand = 25% commissie = leadprogramma 4797 */
UPDATE	
	lead 
SET 
	lead_program_id = 4797
WHERE 
	lead_program_id IN (4795, 4796) AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT 
			affiliate_id 
		FROM 
			lead 
		WHERE 
			lead_program_id IN (4795, 4796, 4797, 4798) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 20 AND 
			COUNT(id) < 100
	);
	
/* > 100 orders per maand = 27,5% commissie = leadprogramma 4798 */
UPDATE	
	lead 
SET 
	lead_program_id = 4798
WHERE 
	lead_program_id IN (4795, 4796, 4797) AND
	status = 'ACCEPTED' AND 
	click_created < '2011-01-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (
		SELECT 
			affiliate_id 
		FROM 
			lead 
		WHERE 
			lead_program_id IN (4795, 4796, 4797, 4798) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 30
	);
	
/* October 26 2010, Jan, ticket: #6137
CPC reward for Spreadshirt, only awarded after 30+ sales have been approved.
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
	 4899 AS lead_program_id,
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
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	advertisement_id IN 
		(SELECT 
	    	id 
		FROM 
			advertisement 
		WHERE 
			merchant_id = 22108 AND 
			id NOT IN (SELECT advertisement_id FROM advertisement_affiliate)) AND
	NOT EXISTS (
		SELECT
			affiliate_id
		FROM
			lead AS bonus_leads
		WHERE
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			bonus_leads.lead_program_id = 4899 AND
			click.affiliate_id = bonus_leads.affiliate_id
	) AND
	affiliate_id IN (
		SELECT 
			affiliate_id 
		FROM 
			lead 
		WHERE 
			lead_program_id IN (4795, 4796, 4797, 4798) AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 30
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
		clicks * 0.02 as price,
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
					merchant_id = 22108 AND 
					id NOT IN (SELECT advertisement_id FROM advertisement_affiliate)
				)
		GROUP BY
			affiliate_id
		) as total
	) as bonuses
WHERE
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 4899 AND
	lead.affiliate_id = bonuses.affiliate_id;
	
COMMIT;