/* August 13 2010, Jan, ticket: #5689
MoneYou Verzekeren 19632 staffels
*/

/* 
4164  	 Aansprakelijkheidsverzekering 1-5 sales
4727  	 Aansprakelijkheidsverzekering 6-10 sales 
4732  	 Aansprakelijkheidsverzekering 10+ sales 
*/

UPDATE
	lead
SET
	lead_program_id = 4727
WHERE
	lead_program_id IN (4164) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4164, 4727, 4732) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 6 AND COUNT(id) <= 10
	);

UPDATE
	lead
SET
	lead_program_id = 4732
WHERE
	lead_program_id IN (4164, 4727) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4164, 4727, 4732) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 10
	);

/*
4163  	 Inboedel 1-5 sales 
4733  	 Inboedel 6-10 sales 
4734  	 Inboedel 10+ sales 
*/

UPDATE
	lead
SET
	lead_program_id = 4733
WHERE
	lead_program_id IN (4163) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4163, 4733, 4734) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 6 AND COUNT(id) <= 10
	);

UPDATE
	lead
SET
	lead_program_id = 4734
WHERE
	lead_program_id IN (4163, 4733) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4163, 4733, 4734) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 10
	);
	
/*
4162  	 Opstal- / Woonhuisverzekering 1-5 sales 
4735  	 Opstal- / Woonhuisverzekering 6-10 sales 
4736  	 Opstal- / Woonhuisverzekering 10+ sales 
*/

UPDATE
	lead
SET
	lead_program_id = 4735
WHERE
	lead_program_id IN (4162) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4162, 4735, 4736) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 6 AND COUNT(id) <= 10
	);

UPDATE
	lead
SET
	lead_program_id = 4736
WHERE
	lead_program_id IN (4162, 4735) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4162, 4735, 4736) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 10
	);
	
/*
4167  	 Overlijdensrisico 1-5 sales 
4723  	 Overlijdensrisico 6-10 sales 
4724  	 Overlijdensrisico 10+ sales  
*/
	
UPDATE
	lead
SET
	lead_program_id = 4723
WHERE
	lead_program_id IN (4167) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4167, 4723, 4724) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 6 AND COUNT(id) <= 10
	);

UPDATE
	lead
SET
	lead_program_id = 4724
WHERE
	lead_program_id IN (4167, 4723) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4167, 4723, 4724) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 10
	);
	
/*
4165  	 Rechtsbijstandverzekering 1-5 sales 
4728  	 Rechtsbijstandverzekering 6-10 sales 
4729  	 Rechtsbijstandverzekering 10+ sales 
*/

UPDATE
	lead
SET
	lead_program_id = 4728
WHERE
	lead_program_id IN (4165) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4165, 4728, 4729) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 6 AND COUNT(id) <= 10
	);

UPDATE
	lead
SET
	lead_program_id = 4729
WHERE
	lead_program_id IN (4165, 4728) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4165, 4728, 4729) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 10
	);

/*
4166  	 Reis & Annuleringsverzekering 1-5 sales  
4725  	 Reis & Annuleringsverzekering 6-10 sales 
4726  	 Reis & Annuleringsverzekering 10+ sales 
*/

UPDATE
	lead
SET
	lead_program_id = 4725
WHERE
	lead_program_id IN (4166) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4166, 4725, 4726) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 6 AND COUNT(id) <= 10
	);

UPDATE
	lead
SET
	lead_program_id = 4726
WHERE
	lead_program_id IN (4166, 4725) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created <= '2011-04-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4166, 4725, 4726) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created <= '2011-04-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 10
	);