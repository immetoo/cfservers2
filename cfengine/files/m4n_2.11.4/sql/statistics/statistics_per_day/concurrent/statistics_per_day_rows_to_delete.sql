DROP TABLE IF EXISTS statistics_per_day_rows_to_delete;

CREATE TABLE statistics_per_day_rows_to_delete AS SELECT  
    id 
FROM 	  
    statistics_per_day,
    rows_to_be_updated_day 
WHERE
    statistics_per_day.payment_period_id IN (SELECT distinct(payment_period_id) FROM rows_to_be_updated_day) AND
    statistics_per_day.zone_id = rows_to_be_updated_day.zone_id AND
    statistics_per_day.affiliate_id = rows_to_be_updated_day.affiliate_id AND
    statistics_per_day.day = EXTRACT(day FROM date_to_be_updated) AND
    statistics_per_day.month = EXTRACT(month FROM date_to_be_updated) AND
    statistics_per_day.year = EXTRACT(year FROM date_to_be_updated);