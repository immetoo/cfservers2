/* January 4, 2010, Jan, ticket: #4423
Reported by: Wouter G.
Kun je Albelli (17751) in de volgende  staffel zetten?

0-14 sales       10% vergoeding               id 3807
15-24 sales      12% vergoeding               id 3808
25-49 sales      15% vergoeding               id 3810
50+ sales        18% vergoeding               id 3809

Kun je de volgende partijen uitsluiten voor de staffel vergoeding:
MoneyMiljonair (307)
EuroClix (105)
8euromail (7718)
181279 (7723)
VBWEBMEDIA (7284)
zinngeld.nl (5575)
ronisonline (6678)
jakko (8281)
zakgeld internet services (327)
De Heus (4318)
info@jiggy.nl (11524)
18mbakx (9869)
goudbrief (7732)
kingolotto (10059)
ecpull_nl_m4n (11805)
e-Markethings (163)
Martijn Pronk (5486)
goudkliks (11224)
spaarbron (6625)
voorniets (4501)
gamie (3812)
vpvpaffiliate (4601)
ippies.nl (9592)
*/

UPDATE
	lead
SET
	lead_program_id = 3808
WHERE
	lead_program_id IN (3807) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3807, 3808, 3810, 3809) AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY
			affiliate_id
		HAVING
			COUNT(id) >= 15
	) AND
	affiliate_id NOT IN (
		307,   --MoneyMiljonair (307)
		105,   --EuroClix (105)
		7718,  --8euromail (7718)
		7723,  --181279 (7723)
		7284,  --VBWEBMEDIA (7284)
		5575,  --zinngeld.nl (5575)
		6678,  --ronisonline (6678)
		8281,  --jakko (8281)
		327,   --zakgeld internet services (327)
		4318,  --De Heus (4318)
		11524, --info@jiggy.nl (11524)
		9869,  --18mbakx (9869)
		7732,  --goudbrief (7732)
		10059, --kingolotto (10059)
		11805, --ecpull_nl_m4n (11805)
		163,   --e-Markethings (163)
		5486,  --Martijn Pronk (5486)
		11224, --goudkliks (11224)
		6625,  --spaarbron (6625)
		4501,  --voorniets (4501)
		3812,  --gamie (3812)
		4601,  --vpvpaffiliate (4601)
		9592   --ippies.nl (9592)
	);

/* The next steps of the staffel only upgrade from the second level in order to exclude certain affiliates, without having to repeat the list of 
excluded affiliates in each query.

25-49 leads
*/	
UPDATE
	lead
SET
	lead_program_id = 3810
WHERE
	lead_program_id IN (3808) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3807, 3808, 3810, 3809) AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY
			affiliate_id
		HAVING
			COUNT(id) BETWEEN 25 AND 49
	);

/* 50+ leads */	
UPDATE
	lead
SET
	lead_program_id = 3809
WHERE
	lead_program_id IN (3808, 3810) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3807, 3808, 3810, 3809) AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY
			affiliate_id
		HAVING
			COUNT(id) >= 50
	);

/* December 7 2010, Jan, ticket: #6415
Albelli (17751) krijgt een extra staffel. Op dit moment hanteert Albelli de volgende staffels:

Nu komt er een extra staffel speciaal voor twee affiliates, namelijk Imbull (11033) en Actiepagina (3571). Zij krijgen voortaan standaard een 
vergoeding van 7% (lead programma 3806).
*/	
UPDATE
	lead
SET
	lead_program_id = 3806
WHERE
	lead_program_id IN (3807, 3808, 3810, 3809) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (11033, 3571)  AND
	created >= '2010-12-01';
