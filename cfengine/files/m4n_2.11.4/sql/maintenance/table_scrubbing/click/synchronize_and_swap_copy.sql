

-- insert all clicks that where missed during raw date copy, index/constraints creation and vacuum
CREATE RULE prevent_duplicate_click_id AS ON INSERT TO click_new WHERE EXISTS (SELECT id FROM click_new WHERE id = NEW.id) DO INSTEAD NOTHING;

INSERT INTO click_new (
    SELECT
        * 
    FROM 
        click 
    WHERE 
        created >= (SELECT MAX(created) FROM click_new)
);

BEGIN;
    
    ALTER TABLE click RENAME TO click_old;
    ALTER TABLE click_new RENAME TO click;
      
    -- insert all clicks that where missed before the start of this transaction
    INSERT INTO click (
        SELECT
            * 
        FROM
            click_old 
        WHERE 
            created >= (SELECT MAX(created) FROM click)
    );
    
    -- drop rule for duplicates should raise SQL EXCEPTIONS
    DROP RULE prevent_duplicate_click_id ON click;
    
COMMIT;