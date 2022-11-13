/* May 19 2010, Jan, ticket: #5127
Zou jij vanaf maandag 24 mei de volgende staffel van start kunnen laten gaan?

lp 4419: standaard bij 1-20 sales per maand
lp 4420: bij 21-40 sales per maand
lp 4421: bij 41-60 sales per maand
lp 4422: bij meer dan 60 sales per maand

Kun jij dit op bruto sales doen? dus alle sales die binnenkomen, ongeacht de status, moeten meetellen met de staffel.

Vanaf maandag kun jij de reguliere staffel helemaal deleten.
*/

/* lp 4420: bij 21-40 sales per maand */ 
UPDATE 
	lead 
SET 
	lead_program_id = 4420
WHERE
	lead_program_id IN (4419) AND
	status IN ('ON_HOLD', 'TO_BE_APPROVED', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-05-24' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE 
			lead_program_id IN (4419, 4420, 4421, 4422) AND 
			status IN ('ON_HOLD', 'TO_BE_APPROVED', 'ACCEPTED') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			created >= '2010-05-24'
		GROUP BY 
			affiliate_id 
		HAVING COUNT(id) BETWEEN 21 AND 40
	);

/* lp 4421: bij 41-60 sales per maand */ 
UPDATE 
	lead 
SET 
	lead_program_id = 4421
WHERE
	lead_program_id IN (4419, 4420) AND
	status IN ('ON_HOLD', 'TO_BE_APPROVED', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-05-24' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE 
			lead_program_id IN (4419, 4420, 4421, 4422) AND 
			status IN ('ON_HOLD', 'TO_BE_APPROVED', 'ACCEPTED') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			created >= '2010-05-24'
		GROUP BY 
			affiliate_id 
		HAVING COUNT(id) BETWEEN 41 AND 60
	);

/* lp 4422: bij meer dan 60 sales per maand */ 
UPDATE 
	lead 
SET 
	lead_program_id = 4422
WHERE
	lead_program_id IN (4419, 4420, 4421) AND
	status IN ('ON_HOLD', 'TO_BE_APPROVED', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-05-24' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE 
			lead_program_id IN (4419, 4420, 4421, 4422) AND 
			status IN ('ON_HOLD', 'TO_BE_APPROVED', 'ACCEPTED') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			created >= '2010-05-24'
		GROUP BY 
			affiliate_id 
		HAVING COUNT(id) > 60
	);
