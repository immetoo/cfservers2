INSERT INTO history.creditor (
	payment_period_id,	 	
	view_reward,			
	click_reward,			
	lead_reward,			
	total_reward,				
	email,
	user_id,
	addressed_to,
	pers_gender,
	comp_name,
	initials,
	name, --Only filled when a separate factuuradres was specified
	full_name,
	last_name,
	account_owner,
	address,
	house_number,
	zipcode,
	city,	
	country,
	date_of_birth,
	pers_phonenumber,
	pers_faxnumber,
	pers_mobilephonenumber,
	comp_phonenumber,
	comp_faxnumber,
	comp_email,
	comp_url,
	comp_account_number,
	comp_account_bank_number,
	vat,
	vat_due,
	social_security_number,
	has_company
) 
SELECT 
	(SELECT MAX(id) FROM payment_period WHERE processed = true)	AS payment_period_id,
	COALESCE(view_reward, 0.0)									AS view_reward,
	COALESCE(click_reward, 0.0)									AS click_reward,
	COALESCE(lead_reward, 0.0)									AS lead_reward,			
	COALESCE(total_reward, 0.0)									AS total_reward,
	user_email													AS email,
	user_id														AS user_id,
	CASE WHEN addressed_to IS null THEN
		user_full_name
	ELSE 
		addressed_to
	END 										AS addressed_to,
	user_gender 								AS pers_gender,
	company_name,
	user_initials								AS initials,
	contact_name,
	user_full_name						 		AS full_name,
	user_last_name,
	CASE WHEN company_account_owner IS NOT null THEN 
		CASE WHEN company_account_owner = '' THEN 
			company_name 
		ELSE 
			company_account_owner
		END 
	ELSE 
		CASE WHEN user_account_owner = '' THEN 
			user_last_name
		ELSE 
			user_account_owner 
		END
	END 										AS account_owner,
	COALESCE(contact_address, company_address, user_address)	AS address,
	COALESCE(contact_house_number, company_house_number, user_house_number) AS house_number,
	COALESCE(contact_zipcode, company_zipcode, user_zipcode) 	AS zipcode,
	COALESCE(contact_city, company_city, user_city)				AS city,	
	COALESCE(contact_country, company_country, user_country) 	AS country,
	user_date_of_birth,
	user_phonenumber							AS pers_phonenumber,
	user_faxnumber								AS pers_faxnumber,
	user_mobilephonenumber						AS pers_mobilephonenumber,
	company_phonenumber							AS comp_phonenumber,
	company_faxnumber							AS comp_faxnumber,
	company_email								AS comp_email,
	company_url									AS comp_url,
	
	-- This needs further refactoring!!!
	CASE WHEN company_account_number NOTNULL AND company_account_number NOT IN ('', 'null')
			THEN company_account_number
			ELSE 
				CASE WHEN user_account_number ISNULL OR user_account_number = 'null' THEN '' ELSE user_account_number END
			END 								AS comp_account_number,
	CASE WHEN company_account_bank_number NOTNULL AND company_account_bank_number NOT IN ('', 'null')
			THEN company_account_bank_number
			ELSE 
				CASE WHEN user_account_bank_number ISNULL OR user_account_bank_number = 'null' THEN '' ELSE user_account_bank_number END
			END 								AS comp_account_bank_number,
	company_vat_number							AS vat,
	COALESCE(company_vat_due, false)			AS vat_due, --vat_due is null when there's no company --> no vat duty
	CASE WHEN user_social_security_number = 'null' 
		THEN NULL
		ELSE user_social_security_number
	END											AS social_security_number,
	CASE WHEN user_id IN (SELECT userid FROM users_roles WHERE role = 10) THEN true ELSE false END AS has_company
	
FROM 
	/* SUBQUERY user_and_company_configuration */ (
		SELECT 
			* 
		FROM 
			/* SUBQUERY user_data_and_invoice_settings */ (
				/* SUBQUERY user_data */ (
					SELECT 
						id 					AS user_id,
						username 			AS user_name,
						full_name			AS user_full_name,
						last_name			AS user_last_name,
						gender 				AS user_gender,
						email 				AS user_email,
						phone_number	 	AS user_phonenumber,
						fax_number			AS user_faxnumber,
						mobile_phone_number AS user_mobilephonenumber,
						address				AS user_address,
						zip_code			AS user_zipcode,
						city 				AS user_city,
						country				AS user_country,
						account_number		AS user_account_number,
						account_bank_number AS user_account_bank_number,
						account_owner		AS user_account_owner,
						url					AS user_url,
						social_security_number	AS user_social_security_number,
						initials			AS user_initials,
						last_name,
						house_number		AS user_house_number,
						date_of_birth		AS user_date_of_birth,
						CASE WHEN m4nuser.id IN (SELECT userid FROM users_roles WHERE role = 10) THEN true ELSE false END AS has_company			
					FROM
						m4nuser
				) AS user_data
				
					LEFT OUTER JOIN		
						
				invoice_settings USING (user_id)
				
			) AS user_data_and_invoice_settings
				 	
			LEFT OUTER JOIN	
					
			/* SUBQUERY company_data_and_contact_info */ ( 
				/* SUBQUERY company_data */ (
					SELECT 
						user_id			 		AS user_id,
						id 						AS company_id,
						vat_number				AS company_vat_number,
						vat_due					AS company_vat_due,
						name					AS company_name,
						email 					AS company_email,
						phone_number 			AS company_phonenumber,
						fax_number				AS company_faxnumber,		
						mobile_phone_number 	AS company_mobilephonenumber,
						address					AS company_address,
						house_number			AS company_house_number,
						city 					AS company_city,
						zip_code				AS company_zipcode,
						country					AS company_country,
						account_number			AS company_account_number,
						account_bank_number		AS company_account_bank_number,
						account_owner			AS company_account_owner,
						url						AS company_url,
						status 					AS company_status
					FROM
						company			
				) AS company_data
					
					LEFT OUTER JOIN 
					
				(SELECT company_id,
						addressed_to,
						name AS contact_name,
						address AS contact_address,
						house_number AS contact_house_number,
						zipcode AS contact_zipcode,
						city AS contact_city,
						country AS contact_country
				 FROM contact_info) AS contact USING(company_id)
		
			) AS company_data_and_contact_info	USING(user_id)
		) AS user_and_company_configuration
		
		LEFT OUTER JOIN
		
	/* SUBQUERY creditor_mutations */ (
		SELECT 
			affiliate_id,
			payment_period_id,
			COALESCE(ROUND(SUM(statistics_per_day.views_reward), 2), 0)																			AS view_reward,
			COALESCE(ROUND(SUM(statistics_per_day.click_reward), 2), 0) 																		AS click_reward,
			COALESCE(ROUND(SUM(statistics_per_day.lead_reward), 2), 0) 																			AS lead_reward,
			COALESCE(ROUND(SUM(statistics_per_day.views_reward + statistics_per_day.click_reward + statistics_per_day.lead_reward), 2), 0)		AS total_reward																		
		FROM 
			statistics_per_day
		WHERE 
			statistics_per_day.status  = 'ACCEPTED' AND
			payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = true) 
		GROUP BY 
			affiliate_id,
			payment_period_id		
	) AS creditor_mutations ON (user_and_company_configuration.user_id = creditor_mutations.affiliate_id)
	
WHERE 
	user_id IN (SELECT userid FROM users_roles WHERE role = 2) AND
	user_id NOT IN (SELECT userid FROM users_roles WHERE role = 0 AND userid NOTNULL)
;