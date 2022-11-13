INSERT INTO lead (
	click_id, 
	lead_program_id, 
	description1, 
	description2, 
	description3, 
	status, 
	created, 
	referrer, 
	user_agent, 
	ip_address, 
	price, 
	affiliate_id,
	click_created, 
	payment_period_id
)
SELECT 
	max_click_id,						--click_id
	1121,								--lead_program_id of bonus
	now(),								--date in description1
	(leads/5 - bonus_leads) * 15.38,	-- bonus amount in description2
	(leads/5 - bonus_leads) || ' * bonus',--description3
	'ACCEPTED',							--status
	now() - interval '7 hour',			--date
	'automatic lead',					--referrer
	'inserted by m4n',					--user_agent
	'127.0.0.1',						--ip address
	(leads/5 - bonus_leads) * 15.38,	--price
	affiliate_id,						--affiliate id
	max_click_time,						--time of click
 	(SELECT max(id) FROM payment_period)--payment_period_id
FROM (
	SELECT 
		affiliate_id,
		max_click_id,
		max_click_time,
		leads,
		CASE WHEN bonus_leads IS null
			THEN 0 
			ELSE bonus_leads
		END AS bonus_leads
	FROM (
		SELECT 
			COUNT(lead.id) AS leads,
			click.affiliate_id,
			MAX(click_id) AS max_click_id,
			MAX(click.created) AS max_click_time
		FROM 
			lead, 
			click
		WHERE 
			click.id = lead.click_id AND
			lead.status = 'ACCEPTED' AND
			lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 3214 AND id != 1121)
		GROUP BY 
			click.affiliate_id
	) AS tot_leads
	FULL OUTER JOIN (
		SELECT 
			COUNT(lead.id) AS bonus_leads,
			click.affiliate_id 
		FROM 
			lead, 
			click
		WHERE 
			click.id = lead.click_id AND
			lead.status = 'ACCEPTED' AND
			lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
			lead_program_id  = 1121
		GROUP BY 
			click.affiliate_id
	) AS tot_bonus_leads
	USING (affiliate_id)
) AS tot 
WHERE 
	leads/5 - bonus_leads >= 1;
