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
	'recalculate_lead_rewards',
	'',
	0,
	now()
);

UPDATE 
	lead 
SET 
	cost = lead_rewards.cost, 
	reward = lead_rewards.reward,
	recalculate_cost_reward = false
FROM 
	(
		SELECT
			lead.id AS lead_id,
			CASE 
				WHEN lead_reward_percentage.id IS NOT NULL THEN 
					lead_reward_percentage.cost_fraction * COALESCE(price, 0)
				WHEN lead_reward_fixed.id IS NOT NULL THEN
					lead_reward_fixed.cost
				ELSE
					0
			END AS cost, 
			CASE 
				WHEN lead_reward_percentage.id IS NOT NULL THEN 
					lead_reward_percentage.reward_fraction * COALESCE(price, 0)
				WHEN lead_reward_fixed.id IS NOT NULL THEN
					lead_reward_fixed.reward
				ELSE
					0
			END AS reward
		FROM
						lead
				LEFT JOIN
			(
				SELECT
					lead_reward.*,
					start_date,
					end_date
				FROM
					lead_reward,
					lead_reward_duration
				WHERE
					lead_reward.id = lead_reward_duration.lead_reward_id AND
					lead_reward.reward_group_id IS NULL
			) AS lead_reward ON (
				lead.lead_program_id = lead_reward.lead_program_id AND
				lead.click_created >= lead_reward.start_date AND
				lead.click_created < lead_reward.end_date
			)
				LEFT JOIN
			(
				SELECT
					lead_reward.*,
					lead_reward_duration.start_date,
					lead_reward_duration.end_date,
					reward_group_member.start_date AS membership_start_date,
					reward_group_member.end_date AS membership_end_date,
					affiliate_id
				FROM
					lead_reward
						JOIN
					lead_reward_duration ON (lead_reward.id = lead_reward_duration.lead_reward_id) 
						JOIN
					reward_group ON (lead_reward.reward_group_id = reward_group.id)
						JOIN
					reward_group_member ON (reward_group.id = reward_group_member.reward_group_id)
						JOIN
					reward_group_member_affiliate ON (reward_group_member.id = reward_group_member_affiliate.id)
			) AS lead_reward_deal ON (
				lead.lead_program_id = lead_reward_deal.lead_program_id AND
				lead.click_created >= lead_reward_deal.start_date AND
				lead.click_created < lead_reward_deal.end_date AND
				lead.click_created >= lead_reward_deal.membership_start_date AND
				lead.click_created < lead_reward_deal.membership_end_date AND
				lead.affiliate_id = lead_reward_deal.affiliate_id
			)
				LEFT JOIN
			lead_reward_multi_tier ON (
				(lead_reward_deal.id IS NULL AND lead_reward.id = lead_reward_multi_tier.id) OR
				lead_reward_deal.id = lead_reward_multi_tier.id
			)
				LEFT JOIN
			lead_reward_tier ON (lead_reward_multi_tier.id = lead_reward_tier.lead_reward_multi_tier_id)
				LEFT JOIN
			lead_reward_percentage ON (
				(lead_reward_deal.id IS NULL AND lead_reward.id = lead_reward_percentage.id) OR 
				lead_reward_deal.id = lead_reward_percentage.id OR
				lead_reward_tier.lead_reward_id = lead_reward_percentage.id
			)
				LEFT JOIN
			lead_reward_fixed ON (
				(lead_reward_deal.id IS NULL AND lead_reward.id = lead_reward_fixed.id) OR 
				lead_reward_deal.id = lead_reward_fixed.id OR
				lead_reward_tier.lead_reward_id = lead_reward_fixed.id
			)
		WHERE
			(
				(
					lead_reward_multi_tier.id IS NOT NULL AND
					lead_reward_tier.id = (
						SELECT
							id
						FROM
							lead_reward_tier
						WHERE
							lead_reward_multi_tier_id = lead_reward_multi_tier.id AND
														(
								(
									ignore_lead_status AND
									min_number_of_leads <= (
										SELECT
											COUNT(*)
										FROM
											lead AS lead_count
										WHERE
											lead_count.lead_program_id = lead.lead_program_id AND
											lead_count.affiliate_id = lead.affiliate_id AND
											EXTRACT(month FROM lead_count.created) = EXTRACT(month FROM lead.created) AND
											EXTRACT(year FROM lead_count.created) = EXTRACT(year FROM lead.created) AND
											status IN ('ACCEPTED', 'REJECTED', 'TO_BE_APPROVED', 'ON_HOLD')
									)
								) OR
								(
									NOT ignore_lead_status AND
									status = 'ACCEPTED' AND
									min_number_of_leads <=
									(
										SELECT 
											COUNT(*) 
										FROM 
											lead AS lead_count
										WHERE 
											lead_count.lead_program_id = lead.lead_program_id AND 
											lead_count.affiliate_id = lead.affiliate_id AND
											lead_count.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
											status = 'ACCEPTED' 
									)
								) OR
								min_number_of_leads = 1 --The default reward if the affiliate does not have any approved leads yet
							)
						ORDER BY
							min_number_of_leads DESC
						LIMIT 1
					)
				) OR
				lead_reward_multi_tier.id IS NULL
			) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			(lead.recalculate_cost_reward = true OR lead_reward_multi_tier.id IS NOT NULL)
	) AS lead_rewards
WHERE
	lead.id = lead_rewards.lead_id AND
	(lead.cost != lead_rewards.cost OR
	lead.reward != lead_rewards.reward OR
	lead.recalculate_cost_reward = true);
	
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
				job_group = 'recalculate_lead_rewards'
			GROUP BY
				id,
				started
				ORDER BY started DESC
		) AS last_run 
		LIMIT 1
	);
