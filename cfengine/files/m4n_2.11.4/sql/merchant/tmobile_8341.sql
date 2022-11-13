--move all clicks from moneymiljonair to special advertisementid 667981
UPDATE
	click
SET
	advertisement_id = 667981 
WHERE
	merchant_id = 8341 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 307 AND
	advertisement_id != 667981;

--October 4 2010, Dineke: starting October 1st, the old staffels go.
--new rule 1: LP 4272, 4277, 4260, 4281, 4264,4268,4590 dienen op LP 4256 (Voice/MBI/Simonly/renewal/ iphone) te komen. 
UPDATE
	lead
SET
	lead_program_id = 4256
WHERE
	lead_program_id IN (4272, 4277, 4260, 4281, 4264,4268,4590) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-10-01';

	--new rule 2: LP 4274  dient à 4273 (Zakelijk)
UPDATE
	lead
SET
	lead_program_id = 4273
WHERE
	lead_program_id IN (4274) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-10-01';

--October 22 2010, Dineke:  program 4871 is made to give new leads with old clicks the right reward. Can go after October 1st + cookietime.
UPDATE
	lead
SET
	lead_program_id = 4871
WHERE
	lead_program_id IN (4256) AND
	payment_period_id IN (SELECT id FROM paymenT_period WHERE processed = false) AND
	click_created < '2010-10-01' AND
	created > '2010-10-01';
	