/* April 26 2010, Jan, ticket: #4889
Aanvrager: Jesse le Grand
Hierbij een aanvraag voor een special deal.

Het is voor 2 affiliates:

- actiepag 3571
- Imbull 11033

- Its 16168
alle leads moeten van 3511 naar 4328 voor beide affiliates
*/
UPDATE
	lead
SET
	lead_program_id = 4328
WHERE
	lead_program_id = 3511 AND
	affiliate_id IN (3571, 11033) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
/* May 19 2010, Dineke, Ticket #5114
Requested by Paul Vogelenzang

Van 17 mei tm 30 juni wil itsonline.nl(id: 16168) een extra click vergoeding verschaffen. 10 cent per click, icm conversie ondergrens van 0,2%

Put the click reward on bonus program 4416
Daarbij in zit nog wel een staffeltje:
·    maximale vergoeding van 2.500 clicks van 0 tm 5 orders
·    maximale vergoeding van 5.000 clicks bij 6 tm 10 orders
·    maximale vergoeding van 7.500 clicks bij 11 tm 15 orders
·    etc
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
	 4416 AS lead_program_id,
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
	now() BETWEEN '2010-05-17' AND '2010-07-02' AND
	click.created BETWEEN' 2010-05-17' AND '2010-07-02' AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	advertisement_id IN 
		(SELECT 
	    	id 
		FROM 
			advertisement 
		WHERE 
			merchant_id = 16168 AND 
			id NOT IN (SELECT advertisement_id FROM advertisement_affiliate)) AND
	NOT EXISTS (
		SELECT
			affiliate_id
		FROM
			lead AS bonus_leads
		WHERE
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			bonus_leads.lead_program_id = 4416 AND
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
		rewarded_clicks * 0.10 as price,
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
				created BETWEEN '2010-05-17' AND '2010-07-01' AND
				advertisement_id IN 
					(SELECT 
				    	id 
					FROM 
						advertisement 
					WHERE 
						merchant_id = 16168 AND 
						id NOT IN (SELECT advertisement_id FROM advertisement_affiliate)
					)
			GROUP BY affiliate_id
			) AS click_counts
		LEFT OUTER JOIN 
			(SELECT affiliate_id, leads, quotum
			FROM 
				(SELECT 
					COUNT(*) AS leads, 
					2500 * (((COUNT(*) - 1) / 5 ) + 1 ) AS quotum,
					affiliate_id
				FROM lead
				WHERE lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 16168 AND id != 4416) AND
					status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
					payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
					created BETWEEN '2010-05-17' AND '2010-07-01'
				GROUP BY affiliate_id
				) AS sums
			) AS quotums
		USING(affiliate_id)
		) as total
	) as bonuses
WHERE
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 4416 AND
	lead.affiliate_id = bonuses.affiliate_id AND
	now() BETWEEN '2010-05-17' AND '2010-07-02';
	
COMMIT;