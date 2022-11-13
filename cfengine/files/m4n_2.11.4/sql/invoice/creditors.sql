INSERT INTO history.creditor (
	payment_period_id,	 	
	view_reward,			
	click_reward,			
	lead_reward,			
	total_reward,				
	email,
	user_id,
	addressed_to,
	gender,
	company_name,
	initials,
	full_name,
	last_name,
	account_owner,
	address,
	house_number,
	zipcode,
	city,	
	country,
	date_of_birth,
	user_phone_number,
	user_fax_number,
	user_mobile_phone_number,
	company_phone_number,
	company_fax_number,
	company_email,
	company_url,
	account_number,
	account_bank_number,
	vat_number,
	vat_due,
	social_security_number,
	has_company,
	data_modified
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
	gender,
	company_name,
	user_initials								AS initials,
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
	user_phone_number,
	user_fax_number,
	user_mobile_phone_number,
	company_phone_number,
	company_fax_number,
	company_email,
	company_url,
	
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
			END 								AS account_bank_number,
	vat_number,
	COALESCE(vat_due, false)			AS vat_due, --vat_due is null when there's no company --> no vat duty
	CASE WHEN user_social_security_number = 'null' 
		THEN NULL
		ELSE user_social_security_number
	END											AS social_security_number,
	CASE WHEN user_id IN (SELECT userid FROM users_roles WHERE role = 10) THEN true ELSE false END AS has_company,
	CASE WHEN (--has data modifications
			user_last_modified > (SELECT start_date FROM payment_period WHERE processed = true ORDER BY id DESC LIMIT 1) OR
			company_last_modified > (SELECT start_date FROM payment_period WHERE processed = true ORDER BY id DESC LIMIT 1) OR
			contact_last_modified > (SELECT start_date FROM payment_period WHERE processed = true ORDER BY id DESC LIMIT 1)
		  ) THEN true ELSE false END AS data_modified
FROM 
	/* SUBQUERY user_and_company_configuration */ (
			/* SUBQUERY user_data */ (
				SELECT 
					id 					AS user_id,
					username 			AS user_name,
					full_name			AS user_full_name,
					last_name			AS user_last_name,
					gender 				AS gender,
					email 				AS user_email,
					phone_number	 	AS user_phone_number,
					fax_number			AS user_fax_number,
					mobile_phone_number AS user_mobile_phone_number,
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
					house_number		AS user_house_number,
					date_of_birth		AS user_date_of_birth,
					last_modified		AS user_last_modified
				FROM
					m4nuser
			) AS user_data
			
			LEFT OUTER JOIN	
					
			/* SUBQUERY company_data_and_contact_info */ ( 
				/* SUBQUERY company_data */ (
					SELECT 
						user_id			 		AS user_id,
						id 						AS company_id,
						vat_number				AS vat_number,
						vat_due					AS vat_due,
						name					AS company_name,
						email 					AS company_email,
						phone_number 			AS company_phone_number,
						fax_number				AS company_fax_number,		
						mobile_phone_number 	AS company_mobile_phone_number,
						address					AS company_address,
						house_number			AS company_house_number,
						city 					AS company_city,
						zip_code				AS company_zipcode,
						country					AS company_country,
						account_number			AS company_account_number,
						account_bank_number		AS company_account_bank_number,
						account_owner			AS company_account_owner,
						url						AS company_url,
						status 					AS company_status,
						last_modified			AS company_last_modified
					FROM
						company			
				) AS company_data
					
					LEFT OUTER JOIN 
					
				(SELECT company_id,
						addressed_to,
						name			AS contact_name,
						address			AS contact_address,
						house_number	AS contact_house_number,
						zipcode			AS contact_zipcode,
						city			AS contact_city,
						country			AS contact_country,
						last_modified	AS contact_last_modified
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
	--has mutations
	total_reward > 0;