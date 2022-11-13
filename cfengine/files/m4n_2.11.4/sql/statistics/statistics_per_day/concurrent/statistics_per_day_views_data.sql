DROP TABLE IF EXISTS statistics_per_day_views_data;

/*
 * Explicit query planner hints to force index scans. After optimization on
 * several database dumps the settings seem to create the fastest execution 
 * plan. 
 */
SET random_page_cost=0.005;

CREATE TABLE statistics_per_day_views_data AS SELECT 
    SUM(COALESCE(COALESCE(view_reward_deal.reward, view_reward.reward), 0) * (view.number_of_views/1000))   AS views_reward,
    SUM(COALESCE(COALESCE(view_reward_deal.cost, view_reward.cost), 0) * (view.number_of_views/1000))       AS views_cost,
    CASE WHEN view_reward.id IS NOT NULL THEN 
        SUM(view.number_of_views) 
    ELSE 
        0 
    END                                                     AS payed_views,
    SUM(view.number_of_views)                               AS total_views,
    advertisement.merchant_id                               AS views_merchant_id,
    view.affiliate_id                                       AS views_affiliate_id,
    zone.website_id                                         AS views_affiliate_website_id,
    view.payment_period_id                                  AS views_payment_period_id,
    EXTRACT(DAY FROM view.created)                          AS views_day,
    EXTRACT(MONTH FROM view.created)                        AS views_month,
    EXTRACT(YEAR FROM view.created)                         AS views_year,
    view.advertisement_id                                   AS views_advertisement_id,
    view.zone_id                                            AS views_zone_id,
    view.status                                             AS views_status
FROM 
    ( 
        SELECT 
            *
        FROM
            view
        WHERE 
            payment_period_id IN (SELECT distinct(payment_period_id) FROM rows_to_be_updated_day)
    ) AS view
        JOIN
    advertisement ON (advertisement.id = view.advertisement_id)
        JOIN
    zone ON (view.zone_id = zone.id)
        JOIN
    rows_to_be_updated_day ON
    (
        view.affiliate_id = rows_to_be_updated_day.affiliate_id	AND
        view.zone_id = rows_to_be_updated_day.zone_id AND
        view.created::date = rows_to_be_updated_day.date_to_be_updated AND
        view.payment_period_id = rows_to_be_updated_day.payment_period_id
    )
        LEFT JOIN
    (
        SELECT
            view_reward.id,
            view_reward.reward,
            view_reward.cost,
            view_reward.advertisement_id,
            view_reward_duration.start_date,
            view_reward_duration.end_date
        FROM
            view_reward 
                JOIN
            view_reward_duration ON (view_reward.id = view_reward_duration.view_reward_id)
        WHERE
        	view_reward.reward_group_id IS NULL
    ) AS view_reward ON (
        view_reward.advertisement_id = view.advertisement_id AND
        view_reward.start_date <= view.created AND 
        view_reward.end_date > view.created
    )
    	LEFT JOIN
    (
    	SELECT
            view_reward.id,
            view_reward.reward,
            view_reward.cost,
            view_reward.advertisement_id,
            view_reward_duration.start_date,
            view_reward_duration.end_date,
            reward_group_member.start_date AS membership_start_date,
            reward_group_member.end_date AS membership_end_date,
            affiliate_id
        FROM
            view_reward 
                JOIN
            view_reward_duration ON (view_reward.id = view_reward_duration.view_reward_id)
				JOIN
			reward_group_member USING (reward_group_id)
				JOIN
			reward_group_member_affiliate ON (reward_group_member.id = reward_group_member_affiliate.id)
    ) AS view_reward_deal ON (
    	view_reward_deal.advertisement_id = view.advertisement_id AND
        view_reward_deal.start_date <= view.created AND 
        view_reward_deal.end_date > view.created AND
        view_reward_deal.membership_start_date <= view.created AND 
        view_reward_deal.membership_end_date > view.created AND
        view_reward_deal.affiliate_id = view.affiliate_id
    )
GROUP BY 
    advertisement.merchant_id,
    view.affiliate_id,
    view.payment_period_id, 
    EXTRACT(DAY FROM view.created),
    EXTRACT(MONTH FROM view.created),
    EXTRACT(YEAR FROM view.created),
    view.advertisement_id,
    view.zone_id,
    zone.website_id,
    view.status,
    view_reward.id;