/* May 19 2010, Dineke, Ticket #5113:
 * Reported by Patrick Emmen
 * Er dient voor MTV Mobile 18166 een staffel geïmplementeerd te worden. Met terugwerkende kracht per 1 mei.

Leadprogramma 3893 0 – 10 sales = 20 euro
Leadprogramma 4414 11 – 20 sales = 25 euro
Leadprogramma 4415 21 sales en meer = 30 euro

Alle clicks die voor 19 mei gezet zijn dienen wel nog de oude vergoeding van 30 euro te krijgen. Alle clicks vanaf 19 mei komen in de staffel.
*/
--Leadprogramma 4414 11 – 20 sales = 25 euro
UPDATE
	lead
SET
	lead_program_id = 4414
WHERE
	lead_program_id = 3893 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created > '2010-05-19' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (	SELECT
							affiliate_id
						FROM 
							lead
						WHERE
							status = 'ACCEPTED' AND
							lead_program_id IN (3893, 4414, 4415) AND 		  
							click_created < '2011-01-01' AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
						GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 20
	);

--Leadprogramma 4415 21 sales en meer = 30 euro
UPDATE
	lead
SET
	lead_program_id = 4415
WHERE
	lead_program_id IN (4414, 3893) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created > '2010-05-19' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (	SELECT
							affiliate_id
						FROM 
							lead
						WHERE
							status = 'ACCEPTED' AND
							lead_program_id IN (3893, 4414, 4415) AND 	
							click_created < '2011-01-01' AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
						GROUP BY affiliate_id HAVING COUNT(id) > 20
	);

/* #4662 Match 1 2010, Dineke
 * Reported by Patrick Emmen:

MTVmobile id: 18166 wordt vandaag gelanceerd en zij geven een clickvergoeding.

Hierbij het overzicht:

MTV Mobile vergoedt 2 euro cent per click.                                                                                                    
·                     maximale vergoeding van 1.000 clicks van 0 tm 5 orders
·                     maximale vergoeding van 2.000 clicks bij 6 tm 10 orders
·                     maximale vergoeding van 3.000 clicks bij 11 tm 15 orders
·                     maximale vergoeding van 4.000 clicks bij 16 tm 20 orders
·                     maximale vergoeding van 5.000 clicks bij 21 tm 25 orders
·                     maximale vergoeding van 6.000 clicks bij 26 tm 30 orders
·                     maximale vergoeding van 7.000 clicks bij 31 tm 35 orders
·                     maximale vergoeding van 8.000 clicks bij 36 tm 40 orders of  meer                                

Actie tot en met eind april 2010
We use the lead program 4031 to put the click-reward on
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
	 4031 AS lead_program_id,
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
	now() < '2010-05-01' AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	advertisement_id IN 
		(SELECT 
	    	id 
		FROM 
			advertisement 
		WHERE 
			merchant_id = 18166 AND 
			id NOT IN (SELECT advertisement_id FROM advertisement_affiliate)) AND
	NOT EXISTS (
		SELECT
			affiliate_id
		FROM
			lead AS bonus_leads
		WHERE
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			bonus_leads.lead_program_id = 4031 AND
			click.affiliate_id = bonus_leads.affiliate_id
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
		'bonus voor ' || COALESCE(leads, 0) || ' leads en ' || COALESCE(rewarded_clicks, 0) || ' clicks (' || COALESCE(clicks, 0) || ' clicks totaal)' AS description2,
		rewarded_clicks * 0.02 as price,
		(SELECT MAX(id) FROM payment_period) AS payment_period_id
	FROM
		(SELECT 
			affiliate_id,
			leads,
			clicks,
			CASE
				WHEN (clicks < 1000 OR clicks < quotum) THEN clicks
				WHEN clicks >= COALESCE(quotum, 1000) THEN COALESCE(quotum, 1000) 
			END AS rewarded_clicks
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
						merchant_id = 18166 AND 
						id NOT IN (SELECT advertisement_id FROM advertisement_affiliate)
					)
			GROUP BY affiliate_id
			) AS click_counts
		LEFT OUTER JOIN 
			(SELECT affiliate_id, leads,
				CASE WHEN quotum > 8000 THEN 8000 ELSE quotum END
			FROM 
				(SELECT 
					COUNT(*) AS leads, 
					1000 * (((COUNT(*) - 1) / 5 ) + 1 ) AS quotum,
					affiliate_id
				FROM lead
				WHERE lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 18166 AND id != 4031) AND
					status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
					payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
					created BETWEEN '2010-03-01' AND '2010-05-01'
				GROUP BY affiliate_id
				) AS sums
			) AS quotums
		USING(affiliate_id)
		) as total
	) as bonuses
WHERE
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 4031 AND
	lead.affiliate_id = bonuses.affiliate_id AND
	now() < '2010-05-02';
	
COMMIT;