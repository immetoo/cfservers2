INSERT INTO history.debtor (
	payment_period_id,
	username,
	user_id,
	bedrijfsnaam,
	adres,
	house_number,
	zipcode,
	plaats,
	land_code,
	tel_prive,
	fax_prive,
	GSM,
	comp_tel,
	comp_fax,
	comp_mail,
	prive_mail,
	invoice_mail,
	company_status,
	url,
	show_deb,
	show_cred,
	rek,
	rekening_nummer,
	BTW_nummer,
	vat_code,
	rekening_houder,
	complete_name,
	discount,
	taal_code,
	automatische_incasso,
	account_manager,
	payment_behavior,
	post_invoice,
	"bic/swift" ,
	deposit
)
SELECT 
	(SELECT MAX(id) FROM payment_period WHERE processed = true)		AS payment_period_id,
	user_name 														AS username,
	user_and_company_configuration.user_id							AS user_id,
	COALESCE(name, company_name)									AS bedrijfsnaam,
	COALESCE(address, company_address)								AS adres,
	COALESCE(house_number, company_house_number)					AS house_number,
	COALESCE(zipcode, company_zipcode) 								AS zipcode,
	COALESCE(city, company_city) 									AS plaats,
	COALESCE(country, company_country, 'NL') 						AS land_code,
	user_phonenumber 												AS tel_prive,
	user_faxnumber 													AS fax_prive,
	user_mobilephonenumber  										AS GSM,
	company_phonenumber 											AS comp_tel,
	company_faxnumber												AS comp_fax,
	company_email													AS comp_mail,
	user_email														AS prive_mail,
	COALESCE(email, user_email)										AS invoice_email,
	company_status,
	company_url 													AS url,
	'T' 															AS show_deb,
	'T' 															AS show_cred,
	'1100' 															AS rek,
	company_account_number 											AS rekening_nummer,
	company_vat_number 												AS BTW_nummer,
	CASE
		WHEN company_vat_due = false THEN '0'
		ELSE
			CASE WHEN COALESCE(country, company_country, 'NL') = 'NL' THEN '1'
				WHEN COALESCE(country, company_country, 'NL') IN (SELECT iso_code FROM country WHERE is_eu = true) THEN 'C'
				ELSE 'K'
			END
	END				 												AS vat_code,
	company_account_owner 											AS rekening_houder,
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
	language_code													AS taal_code,
	CASE WHEN automatic_billing = true THEN 
		'T' 
	ELSE 
		'F' 
	END 															AS automatische_incasso,
	account_manager_user_id 										AS account_manager,
	payment_behavior,
	COALESCE(post_invoice, false)									AS post_invoice,
	COALESCE(company_account_bank_number, '') 						AS "bic/swift",
	deposit
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
						full_name 			AS user_full_name,
						gender 				AS user_gender,
						email 				AS user_email,
						phone_number	 	AS user_phonenumber,
						fax_number			AS user_faxnumber,
						mobile_phone_number	AS user_mobilephonenumber,
						address				AS user_address,
						house_number		AS user_house_number,
						zip_code			AS user_zipcode,
						city 				AS user_city,
						country				AS user_country,
						account_number		AS user_account_number,
						account_owner		AS user_account_owner,
						url					AS user_url			
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
						vat_due					AS company_vat_due,
						vat_number				AS company_vat_number,
						name 					AS company_name,
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
					
				contact_info USING(company_id)
		
		) AS company_data_and_contact_info	USING(user_id)
	) AS user_and_company_configuration 
	
	JOIN /* SUBQUERY companies with language codes */ (
		SELECT	user_id,
				CASE WHEN country = 'NL' OR country = '' THEN
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
			  END	 AS language_code
		FROM
			(SELECT
				company.user_id AS user_id,
				company_id,
				COALESCE(discount,0) AS discount,
				automatic_billing,
				COALESCE (contact_info.country, company.country) AS country
			 FROM
				company
				LEFT OUTER JOIN contact_info ON company.id = company_id
				LEFT OUTER JOIN invoice_settings USING (user_id)
			) AS company_countries_with_discount

	) AS companies_with_language_codes USING (user_id)
	
		LEFT OUTER JOIN									
	
	all_roles_per_user_id ON (user_and_company_configuration.user_id = all_roles_per_user_id.user_id)			
		
WHERE 
	user_and_company_configuration.user_id IN (SELECT userid FROM users_roles WHERE role = 3) AND 
	user_and_company_configuration.user_id IN (SELECT user_id FROM company WHERE user_id NOTNULL) AND
	user_and_company_configuration.user_id NOT IN (SELECT userid FROM users_roles WHERE	role = 0 AND userid NOTNULL)

ORDER BY 
	user_and_company_configuration.user_id ASC;