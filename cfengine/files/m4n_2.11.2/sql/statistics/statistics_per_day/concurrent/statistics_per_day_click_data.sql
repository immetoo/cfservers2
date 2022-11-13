DROP TABLE IF EXISTS statistics_per_day_click_data;

/*
 * Explicit query planner hints to force index scans and fixed order of join 
 * execution. After optimization on several database dumps the settings seem
 * to create the fastest execution plan. 
 */
SET join_collapse_limit=1;
SET random_page_cost=0.005;

CREATE TABLE statistics_per_day_click_data AS SELECT 
    SUM(click.reward)                 AS click_reward,
    SUM(click.cost)                   AS click_cost,
    click.merchant_id                 AS clicks_merchant_id,
    click.affiliate_id                AS clicks_affiliate_id ,
    click.payment_period_id           AS clicks_payment_period_id,
    COUNT(click.id)                   AS total_clicks,
    COUNT(click.id)                   AS payed_clicks,
    EXTRACT(DAY FROM click.created)   AS clicks_day,
    EXTRACT(MONTH FROM click.created) AS clicks_month,
    EXTRACT(YEAR FROM click.created)  AS clicks_year,
    click.advertisement_id            AS clicks_advertisement_id,
    click.zone_id                     AS clicks_zone_id,
    zone.website_id                   AS clicks_affiliate_website_id,
    click.status                      AS clicks_status
FROM
    (
        SELECT 
            *
        FROM 
            click
        WHERE 
            payment_period_id IN (SELECT distinct(payment_period_id) FROM rows_to_be_updated_day)
     ) AS click
        JOIN
    zone ON (click.zone_id = zone.id)
        JOIN
    rows_to_be_updated_day ON (
        click.affiliate_id = rows_to_be_updated_day.affiliate_id AND
        click.zone_id = rows_to_be_updated_day.zone_id AND
        click.created::date = rows_to_be_updated_day.date_to_be_updated AND
        click.payment_period_id = rows_to_be_updated_day.payment_period_id
    )  
        LEFT JOIN
    (
        SELECT
            click_reward.id,
            click_reward.advertisement_id,
            click_reward_duration.start_date,
            click_reward_duration.end_date
        FROM
            click_reward 
                JOIN
            click_reward_duration ON (click_reward.id = click_reward_duration.click_reward_id)
    ) AS click_reward ON (
        click_reward.advertisement_id = click.advertisement_id AND
        click_reward.start_date <= click.created AND 
        click_reward.end_date > click.created
    )
GROUP BY 
    click.merchant_id,
    click.affiliate_id,
    click.payment_period_id,
    EXTRACT(DAY FROM click.created),
    EXTRACT(MONTH FROM click.created),
    EXTRACT(YEAR FROM click.created), 
    click.advertisement_id,
    click.zone_id,
    zone.website_id,
    click.status;	