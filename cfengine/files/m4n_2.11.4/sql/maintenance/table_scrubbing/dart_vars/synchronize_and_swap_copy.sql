-- insert all dart_vars that where missed during raw date copy, index/constraints creation and vacuum
CREATE RULE prevent_duplicate_dart_vars_id AS ON INSERT TO dart_vars_new WHERE EXISTS (SELECT id FROM dart_vars_new WHERE id = NEW.id) DO INSTEAD NOTHING;

INSERT INTO dart_vars_new (
    SELECT
        * 
    FROM 
        dart_vars 
    WHERE 
        id >= (SELECT MAX(id) FROM dart_vars_new)
);

BEGIN;
    
    -- swap tables and rename sequences
    ALTER TABLE dart_vars RENAME TO dart_vars_old;
    ALTER SEQUENCE dart_vars_id_seq RENAME TO dart_vars_old_id_seq;
    ALTER TABLE dart_vars_new RENAME TO dart_vars;
    ALTER SEQUENCE dart_vars_new_id_seq RENAME TO dart_vars_id_seq;
    
    -- insert all dart_vars that where missed before the start of this transaction
    INSERT INTO dart_vars (
        SELECT
            * 
        FROM
            dart_vars_old 
        WHERE 
            id >= (SELECT MAX(id) FROM dart_vars)
    );
    
    -- synchronize sequence
    SELECT setval('dart_vars_id_seq', (SELECT max(id)+1 FROM dart_vars_old));
    
    -- drop rule for duplicates should raise SQL EXCEPTIONS
    DROP RULE prevent_duplicate_dart_vars_id ON dart_vars;
    
COMMIT;