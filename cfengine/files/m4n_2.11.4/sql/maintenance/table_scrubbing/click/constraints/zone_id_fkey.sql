ALTER TABLE click_new ADD CONSTRAINT click_zone_id_fkey FOREIGN KEY (zone_id) REFERENCES zone (id) ON UPDATE CASCADE ON DELETE CASCADE; 