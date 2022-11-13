-- table: statistics_sliding_per_advertisement
CREATE TABLE statistics_sliding_per_advertisement_temp (
	id									BIGSERIAL NOT NULL,
	advertisement_id 					BIGINT NOT NULL,
	status 								approval_status NOT NULL CHECK (status != 'TRUSTED'),
	cost_total	 						NUMERIC,
	reward_total			 			NUMERIC,
	views_total 						BIGINT,
	clicks_total 						BIGINT,
	leads_total 						BIGINT,
	leads_payed_total 					BIGINT,
    cost_last_payment_period        	NUMERIC,
    reward_last_payment_period      	NUMERIC,
    views_last_payment_period       	BIGINT,
    clicks_last_payment_period      	BIGINT,
    leads_last_payment_period       	BIGINT,
    leads_payed_last_payment_period 	BIGINT,
    cost_current_payment_period        	NUMERIC,
    reward_current_payment_period      	NUMERIC,
    views_current_payment_period      	BIGINT,
    clicks_current_payment_period     	BIGINT,
    leads_current_payment_period       	BIGINT,
    leads_payed_current_payment_period 	BIGINT,    
	cost_last_week 						NUMERIC,
	reward_last_week					NUMERIC,
	views_last_week 					BIGINT,
	clicks_last_week 					BIGINT,
	leads_last_week 					BIGINT,
	leads_payed_last_week 				BIGINT,
	cost_yesterday 						NUMERIC,
	reward_yesterday					NUMERIC,
	views_yesterday 					BIGINT,
	clicks_yesterday 					BIGINT,
	leads_yesterday 					BIGINT,
	leads_payed_yesterday 				BIGINT
);

INSERT INTO statistics_sliding_per_advertisement_temp (
	advertisement_id,
	status,
	cost_total,
	reward_total,
	views_total,
	clicks_total,
	leads_total,
	leads_payed_total,
    cost_last_payment_period,
    reward_last_payment_period,
    views_last_payment_period,
    clicks_last_payment_period,
    leads_last_payment_period,
    leads_payed_last_payment_period, 
    cost_current_payment_period,
    reward_current_payment_period,
    views_current_payment_period,
    clicks_current_payment_period,
    leads_current_payment_period,
    leads_payed_current_payment_period,     
	cost_last_week,
	reward_last_week,
	views_last_week,
	clicks_last_week,
	leads_last_week,
	leads_payed_last_week,
	cost_yesterday,
	reward_yesterday,
	views_yesterday,
	clicks_yesterday,
	leads_yesterday,
	leads_payed_yesterday
)
SELECT 
	* 
FROM 	
	/* SUBQUERY total */ (
		SELECT 
			advertisement_id,
			status,
			SUM(views_cost + click_cost + lead_cost) 		AS cost_total,
			SUM(views_reward + click_reward + lead_reward) 	AS reward_total,
			SUM(total_views) 								AS views_total, -- note the suffix '_total' refers to a period here 
			SUM(total_clicks) 								AS clicks_total,
			SUM(total_leads) 								AS leads_total,
			SUM(payed_leads) 								AS leads_payed_total
		FROM 
			statistics_per_day
		GROUP BY 
			advertisement_id, 
			status
	) AS total

       FULL OUTER JOIN
    
    /* SUBQUERY last_payment_period */ (
        SELECT 
           	advertisement_id,
            status,
            SUM(views_cost + click_cost + lead_cost) 		AS cost_last_payment_period,
            SUM(views_reward + click_reward + lead_reward) 	AS reward_last_payment_period,
            SUM(total_views) 								AS views_last_payment_period,  
            SUM(total_clicks) 								AS clicks_last_payment_period,
            SUM(total_leads) 								AS leads_last_payment_period,
            SUM(payed_leads) 								AS leads_payed_last_payment_period
        FROM 
            statistics_per_day
        WHERE 
            payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = true)
        GROUP BY 
            advertisement_id, 
            status
    ) AS last_payment_period USING (advertisement_id, status)

       FULL OUTER JOIN
    
    /* SUBQUERY current_payment_period */ (
        SELECT 
           	advertisement_id,
            status,
            SUM(views_cost + click_cost + lead_cost) 		AS cost_current_payment_period,
            SUM(views_reward + click_reward + lead_reward) 	AS reward_current_payment_period,
            SUM(total_views) 								AS views_current_payment_period,  
            SUM(total_clicks) 								AS clicks_current_payment_period,
            SUM(total_leads) 								AS leads_current_payment_period,
            SUM(payed_leads) 								AS leads_payed_current_payment_period
        FROM 
            statistics_per_day
        WHERE 
            payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false)
        GROUP BY 
            advertisement_id, 
            status
    ) AS current_payment_period USING (advertisement_id, status)
        	
		FULL OUTER JOIN
	
	/* SUBQUERY last_week */ (
		SELECT 
			advertisement_id,
			status,
			SUM(views_cost + click_cost + lead_cost) 		AS cost_last_week,
			SUM(views_reward + click_reward + lead_reward) 	AS reward_last_week,
			SUM(total_views) 								AS views_last_week,  
			SUM(total_clicks) 								AS clicks_last_week,
			SUM(total_leads) 								AS leads_last_week,
			SUM(payed_leads) 								AS leads_payed_last_week
		FROM 
			statistics_per_day
		WHERE 
			CAST(year || '-'|| month || '-' || day AS date) >= NOW()::date - INTERVAL '7 days'
		GROUP BY 
			advertisement_id, 
			status
	) AS last_week USING (advertisement_id, status)	
    
		FULL OUTER JOIN 
	
	/* SUBQUERY yesterday */ (
		SELECT 
			advertisement_id,
			status,
			SUM(views_cost + click_cost + lead_cost) 		AS cost_yesterday,
			SUM(views_reward + click_reward + lead_reward) 	AS reward_yesterday,
			SUM(total_views) 								AS views_yesterday,  
			SUM(total_clicks) 								AS clicks_yesterday,
			SUM(total_leads) 								AS leads_yesterday,
			SUM(payed_leads) 								AS leads_payed_yesterday
		FROM 
			statistics_per_day
		WHERE 
			CAST(year || '-'|| month || '-' || day AS date) = NOW()::date - INTERVAL '1 days'
		GROUP BY 
			advertisement_id, 
			status
	) AS yesterday USING (advertisement_id, status);

BEGIN;
	DROP TABLE statistics_sliding_per_advertisement;
	ALTER TABLE statistics_sliding_per_advertisement_temp RENAME TO statistics_sliding_per_advertisement;
COMMIT;

CREATE INDEX statistics_sliding_per_advertisement_advertisement_id_idx ON statistics_sliding_per_advertisement USING BTREE (advertisement_id);
CREATE INDEX statistics_sliding_per_advertisement_status_id_idx ON statistics_sliding_per_advertisement USING BTREE (status);