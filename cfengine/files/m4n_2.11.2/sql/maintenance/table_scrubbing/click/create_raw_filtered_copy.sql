/*
 * Helper tables to speed up click queries.
 */

DROP TABLE IF EXISTS temp_lead_created_date;
CREATE TABLE temp_lead_created_date AS (
    SELECT DISTINCT
        lead.created::date
    FROM
        lead
    WHERE
        lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
);

DROP TABLE IF EXISTS temp_lead_click_id;
CREATE TABLE temp_lead_click_id AS (
    SELECT DISTINCT
        lead.click_id
    FROM
        lead
    WHERE
        lead.created::date IN (SELECT created FROM temp_lead_created_date)
);

/*
 * Retrieve all click id's that should be kept, based on the current payment period,
 * expiration or being referenced by leads subject for recalculation.
 */

DROP TABLE IF EXISTS temp_click_id_to_keep;
CREATE TABLE temp_click_id_to_keep AS (
    SELECT
       id
    FROM
        click
    WHERE
        click.expires > now() OR
        created > (now() - interval '100 DAYS') OR
        created::date IN (SELECT created FROM temp_lead_created_date) OR
        id IN (SELECT click_id FROM temp_lead_click_id) OR
        payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
);

ALTER TABLE temp_click_id_to_keep ADD CONSTRAINT temp_click_id_to_keep_pkey PRIMARY KEY(id);

-- replicate click_new from click table and copy the clicks
DROP TABLE IF EXISTS click_new;
CREATE TABLE click_new (
    id                      BIGINT NOT NULL, 
    advertisement_id        BIGINT NOT NULL, 
    affiliate_id            BIGINT NOT NULL, 
    created                 TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
    expires                 TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    http_client_id          uuid, 
    ip_address              inet,
    last_modified           TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
    merchant_id             BIGINT,
    payment_period_id       INTEGER NOT NULL,
    referrer                TEXT,
    status                  approval_status NOT NULL DEFAULT 'ON_HOLD'::approval_status,
    user_agent              VARCHAR(256),
    zone_id                 BIGINT,
    cost                    NUMERIC NOT NULL DEFAULT 0,
    reward                  NUMERIC NOT NULL DEFAULT 0,
    recalculate_cost_reward BOOLEAN DEFAULT false
);
COMMENT ON TABLE click_new IS 'Stores information belonging to clicks.';
COMMENT ON COLUMN click_new.id IS 'Unique click id, generated remotely by individual Satellite nodes.';
COMMENT ON COLUMN click_new.advertisement_id IS 'ID of the advertisement on/for which the click was made.';
COMMENT ON COLUMN click_new.affiliate_id IS 'ID of the affiliate (owner of the website) on whos zone the click was made. Denormalized for performance reasons (can also be found by looking at the associated zone).';
COMMENT ON COLUMN click_new.created IS 'Point in time the click was created.';
COMMENT ON COLUMN click_new.expires IS 'Point in time a cookie expires in the http_client cache and will not be send along with subsequent http requests. Note: expires is calculated using advertising_settings.cookie_time_in_seconds at click time';
COMMENT ON COLUMN click_new.http_client_id IS 'semi-unique ID of the http client, used for tracking purposes.';
COMMENT ON COLUMN click_new.ip_address IS 'IP address of the client who is making the click. Can of course be a proxy.';
COMMENT ON COLUMN click_new.last_modified IS 'Point in time the click was modified, note that this field may be set implicit by trigger click_last_modified.';
COMMENT ON COLUMN click_new.merchant_id IS 'The owner of the advertisement on which the click was made. Denormalized for performance reasons (can also be found by looking at the associated advertisement).';
COMMENT ON COLUMN click_new.payment_period_id IS 'Payment period id where click will be booked for.';
COMMENT ON COLUMN click_new.referrer IS 'The client (HTTP) referrer. This is normally the URL of the website where the click was made.';
COMMENT ON COLUMN click_new.status IS 'Status for click as determined by business rules. Meta information about a click, e.g. whether it is rejected etc.';
COMMENT ON COLUMN click_new.user_agent IS 'Identification of the agent (browser) the user used to make the click.';
COMMENT ON COLUMN click_new.zone_id IS 'ID of the zone that contains the advertisement on which the click was made.';
COMMENT ON COLUMN click_new.cost IS 'The amount of money that this click will cost the merchant.';
COMMENT ON COLUMN click_new.reward IS 'The amount of money that the affiliate will receive for this click.';
COMMENT ON COLUMN click_new.recalculate_cost_reward IS 'Indicates if the cost and reward of the click need to be recalculated';
CREATE TRIGGER last_modified BEFORE UPDATE ON click_new FOR EACH ROW EXECUTE PROCEDURE last_modified();
CREATE TRIGGER click_recalculation BEFORE UPDATE ON click_new FOR EACH ROW EXECUTE PROCEDURE click_recalculation();
ALTER TABLE click_new OWNER TO mbuyu;

INSERT INTO click_new (
    SELECT
        *
    FROM
        click
    WHERE
        id IN (SELECT id FROM temp_click_id_to_keep)
);

DROP TABLE IF EXISTS temp_lead_created_date;
DROP TABLE IF EXISTS temp_lead_click_id;
DROP TABLE IF EXISTS temp_click_id_to_keep;

-- rename indices for click so the naming schema can be reused
ALTER INDEX click_pkey                  RENAME TO click_old_pkey;
ALTER INDEX click_advertisement_id_idx  RENAME TO click_old_advertisement_id_idx;
ALTER INDEX click_affiliate_id_idx      RENAME TO click_old_affiliate_id_idx;
ALTER INDEX click_created_idx           RENAME TO click_old_created_idx;
ALTER INDEX click_ip_address_idx        RENAME TO click_old_ip_address_idx;
ALTER INDEX click_last_modified_idx     RENAME TO click_old_last_modified_idx;
ALTER INDEX click_merchant_id_idx       RENAME TO click_old_merchant_id_idx;
ALTER INDEX click_payment_period_id_idx RENAME TO click_old_payment_period_id_idx;
ALTER INDEX click_status_idx            RENAME TO click_old_status_idx;
ALTER INDEX click_zone_id_idx           RENAME TO click_old_zone_id_idx;

-- drop constraint on click table so the naming schema can be reused. See also: http://old.nabble.com/pg_dump-restore-time-and-Foreign-Keys-td17662993.html#a17669744
ALTER TABLE click
    DROP CONSTRAINT click_advertisement_id_fkey,
    DROP CONSTRAINT click_affiliate_id_fkey,
    DROP CONSTRAINT click_merchant_id_fkey,
    DROP CONSTRAINT click_payment_period_id_fkey,
    DROP CONSTRAINT click_zone_id_fkey;