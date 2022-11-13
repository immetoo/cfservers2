-- insert all views that where missed during raw date copy, index/constraints creation and vacuum
CREATE RULE prevent_duplicate_view_id AS ON INSERT TO view_new WHERE EXISTS (SELECT id FROM view_new WHERE id = NEW.id) DO INSTEAD NOTHING;

INSERT INTO view_new (
    SELECT
        * 
    FROM 
        view 
    WHERE 
        created >= (SELECT MAX(created) FROM view_new)
);

BEGIN;
    
    -- swap tables and rename sequences
    ALTER TABLE view RENAME TO view_old;
    ALTER SEQUENCE view_id_seq RENAME TO view_old_id_seq;
    ALTER TABLE view_new RENAME TO view;
    ALTER SEQUENCE view_new_id_seq RENAME TO view_id_seq;
    
    -- insert all views that where missed before the start of this transaction
    INSERT INTO view (
        SELECT
            * 
        FROM
            view_old 
        WHERE 
            created >= (SELECT MAX(created) FROM view)
    );
    
    -- synchronize sequence
    SELECT setval('view_id_seq', (SELECT max(id)+1 FROM view_old));
    
    -- drop rule for duplicates should raise SQL EXCEPTIONS
    DROP RULE prevent_duplicate_view_id ON view;
    
COMMIT;