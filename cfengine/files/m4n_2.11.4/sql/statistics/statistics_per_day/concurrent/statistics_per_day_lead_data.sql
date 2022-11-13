DROP TABLE IF EXISTS statistics_per_day_lead_data;

/*
 * Explicit query planner hints to force index scans and fixed order of join 
 * execution. After optimization on several database dumps the settings seem
 * to create the fastest execution plan. 
 */
SET join_collapse_limit=1;
SET random_page_cost=0.005;

CREATE TABLE statistics_per_day_lead_data AS SELECT 
    SUM(lead.cost)                   AS lead_cost,
    SUM(lead.reward)                 AS lead_reward,
    SUM(price)                       AS leads_total_price,
    lead_program.merchant_id         AS leads_merchant_id,
    lead.affiliate_id                AS leads_affiliate_id,
    lead.payment_period_id           AS leads_payment_period_id,
    COUNT(lead_reward.id)            AS payed_leads,
    COUNT(lead.id)                   AS total_leads,
    EXTRACT(DAY FROM lead.created)   AS leads_day,
    EXTRACT(MONTH FROM lead.created) AS leads_month,
    EXTRACT(YEAR FROM lead.created)  AS leads_year,
    click.advertisement_id           AS leads_advertisement_id,
    click.zone_id                    AS leads_zone_id,
    zone.website_id                  AS leads_affiliate_website_id,
    lead.status                      AS leads_status
FROM
    (
        SELECT 
            *
        FROM
            lead
        WHERE 
            payment_period_id IN (SELECT distinct(payment_period_id) FROM rows_to_be_updated_day)
    ) AS lead
        JOIN
    lead_program ON (lead.lead_program_id = lead_program.id)
        JOIN
    click ON (click.id = lead.click_id)
        JOIN
    zone ON (click.zone_id = zone.id)
        JOIN
    rows_to_be_updated_day ON
    (
        click.zone_id = rows_to_be_updated_day.zone_id AND
        lead.affiliate_id = rows_to_be_updated_day.affiliate_id AND
        lead.created::date = rows_to_be_updated_day.date_to_be_updated AND
        lead.payment_period_id = rows_to_be_updated_day.payment_period_id
    )
        LEFT JOIN
    (
        SELECT
            lead_reward.id,
            lead_program_id,
            start_date,
            end_date
        FROM
            lead_reward
                JOIN
            lead_reward_duration ON (lead_reward.id = lead_reward_duration.lead_reward_id)
    ) AS lead_reward ON (
        lead_reward.lead_program_id = lead.lead_program_id AND
        lead_reward.start_date <= lead.click_created AND 
        lead_reward.end_date > lead.click_created
    )
GROUP BY 
    lead_program.merchant_id,
    lead.affiliate_id,
    lead.payment_period_id,
    EXTRACT(DAY FROM lead.created),
    EXTRACT(MONTH FROM lead.created), 
    EXTRACT(YEAR FROM lead.created),
    click.advertisement_id,
    click.zone_id,
    zone.website_id,
    lead.status;