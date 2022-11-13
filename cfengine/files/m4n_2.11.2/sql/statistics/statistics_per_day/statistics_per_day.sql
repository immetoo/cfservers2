DROP TABLE IF EXISTS statistics_per_day_rows_to_insert;

CREATE TABLE statistics_per_day_rows_to_insert AS SELECT
    nextval('statistics_per_day_id_seq'::regclass)                                                 AS id,
    COALESCE (views_affiliate_website_id, clicks_affiliate_website_id, leads_affiliate_website_id) AS affiliate_website_id,
    COALESCE(views_zone_id, clicks_zone_id, leads_zone_id)                                         AS zone_id,
    COALESCE(views_advertisement_id, clicks_advertisement_id, leads_advertisement_id)              AS advertisement_id,
    COALESCE(views_status, clicks_status, leads_status)                                            AS status,
    day,
    date_part('week', to_date(day||'-'||month||'-'||year, 'DD-MM-YYYY'))::INTEGER                  AS week,
    month,
    year,
    1                                                                                              AS total,
    COALESCE(SUM(total_views), 0)                                                                  AS total_views,
    COALESCE(SUM(total_clicks), 0)                                                                 AS total_clicks,
    COALESCE(SUM(total_leads), 0)                                                                  AS total_leads,
    COALESCE(SUM(leads_total_price), 0)                                                            AS total_price,
    COALESCE(SUM(payed_views), 0)                                                                  AS payed_views,
    COALESCE(SUM(payed_clicks), 0)                                                                 AS payed_clicks,
    COALESCE(SUM(payed_leads), 0)                                                                  AS payed_leads,
    COALESCE(SUM(views_cost), 0)                                                                   AS views_cost,
    COALESCE(SUM(click_cost), 0)                                                                   AS click_cost,
    COALESCE(SUM(lead_cost), 0)                                                                    AS lead_cost,
    COALESCE(SUM(views_reward), 0)                                                                 AS views_reward,
    COALESCE(SUM(click_reward), 0)                                                                 AS click_reward,
    COALESCE(SUM(lead_reward), 0)                                                                  AS lead_reward,
    views_clicks_leads_count.affiliate_id                                                          AS affiliate_id,
    views_clicks_leads_count.merchant_id                                                           AS merchant_id,
    MAX(affiliateinfo.accountmanagerid)                                                            AS affiliate_account_manager_user_id,
    MAX(invoice_settings.account_manager_user_id)                                                  AS merchant_account_manager_user_id,
    MAX(invoice_settings.media_agency_user_id)                                                     AS merchant_media_agency_user_id,
    COALESCE(views_payment_period_id, clicks_payment_period_id, leads_payment_period_id)           AS payment_period_id,
    now()                                                                                          AS created,
    now()                                                                                          AS last_modified 
FROM
	
    /* calculate bare table with all clicks, leads and views */
    /* SUBQUERY views_clicks_leads_count */ (
        SELECT 
            *,
            COALESCE (views_affiliate_id, clicks_affiliate_id , leads_affiliate_id) AS affiliate_id,
            COALESCE (views_merchant_id, clicks_merchant_id, leads_merchant_id)     AS merchant_id,
            COALESCE (views_day, clicks_day, leads_day)                             AS day,
            COALESCE (views_month, clicks_month, leads_month)                       AS month,
            COALESCE (views_year, clicks_year, leads_year)                          AS year
        FROM
            statistics_per_day_click_data
                FULL OUTER JOIN
            statistics_per_day_lead_data ON (
            /* join conditions for click and lead tables */
                statistics_per_day_click_data.clicks_merchant_id          = statistics_per_day_lead_data.leads_merchant_id AND 
                statistics_per_day_click_data.clicks_affiliate_id         = statistics_per_day_lead_data.leads_affiliate_id AND 
                statistics_per_day_click_data.clicks_payment_period_id    = statistics_per_day_lead_data.leads_payment_period_id AND 
                statistics_per_day_click_data.clicks_day                  = statistics_per_day_lead_data.leads_day AND 
                statistics_per_day_click_data.clicks_month                = statistics_per_day_lead_data.leads_month AND 
                statistics_per_day_click_data.clicks_year                 = statistics_per_day_lead_data.leads_year AND 
                statistics_per_day_click_data.clicks_advertisement_id     = statistics_per_day_lead_data.leads_advertisement_id AND 
                statistics_per_day_click_data.clicks_zone_id              = statistics_per_day_lead_data.leads_zone_id AND 
                statistics_per_day_click_data.clicks_affiliate_website_id = statistics_per_day_lead_data.leads_affiliate_website_id AND
                statistics_per_day_click_data.clicks_status               = statistics_per_day_lead_data.leads_status
            )
                FULL OUTER JOIN		
            statistics_per_day_views_data ON (
            /* Join conditions for view table with the click and lead table */
                statistics_per_day_views_data.views_merchant_id          = COALESCE(statistics_per_day_click_data.clicks_merchant_id, statistics_per_day_lead_data.leads_merchant_id) AND 
                statistics_per_day_views_data.views_affiliate_id         = COALESCE(statistics_per_day_click_data.clicks_affiliate_id, statistics_per_day_lead_data.leads_affiliate_id)  AND 
                statistics_per_day_views_data.views_payment_period_id    = COALESCE(statistics_per_day_click_data.clicks_payment_period_id, statistics_per_day_lead_data.leads_payment_period_id) AND 
                statistics_per_day_views_data.views_day                  = COALESCE(statistics_per_day_click_data.clicks_day, statistics_per_day_lead_data.leads_day) AND 
                statistics_per_day_views_data.views_month                = COALESCE(statistics_per_day_click_data.clicks_month, statistics_per_day_lead_data.leads_month) AND 
                statistics_per_day_views_data.views_year                 = COALESCE(statistics_per_day_click_data.clicks_year, statistics_per_day_lead_data.leads_year) AND 
                statistics_per_day_views_data.views_advertisement_id     = COALESCE(statistics_per_day_click_data.clicks_advertisement_id, statistics_per_day_lead_data.leads_advertisement_id) AND 
                statistics_per_day_views_data.views_zone_id              = COALESCE(statistics_per_day_click_data.clicks_zone_id, statistics_per_day_lead_data.leads_zone_id) AND 
                statistics_per_day_views_data.views_affiliate_website_id = COALESCE(statistics_per_day_click_data.clicks_affiliate_website_id, statistics_per_day_lead_data.leads_affiliate_website_id) AND
                statistics_per_day_views_data.views_status               = COALESCE(statistics_per_day_click_data.clicks_status, statistics_per_day_lead_data.leads_status)
			)
	) AS views_clicks_leads_count
		LEFT OUTER JOIN 
	affiliateinfo ON (affiliateinfo.affiliate_id = views_clicks_leads_count.affiliate_id)
    	LEFT OUTER JOIN 
    invoice_settings ON (invoice_settings.user_id = views_clicks_leads_count.merchant_id)
GROUP BY
	views_clicks_leads_count.merchant_id,
	views_clicks_leads_count.affiliate_id,
	payment_period_id,
	day,
	month,
	year,
	advertisement_id,
	zone_id,
	affiliate_website_id,
	status;
	
VACUUM ANALYZE statistics_per_day_rows_to_insert;

BEGIN;

DELETE FROM
    statistics_per_day
USING
    statistics_per_day_rows_to_delete
WHERE
    statistics_per_day.id = statistics_per_day_rows_to_delete.id;
		
INSERT INTO 
    statistics_per_day
SELECT 
    *
FROM
    statistics_per_day_rows_to_insert;

COMMIT;

DROP TABLE rows_to_be_updated_day;
DROP TABLE statistics_per_day_click_data;
DROP TABLE statistics_per_day_lead_data;
DROP TABLE statistics_per_day_rows_to_delete;
DROP TABLE statistics_per_day_rows_to_insert;
DROP TABLE statistics_per_day_views_data;

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
				job_group = 'statistics'
			GROUP BY
				id,
				started
				ORDER BY started DESC
		) AS last_run 
		LIMIT 1
	);