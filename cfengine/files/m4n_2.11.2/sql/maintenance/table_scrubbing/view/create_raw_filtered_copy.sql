/* 
 * Helper tables to speed up view queries. 
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

DROP TABLE IF EXISTS temp_click_created_date;
CREATE TABLE temp_click_created_date AS (
    SELECT DISTINCT
        click.created::date  
    FROM 
        click
    WHERE
        click.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
);

/*
 * Retrieve all view id's that should be kept, based on the current payment period, 
 * expiration or being referenced by click or leads subject for recalculation. 
 */

DROP TABLE IF EXISTS temp_view_id_to_keep; 
CREATE TABLE temp_view_id_to_keep AS (
    SELECT
       id
    FROM 
        view     
    WHERE 
        created > (now() - interval '100 DAYS') OR  
        created::date IN (SELECT created FROM temp_lead_created_date) OR
        created::date IN (SELECT created FROM temp_click_created_date) OR
        payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
); 

ALTER TABLE temp_view_id_to_keep ADD CONSTRAINT temp_view_id_to_keep_pkey PRIMARY KEY(id);

-- replicate view_new from view table and copy the useful views
DROP TABLE IF EXISTS view_new;
CREATE TABLE view_new (
    id                BIGSERIAL NOT NULL,
    advertisement_id  BIGINT NOT NULL,
    affiliate_id      BIGINT NOT NULL,
    created           TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
    last_modified     TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT now(),
    number_of_views   INTEGER NOT NULL,
    payment_period_id BIGINT NOT NULL,
    status            approval_status NOT NULL DEFAULT 'ACCEPTED'::approval_status,
    zone_id           BIGINT NOT NULL,
    cost              NUMERIC NOT NULL DEFAULT 0,
    reward            NUMERIC NOT NULL DEFAULT 0
);

CREATE TRIGGER last_modified BEFORE UPDATE ON view_new FOR EACH ROW EXECUTE PROCEDURE last_modified();
ALTER TABLE view_new OWNER TO mbuyu;

INSERT INTO view_new (
    SELECT
        *
    FROM 
        view  	
    WHERE 
        id IN (SELECT id FROM temp_view_id_to_keep)
); 

DROP TABLE IF EXISTS temp_lead_created_date;
DROP TABLE IF EXISTS temp_click_created_date;
DROP TABLE IF EXISTS temp_view_id_to_keep; 

-- rename indices for view so the naming schema can be reused
ALTER INDEX view_pkey                  RENAME TO view_old_pkey;
ALTER INDEX view_advertisement_id_idx  RENAME TO view_old_advertisement_id_idx;
ALTER INDEX view_created_idx           RENAME TO view_old_created_idx;
ALTER INDEX view_last_modified_idx     RENAME TO view_old_last_modified_idx;
ALTER INDEX view_payment_period_id_idx RENAME TO view_old_payment_period_id_idx;
ALTER INDEX view_status_idx            RENAME TO view_old_status_idx;
ALTER INDEX view_zone_id_idx           RENAME TO view_old_zone_id_idx;

-- drop constraint on view table so the naming schema can be reused. See also: http://old.nabble.com/pg_dump-restore-time-and-Foreign-Keys-td17662993.html#a17669744
ALTER TABLE view
    DROP CONSTRAINT view_affiliate_id_fkey,
    DROP CONSTRAINT view_payment_period_id_fkey;