-- This file is dependent on statistics_per_day.
-- YOU CAN NOT use this file to convert a given statistics_per_day table, to statistics_per_month
-- Always run statistics_per_day prior to running this.
INSERT INTO registered_system_jobs (
	trigger_name, 
	job_name, 
	job_group, 
	message, 
	runtime, 
	started
) 
VALUES (
	'per_month_query',
	'per_month',
	'statistics',
	'It really doesnt matter as this table has only explicit semantics',
	0,
	now()
);

BEGIN;

DELETE FROM 
	statistics_per_month 
WHERE 
    id IN (
        SELECT
            id
        FROM
            statistics_per_month, 
            rows_to_be_updated_month
        WHERE
            statistics_per_month.zone_id = rows_to_be_updated_month.zone_id AND
            statistics_per_month.affiliate_id = rows_to_be_updated_month.affiliate_id AND
            statistics_per_month.month = rows_to_be_updated_month.month AND
            statistics_per_month.year = rows_to_be_updated_month.year AND
            statistics_per_month.payment_period_id = rows_to_be_updated_month.payment_period_id
        );
	
INSERT INTO statistics_per_month (
    affiliate_website_id,
    zone_id,
    advertisement_id,
    status,
    day,
    week,
    month,
    year,
    total,
    total_views,
    total_clicks,
    total_leads,
    total_price,
    payed_views,
    payed_clicks,
    payed_leads,
    views_cost,
    click_cost,
    lead_cost,
    views_reward,
    click_reward,
    lead_reward,
    affiliate_id,
    merchant_id,
    affiliate_account_manager_user_id,
    merchant_account_manager_user_id,
    merchant_media_agency_user_id,
    payment_period_id
)
SELECT
	affiliate_website_id,
	statistics_per_day.zone_id,
	statistics_per_day.advertisement_id,
	statistics_per_day.status,
	NULL AS day,
	NULL AS week,
    statistics_per_day.month,
    statistics_per_day.year,
    1 AS total,
    SUM(total_views),
    SUM(total_clicks),
    SUM(total_leads),
    SUM(total_price),
 	SUM(payed_views),
	SUM(payed_clicks),
	SUM(payed_leads),
	SUM(views_cost),
	SUM(click_cost),
	SUM(lead_cost),
	SUM(views_reward),
	SUM(click_reward),
	SUM(lead_reward),
	statistics_per_day.affiliate_id,
	merchant_id,
	affiliate_account_manager_user_id,
	merchant_account_manager_user_id,
	merchant_media_agency_user_id,
	statistics_per_day.payment_period_id
FROM
	statistics_per_day, 
	rows_to_be_updated_month
WHERE
    statistics_per_day.zone_id = rows_to_be_updated_month.zone_id AND
    statistics_per_day.affiliate_id = rows_to_be_updated_month.affiliate_id AND
    statistics_per_day.month = rows_to_be_updated_month.month AND
    statistics_per_day.year = rows_to_be_updated_month.year AND
    statistics_per_day.payment_period_id = rows_to_be_updated_month.payment_period_id
GROUP BY
	affiliate_website_id,
	statistics_per_day.zone_id, 
	statistics_per_day.advertisement_id,
	statistics_per_day.status,
	statistics_per_day.month, 
	statistics_per_day.year,
	statistics_per_day.affiliate_id,
	merchant_id,
	affiliate_account_manager_user_id,
	merchant_account_manager_user_id, 
	merchant_media_agency_user_id,
	statistics_per_day.payment_period_id;

COMMIT;

DROP TABLE rows_to_be_updated_month;

UPDATE 
	registered_system_jobs 
SET 
	finished = now() 
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
				job_name = 'per_month' AND 
				job_group = 'statistics' 
			GROUP BY 
				id,
				started
			ORDER BY started DESC
		) AS last_run
		LIMIT 1
	);
