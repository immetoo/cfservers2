UPDATE
	click
SET
	status = 'REJECTED'
FROM
	click_reward,
	click_reward_duration,	
		(SELECT 
			ip_address, 
			affiliate_id
 		FROM
 			dalton_status
		WHERE 
			status = 'REJECTED' AND 
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		) as dalton_status
WHERE
	click.status IN ('ON_HOLD', 'ACCEPTED') AND
	click.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click.ip_address = dalton_status.ip_address AND 
	click.affiliate_id = dalton_status.affiliate_id AND
	click.advertisement_id = click_reward.advertisement_id AND
	click_reward.id = click_reward_duration.click_reward_id AND
	click_reward_duration.start_date <= click.created AND 
	click_reward_duration.end_date > click.created;

