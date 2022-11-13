INSERT INTO registered_system_jobs (
	trigger_name, 
	job_name, 
	job_group, 
	message, 
	runtime, 
	started
) 
VALUES (
	'per_day_query',
	'per_day',
	'recalculate_click_rewards',
	'',
	0,
	now()
);

UPDATE 
	click 
SET 
	cost = click_rewards.cost, 
	reward = click_rewards.reward,
	recalculate_cost_reward = false
FROM 
	(
		SELECT
			click.id AS click_id,
			COALESCE(click_reward_deal.cost, click_reward.cost, 0) AS cost, 
			COALESCE(click_reward_deal.reward, click_reward.reward, 0) AS reward
		FROM
						click
				LEFT JOIN
			(
				SELECT
					click_reward.id,
					click_reward.advertisement_id,
					click_reward.cost,
					click_reward.reward,
					click_reward_duration.start_date,
					click_reward_duration.end_date
				FROM
					click_reward
						JOIN
					click_reward_duration ON (click_reward_duration.click_reward_id = click_reward.id)
				WHERE
					click_reward.reward_group_id IS NULL
			) AS click_reward ON (
				click.advertisement_id = click_reward.advertisement_id AND
				click.created >= click_reward.start_date AND
				click.created < click_reward.end_date
			)
				LEFT JOIN
			(
				SELECT
					click_reward.id,
					click_reward.advertisement_id,
					click_reward.cost,
					click_reward.reward,
					click_reward_duration.start_date,
					click_reward_duration.end_date,
					reward_group_member.start_date AS membership_start_date,
					reward_group_member.end_date AS membership_end_date,
					affiliate_id
				FROM
					click_reward
						JOIN
					click_reward_duration ON (click_reward_duration.click_reward_id = click_reward.id)
						JOIN
					reward_group_member USING (reward_group_id)
						JOIN
					reward_group_member_affiliate ON (reward_group_member.id = reward_group_member_affiliate.id)
			) AS click_reward_deal ON (
				click.advertisement_id = click_reward_deal.advertisement_id AND
				click.created >= click_reward_deal.start_date AND
				click.created < click_reward_deal.end_date AND
				click.created >= click_reward_deal.membership_start_date AND
				click.created < click_reward_deal.membership_end_date AND
				click_reward_deal.affiliate_id = click.affiliate_id
			)
		WHERE
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click.recalculate_cost_reward = true
	) AS click_rewards
WHERE
	click.id = click_rewards.click_id;
	
UPDATE
	registered_system_jobs
SET 
	finished=now()
WHERE
	id IN (
		SELECT
			id
		FROM (
			SELECT
				id,
				MAX(started)
			FROM
				registered_system_jobs
			WHERE
				job_name = 'per_day' AND
				job_group = 'recalculate_click_rewards'
			GROUP BY
				id,
				started
				ORDER BY started DESC
		) AS last_run 
		LIMIT 1
	);
