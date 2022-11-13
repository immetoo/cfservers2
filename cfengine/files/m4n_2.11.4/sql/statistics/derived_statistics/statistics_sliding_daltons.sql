DROP TABLE IF EXISTS statistics_sliding_daltons_per_ip_affiliate_temp;

CREATE TABLE statistics_sliding_daltons_per_ip_affiliate_temp (
    id              BIGSERIAL NOT NULL PRIMARY KEY,
    ip_address      inet NOT NULL,
    affiliate_id    BIGINT NOT NULL REFERENCES m4nuser(id) ON UPDATE CASCADE ON DELETE CASCADE,
    status          approval_status NOT NULL CHECK (status IN ('ACCEPTED', 'ON_HOLD')),
    merchants_total BIGINT NOT NULL,
    clicks_total    BIGINT NOT NULL,
    reward_total    NUMERIC NOT NULL,
    UNIQUE (ip_address, affiliate_id, status)
);

INSERT INTO statistics_sliding_daltons_per_ip_affiliate_temp (
    ip_address, 
    affiliate_id, 
    status,
    merchants_total, 
    clicks_total, 
    reward_total
)
SELECT 
    daltons.ip_address              AS ip_address, 
    daltons.affiliate_id            AS affiliate_id,
    daltons.status                  AS status, 
    COUNT(daltons.merchant_id)      AS merchants_total, 
    SUM(daltons.clicks_total)       AS clicks_total, 
    SUM(daltons.total_money_earned)	AS rewards_total
FROM (
    SELECT 
        click.ip_address          AS ip_address, 
        click.affiliate_id        AS affiliate_id,
        click.status              AS status, 
        advertisement.merchant_id AS merchant_id, 
        COUNT(click.id)           AS clicks_total, 
        SUM(click.reward)         AS total_money_earned
    FROM 
        advertisement, 
        click_reward
            JOIN
        click_reward_duration ON (click_reward.id = click_reward_duration.click_reward_id),
        click
	WHERE 
        click.advertisement_id = advertisement.id AND 
        click.advertisement_id = click_reward.advertisement_id AND 
        click_reward_duration.start_date <= click.created AND 
        click_reward_duration.end_date > click.created AND
        click.status IN ('ON_HOLD', 'ACCEPTED') AND
        click.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
	GROUP BY 
        ip_address, 
        affiliate_id, 
        advertisement.merchant_id, 
        click.status
	HAVING 
        COUNT(click.id) > 5
	) AS daltons
GROUP BY 
    daltons.ip_address, 
    daltons.affiliate_id,
    daltons.status;

BEGIN;
    DROP TABLE statistics_sliding_daltons_per_ip_affiliate;
    ALTER TABLE statistics_sliding_daltons_per_ip_affiliate_temp RENAME TO statistics_sliding_daltons_per_ip_affiliate;
COMMIT;

VACUUM ANALYZE statistics_sliding_daltons_per_ip_affiliate;

DROP TABLE IF EXISTS statistics_sliding_daltons_per_ip_temp;

CREATE TABLE statistics_sliding_daltons_per_ip_temp
(
    ip_address       inet NOT NULL PRIMARY KEY,
    affiliates_total BIGINT NOT NULL,
    clicks_total     BIGINT NOT NULL
);

INSERT INTO statistics_sliding_daltons_per_ip_temp (
    ip_address, 
    affiliates_total,
    clicks_total
)
SELECT 
    click.ip_address,
    count(distinct(click.affiliate_id)) AS affiliates_total,
    count(distinct(click.id)) AS clicks_total
FROM
    click,
    statistics_sliding_daltons_per_ip_affiliate
WHERE
    click.ip_address = statistics_sliding_daltons_per_ip_affiliate.ip_address AND
    click.status = 'ACCEPTED' AND
    click.created >= current_date - 30
GROUP BY
    click.ip_address;

BEGIN;
    DROP TABLE statistics_sliding_daltons_per_ip;
    ALTER TABLE statistics_sliding_daltons_per_ip_temp RENAME TO statistics_sliding_daltons_per_ip;
COMMIT;