-- optionally compare dart_vars with dart_vars_old and drop dart_vars_old (including sequence)
DROP TABLE dart_vars_old;
DROP SEQUENCE IF EXISTS dart_vars_old_id_seq;