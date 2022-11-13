-- This file is dependent on statistics_per_day.
-- YOU CAN NOT use this file to convert a given statistics_per_day table, to statistics_per_week
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
	'per_week_query',
	'per_week',
	'statistics',
	'It really doesnt matter as this table has only explicit semantics',
	0,
	now()
);

BEGIN;

DELETE FROM 
	statistics_per_week 
WHERE 
    id IN (
        SELECT
            id
        FROM
            statistics_per_week, 
            rows_to_be_updated_week
        WHERE
            statistics_per_week.zone_id = rows_to_be_updated_week.zone_id AND
            statistics_per_week.affiliate_id = rows_to_be_updated_week.affiliate_id AND
            statistics_per_week.week = rows_to_be_updated_week.week AND
            statistics_per_week.month = date_part('month', to_date(rows_to_be_updated_week.week||'-'||CASE 
				WHEN (rows_to_be_updated_week.week = 1 AND rows_to_be_updated_week.month = 12) THEN rows_to_be_updated_week.year + 1
				WHEN (rows_to_be_updated_week.week >= 52 AND rows_to_be_updated_week.month = 1) THEN rows_to_be_updated_week.year - 1
				ELSE rows_to_be_updated_week.year
			END, 'WW-YYYY'))::INTEGER AND
			statistics_per_week.year = CASE
				WHEN (rows_to_be_updated_week.week = 1 AND rows_to_be_updated_week.month = 12) THEN rows_to_be_updated_week.year + 1
				WHEN (rows_to_be_updated_week.week >= 52 AND rows_to_be_updated_week.month = 1) THEN rows_to_be_updated_week.year - 1
				ELSE rows_to_be_updated_week.year
			END AND
            statistics_per_week.payment_period_id = rows_to_be_updated_week.payment_period_id
        );

INSERT INTO statistics_per_week (
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
	NULL::INTEGER AS day,
	statistics_per_day.week,
	date_part('month', to_date(statistics_per_day.week||'-'||CASE 
		WHEN (statistics_per_day.week = 1 AND statistics_per_day.month = 12) THEN statistics_per_day.year + 1
		WHEN (statistics_per_day.week >= 52 AND statistics_per_day.month = 1) THEN statistics_per_day.year - 1
		ELSE statistics_per_day.year
	END, 'WW-YYYY'))::INTEGER AS _month,
	CASE
		WHEN (statistics_per_day.week = 1 AND statistics_per_day.month = 12) THEN statistics_per_day.year + 1
		WHEN (statistics_per_day.week >= 52 AND statistics_per_day.month = 1) THEN statistics_per_day.year - 1
		ELSE statistics_per_day.year
	END AS _year,
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
	rows_to_be_updated_week
WHERE
    statistics_per_day.zone_id = rows_to_be_updated_week.zone_id AND
    statistics_per_day.affiliate_id = rows_to_be_updated_week.affiliate_id AND
    statistics_per_day.week = rows_to_be_updated_week.week AND
    statistics_per_day.month = rows_to_be_updated_week.month AND
    statistics_per_day.year = rows_to_be_updated_week.year AND
    statistics_per_day.payment_period_id = rows_to_be_updated_week.payment_period_id
GROUP BY
	affiliate_website_id,
	statistics_per_day.zone_id, 
	statistics_per_day.advertisement_id,
	statistics_per_day.status,
	statistics_per_day.week, 
	_month, 
	_year,
	statistics_per_day.affiliate_id,
	statistics_per_day.merchant_id,
	affiliate_account_manager_user_id,
	merchant_account_manager_user_id, 
	merchant_media_agency_user_id,
	statistics_per_day.payment_period_id;
	
COMMIT;

DROP TABLE rows_to_be_updated_week;

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
				job_name = 'per_week' AND 
				job_group = 'statistics' 
			GROUP BY 
				id,
				started
			ORDER BY started DESC
		) AS last_run
		LIMIT 1
	);
