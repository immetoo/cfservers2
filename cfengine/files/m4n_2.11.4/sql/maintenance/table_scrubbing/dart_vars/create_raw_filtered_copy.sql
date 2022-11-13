/*
 * Retrieve all transid's that should be kept, being referenced by either lead.click_id or click.id
 */

DROP TABLE IF EXISTS temp_transid_to_keep;
CREATE TABLE temp_transid_to_keep AS 

    SELECT
        click.id      AS transid
    FROM 
        click
               
UNION

    SELECT DISTINCT
        lead.click_id AS transid
    FROM 
        lead;
        
ALTER TABLE temp_transid_to_keep ADD CONSTRAINT temp_transid_to_keep_pkey PRIMARY KEY(transid);

-- replicate dart_vars_new from dart_vars table and copy the useful dart_vars
DROP TABLE IF EXISTS dart_vars_new;
CREATE TABLE dart_vars_new (
    id               BIGSERIAL NOT NULL,
    transid          BIGINT,
    site_id          BIGINT,
    key_name         VARCHAR(2048),
    zone             BIGINT,
    advertizer       VARCHAR(255),
    order_number     BIGINT,
    ad_id            BIGINT,
    creative_id_dfa  BIGINT,
    creative_id_dfp  BIGINT,
    user_id          BIGINT,
    advertizer_id    BIGINT,
    users_banners_id INTEGER,
    m4n_user_id      INTEGER
);
ALTER TABLE dart_vars_new OWNER TO mbuyu;

INSERT INTO dart_vars_new (
    SELECT
        *
    FROM 
        dart_vars
    WHERE 
        transid IN (SELECT transid FROM temp_transid_to_keep)
); 

DROP TABLE IF EXISTS temp_transid_to_keep;

-- rename indices for dart_vars so the naming schema can be reused
ALTER INDEX dart_vars_pkey         RENAME TO dart_vars_old_pkey;
ALTER INDEX dart_vars_click_id_idx RENAME TO dart_vars_old_click_id_idx;
ALTER INDEX dart_vars_user_id_idx  RENAME TO dart_vars_old_user_id_idx;