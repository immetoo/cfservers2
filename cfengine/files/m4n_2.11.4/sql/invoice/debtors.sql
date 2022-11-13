INSERT INTO history.debtor (
	payment_period_id,
	username,
	user_id,
	bedrijfsnaam,
	address,
	house_number,
	zipcode,
	city,
	country,
	user_phone_number,
	user_fax_number,
	user_mobile_phone_number,
	company_phone_number,
	company_fax_number,
	company_email,
	user_email,
	invoice_email,
	company_status,
	url,
	account_number,
	vat_number,
	vat_code,
	account_owner,
	complete_name,
	discount,
	language_code,
	payment_behavior,
	post_invoice,
	"bic/swift" ,
	margin,
	deposit
)

SELECT 
	(SELECT MAX(id) FROM payment_period WHERE processed = true)		AS payment_period_id,
	username,
	user_and_company_configuration.user_id							AS user_id,
	COALESCE(contact_info.name, company_name)						AS company_name,
	COALESCE(contact_info.address, company_address)					AS address,
	COALESCE(contact_info.house_number, company_house_number)		AS house_number,
	COALESCE(contact_info.zipcode, company_zipcode) 				AS zipcode,
	COALESCE(contact_info.city, company_city) 						AS city,
	country_for_billing 											AS country,
	user_phone_number,
	user_fax_number,
	user_mobile_phone_number,
	company_phone_number,
	company_fax_number,
	company_email,
	user_email,
	COALESCE(contact_info.email, user_email)						AS invoice_email,
	company_status,
	company_url,
	company_account_number 											AS account_number,
	company_vat_number 												AS vat_number,
	CASE
		WHEN company_vat_due = false THEN '0'
		ELSE
			CASE WHEN COALESCE(country, company_country, 'NL') = 'NL' THEN '1'
				WHEN COALESCE(country, company_country, 'NL') IN (SELECT iso_code FROM country WHERE is_eu = true) THEN 'C'
				ELSE 'K'
			END
	END				 												AS vat_code,
	company_account_owner 											AS account_owner,
	CASE WHEN addressed_to IS null THEN
		user_full_name
	ELSE 
		addressed_to
	END 															AS complete_name,
	COALESCE(discount, 0.00)										AS discount,
	
	--Taal_code determines the layout of the invoice. The layout is different according:
	--* whether the merchant has a discount
    --* which country the merchant is from
	--* whether the merchant is billed automatically (only possible for the Netherlands (STD layout) 
	language_code													AS language_code,
	payment_behavior,
	COALESCE(post_invoice, false)									AS post_invoice,
	COALESCE(company_account_bank_number, '') 						AS "bic/swift",
	margin,
	deposit
FROM 
	/* SUBQUERY user_and_company_configuration */ (
		SELECT 
			* 
		FROM 
			/* SUBQUERY user_data */ (
				SELECT 
					id 					AS user_id,
					username 			AS username,
					full_name 			AS user_full_name,
					gender 				AS user_gender,
					email 				AS user_email,
					phone_number	 	AS user_phone_number,
					fax_number			AS user_fax_number,
					mobile_phone_number	AS user_mobile_phone_number,
					address				AS user_address,
					house_number		AS user_house_number,
					zip_code			AS user_zipcode,
					city 				AS user_city,
					country				AS user_country,
					account_number		AS user_account_number,
					account_owner		AS user_account_owner			
				FROM
					m4nuser
			) AS user_data
						 	
			LEFT OUTER JOIN			
			/* SUBQUERY company_data_and_contact_info */ ( 
				/* SUBQUERY company_data */ (
					SELECT 
						user_id			 		AS user_id,
						id 						AS company_id,
						vat_due					AS company_vat_due,
						vat_number				AS company_vat_number,
						name 					AS company_name,
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
						status 					AS company_status
					FROM
						company			
				) AS company_data
					
					LEFT OUTER JOIN 
					
				contact_info USING(company_id)
		
		) AS company_data_and_contact_info	USING(user_id)
	) AS user_and_company_configuration 
	
	JOIN /* SUBQUERY companies with language codes */ (
		SELECT	user_id,
				CASE WHEN COALESCE (contact_info.country, company.country) = 'NL' OR COALESCE (contact_info.country, company.country) = '' THEN
						  CASE	WHEN automatic_billing THEN
							    	CASE WHEN discount = 0 THEN 'AI'
										 ELSE 'AI_K' 
									END
								ELSE
									CASE WHEN discount = 0 THEN 'STD'
										 ELSE 'STD_K'
									END
						  END
					 ELSE
						  CASE WHEN discount = 0 THEN 'EN'
							   ELSE 'EN_K'
						  END
			END	 AS language_code,
			company_id,
			COALESCE(discount,0) AS discount,
			payment_behavior,
			deposit,
			post_invoice,
			COALESCE (contact_info.country, company.country) AS country_for_billing,
			margin
		FROM
			company
			LEFT OUTER JOIN contact_info ON company.id = company_id
			LEFT OUTER JOIN invoice_settings USING (user_id)
			LEFT OUTER JOIN advertising_settings ON user_id = merchant_id
		) AS companies_with_language_codes USING (user_id)
	
		LEFT OUTER JOIN									
	
	all_roles_per_user_id ON (user_and_company_configuration.user_id = all_roles_per_user_id.user_id)			
		
WHERE
	/* TODO: only people with affiliate_reward > 0 euros? Regardless of roles??? */
	user_and_company_configuration.user_id IN (SELECT userid FROM users_roles WHERE role = 3) AND 
	user_and_company_configuration.user_id IN (SELECT user_id FROM company WHERE user_id NOTNULL) AND
	user_and_company_configuration.user_id NOT IN (SELECT userid FROM users_roles WHERE	role = 0 AND userid NOTNULL);