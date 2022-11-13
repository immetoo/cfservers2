INSERT INTO history.sale_order (
	payment_period_id,
	ord_nr,
	rpl_inv,
	emp_nr,
	inv_date,
	comment1,
	desc_code,
	comment2,
	project,
	inc
)
SELECT 
	payment_period.id																											AS payment_period_id,
	to_char(payment_period.end_date, 'YYMM') || lpad(m4nuser.id::text, 5 , 0::text) 											AS ORD_NR,
	m4nuser.id																													AS RPL_INV,
	COALESCE (account_manager_user_id, 0) 																						AS EMP_NR,
	to_char(payment_period.end_date, 'DD-MM-YYYY') 																				AS INV_DATE,
	trim(to_char(payment_period.start_date, 'Month')) || ' ' || to_char(payment_period.start_date, 'yyyy') 						AS COMMENT1,
	CASE WHEN automatic_billing = true THEN 
		'ai' 
	ELSE 
		'1' 
	END 																														AS DESC_CODE,
	to_char(payment_period.start_date, 'DD-MM-YY') || ' - ' || to_char(payment_period.end_date - interval '1 day' , 'DD-MM-YY')	AS COMMENT2,
	project_code 																												AS project,
	CASE WHEN automatic_billing = true THEN 
		'T'	
	ELSE 
		'F' 
	END 																														AS inc
FROM 
	m4nuser, 
	payment_period, 
	invoice_settings 
WHERE 
	payment_period.id = (SELECT MAX(id) FROM payment_period WHERE processed = true) AND
	invoice_settings.user_id = m4nuser.id AND
	m4nuser.id IN
		--created sale_orders for all merchants with any costs this last payment period and for all users with current articles (invoice_lines)
		(SELECT DISTINCT
				merchant_id
		 FROM
		 		statistics_per_month
		 WHERE
		 		payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = true) AND
		 		status = 'ACCEPTED' AND
		 		(lead_cost + click_cost + views_cost) > 0
		 UNION
		 
		 SELECT DISTINCT user_id FROM invoice_line
		);