INSERT INTO registered_system_jobs (
	trigger_name, 
	job_name, 
	job_group, 
	message, 
	runtime, 
	started
) 
VALUES (
	'per_day_query',
	'per_day',
	'statistics',
	'',
	0,
	now()
);

/* 
 * Create tables with the rows that need to be deleted and recalculated where 
 * last_modified is after the start time of the previous deletion/calculation. 
 */
 
DROP TABLE IF EXISTS rows_to_be_updated_day;

CREATE TABLE rows_to_be_updated_day AS
SELECT DISTINCT 
	zone_id, 
	affiliate_id,  
	created::date AS date_to_be_updated,
	current_payment_periods.payment_period_id
FROM 
	(SELECT id AS payment_period_id FROM payment_period WHERE processed = false) AS current_payment_periods,
	click
INNER JOIN
    payment_period ON click.payment_period_id = payment_period.id
WHERE 
	last_modified > (
		SELECT 
			max(started) 
		FROM 
		  	registered_system_jobs 
		WHERE 
			job_name = 'per_day' AND 
			job_group = 'statistics' AND 
			started < (
				SELECT 
					max(started) 
		      	FROM 
		      		registered_system_jobs 
		      	WHERE 
		      		job_name = 'per_day' AND 
		      		job_group = 'statistics' 
		      ) 
	) AND
	payment_period.processed = false

UNION

SELECT DISTINCT 
	zone_id, 
	affiliate_id, 
	created::date AS date_to_be_updated,
	current_payment_periods.payment_period_id	
FROM 
	(SELECT id AS payment_period_id FROM payment_period WHERE processed = false) AS current_payment_periods,	
	view
INNER JOIN
	payment_period ON view.payment_period_id = payment_period.id
WHERE 
 	last_modified > (
		SELECT 
		  	max(started) 
		FROM 
			registered_system_jobs 
		WHERE 
			job_name = 'per_day' AND 
			job_group = 'statistics' AND 
			started < (
				SELECT 
					max(started) 
			  	FROM 
		      		registered_system_jobs 
				WHERE 
		      		job_name = 'per_day' AND 
					job_group = 'statistics' 
			) 
	) AND
    payment_period.processed = false
	
UNION

SELECT DISTINCT 
	zone_id, 
	lead.affiliate_id,
	lead.created::date AS date_to_be_updated,
	current_payment_periods.payment_period_id
FROM 
	(SELECT id AS payment_period_id FROM payment_period WHERE processed = false) AS current_payment_periods,
	click,
	lead
INNER JOIN
    payment_period ON lead.payment_period_id = payment_period.id
WHERE 
	click.id = lead.click_id AND 
	lead.last_modified > (
    	SELECT 
			max(started) 
		FROM 
			registered_system_jobs 
        WHERE 
        	job_name = 'per_day' AND 
        	job_group = 'statistics' AND 
        	started < (
				SELECT 
					max(started) 
				FROM 
					registered_system_jobs 
				WHERE 
					job_name = 'per_day' AND 
					job_group = 'statistics' 
			) 
	) AND
    payment_period.processed = false;

DROP TABLE IF EXISTS rows_to_be_updated_week;

CREATE TABLE rows_to_be_updated_week AS 
SELECT
    zone_id,
    affiliate_id,
    EXTRACT(week FROM date_to_be_updated) AS week,
    EXTRACT(month FROM date_to_be_updated) AS month,
    EXTRACT(year FROM date_to_be_updated) AS year,
    payment_period_id
FROM 
    rows_to_be_updated_day 
GROUP BY
    zone_id,
    affiliate_id,
    week,
    month,
    year,
    payment_period_id;

DROP TABLE IF EXISTS rows_to_be_updated_month;

CREATE TABLE rows_to_be_updated_month AS 
SELECT
    zone_id,
    affiliate_id,
    EXTRACT(month FROM date_to_be_updated) AS month,
    EXTRACT(year FROM date_to_be_updated) AS year,
    payment_period_id
FROM 
    rows_to_be_updated_day 
GROUP BY
    zone_id,
    affiliate_id,
    month,
    year,
    payment_period_id;

DROP TABLE IF EXISTS rows_to_be_updated_year;

CREATE TABLE rows_to_be_updated_year AS 
SELECT
    zone_id,
    affiliate_id,
    year,
    payment_period_id
FROM 
    rows_to_be_updated_month
GROUP BY
    zone_id,
    affiliate_id,
    year,
    payment_period_id;