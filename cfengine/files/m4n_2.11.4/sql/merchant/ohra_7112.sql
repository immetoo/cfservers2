/* October 18th 2010, Jan, ticket: #6053
Aanvrager: Koen van der Veer

Adverteerder: OHRA    
ID Adverteerder: 7112

Exploitanten (in geval van special deal. Username + id): alle exploitanten

Welk type staffel is het (maak 1 keuze)?
4) Bonusdeal

Lead programma's ID of advertentie ID (oud en nieuw): 

ID 1123 Autoverzekering: bij iedere 5 verzekeringen 25 e extra. -> 4851
ID 2930 Woonverzekering: bij iedere 5 verzekeringen 25 e extra. -> 4852
ID 2931 Reisverzekering: 40 e en bij iedere 5 verzekeringen 20 e extra. -> 4853
ID 2929 Rechtsbijstandverzekering: 30 e en bij iedere 5 verzekeringen 75 e extra. -> 4854


Wat moet er precies gebeuren?
Zoals hierboven beschreven graag een staffel bonus deal invoeren. De nieuwe (standaard) vergoedingen zijn al ingevoerd. Nu graag dus nog een extra bedrag per 5 verkochte verzekeringen.

Startdatum: 4 oktober 2010
Einddatum: oneindig

Update 23 november 2010, changed Bonus amount for program 4854 to 60 Euros at Koen's request
*/

/* ID 1123 Autoverzekering: bij iedere 5 verzekeringen 25 e extra. -> 4851 */
BEGIN;

INSERT INTO lead (
	click_id, 
	lead_program_id, 
	description1,
	price, 
	status,  
	referrer, 
	ip_address, 
	user_agent, 
	payment_period_id, 
	affiliate_id, 
	click_created,
	created
)

SELECT
	MAX(click_id) AS click_id,
	 4851 AS lead_program_id,
	 'Nieuwe bonuslead' AS description1,
	 0 AS price,
	 'ACCEPTED'::approval_status AS status,
	 'automatic lead'::text AS referrer,
	 '127.0.0.1'::inet AS ip_address,
	 'inserted by m4n'::text AS user_agent,
	 (SELECT MAX(id) FROM payment_period WHERE processed = false) AS payment_period_id,
	 affiliate_id AS affiliate_id,
	 MAX(click_created) AS click_created,
	 now() - interval '7 hours' 
FROM
	lead
WHERE
	status = 'ACCEPTED' AND
	created >= '2010-10-04' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 1123 AND
	NOT EXISTS (
		SELECT
			affiliate_id
		FROM
			lead AS bonus_leads
		WHERE
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			bonus_leads.lead_program_id = 4851 AND
			lead.affiliate_id = bonus_leads.affiliate_id
	)
GROUP BY
	affiliate_id
HAVING
	COUNT(*) >= 5;

UPDATE
	lead
SET
	description1		= bonuses.description1,
	description2		= bonuses.description2,
	price				= bonuses.price,
	payment_period_id	= bonuses.payment_period_id
FROM
	(
		SELECT
			affiliate_id,
			'bonus laatst uitgerekend ' || now()::date AS description1,
			'bonus voor ' || (COUNT(*)/5) * 5 || ' leads' AS description2,
			(COUNT(*)/5)*84 AS price,
			(SELECT MAX(id) FROM payment_period) AS payment_period_id
		FROM
			lead
		WHERE
			lead_program_id = 1123 AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			created >= '2010-10-04'
		GROUP BY
			affiliate_id
	) AS bonuses
WHERE
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 4851 AND
	lead.affiliate_id = bonuses.affiliate_id;
	
END;

/* ID 2930 Woonverzekering: bij iedere 5 verzekeringen 25 e extra. -> 4852 */
BEGIN;

INSERT INTO lead (
	click_id, 
	lead_program_id, 
	description1,
	price, 
	status,  
	referrer, 
	ip_address, 
	user_agent, 
	payment_period_id, 
	affiliate_id, 
	click_created,
	created
)

SELECT
	MAX(click_id) AS click_id,
	 4852 AS lead_program_id,
	 'Nieuwe bonuslead' AS description1,
	 0 AS price,
	 'ACCEPTED'::approval_status AS status,
	 'automatic lead'::text AS referrer,
	 '127.0.0.1'::inet AS ip_address,
	 'inserted by m4n'::text AS user_agent,
	 (SELECT MAX(id) FROM payment_period WHERE processed = false) AS payment_period_id,
	 affiliate_id AS affiliate_id,
	 MAX(click_created) AS click_created,
	 now() - interval '7 hours' 
FROM
	lead
WHERE
	status = 'ACCEPTED' AND
	created >= '2010-10-04' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2930 AND
	NOT EXISTS (
		SELECT
			affiliate_id
		FROM
			lead AS bonus_leads
		WHERE
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			bonus_leads.lead_program_id = 4852 AND
			lead.affiliate_id = bonus_leads.affiliate_id
	)
GROUP BY
	affiliate_id
HAVING
	COUNT(*) >= 5;

UPDATE
	lead
SET
	description1		= bonuses.description1,
	description2		= bonuses.description2,
	price				= bonuses.price,
	payment_period_id	= bonuses.payment_period_id
FROM
	(
		SELECT
			affiliate_id,
			'bonus laatst uitgerekend ' || now()::date AS description1,
			'bonus voor ' || (COUNT(*)/5) * 5 || ' leads' AS description2,
			(COUNT(*)/5)*84 AS price,
			(SELECT MAX(id) FROM payment_period) AS payment_period_id
		FROM
			lead
		WHERE
			lead_program_id = 2930 AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			created >= '2010-10-04'
		GROUP BY
			affiliate_id
	) AS bonuses
WHERE
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 4852 AND
	lead.affiliate_id = bonuses.affiliate_id;
	
END;

/* ID 2931 Reisverzekering: 40 e en bij iedere 5 verzekeringen 20 e extra. -> 4853 */
BEGIN;

INSERT INTO lead (
	click_id, 
	lead_program_id, 
	description1,
	price, 
	status,  
	referrer, 
	ip_address, 
	user_agent, 
	payment_period_id, 
	affiliate_id, 
	click_created,
	created
)

SELECT
	MAX(click_id) AS click_id,
	 4853 AS lead_program_id,
	 'Nieuwe bonuslead' AS description1,
	 0 AS price,
	 'ACCEPTED'::approval_status AS status,
	 'automatic lead'::text AS referrer,
	 '127.0.0.1'::inet AS ip_address,
	 'inserted by m4n'::text AS user_agent,
	 (SELECT MAX(id) FROM payment_period WHERE processed = false) AS payment_period_id,
	 affiliate_id AS affiliate_id,
	 MAX(click_created) AS click_created,
	 now() - interval '7 hours' 
FROM
	lead
WHERE
	status = 'ACCEPTED' AND
	created >= '2010-10-04' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2931 AND
	NOT EXISTS (
		SELECT
			affiliate_id
		FROM
			lead AS bonus_leads
		WHERE
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			bonus_leads.lead_program_id = 4853 AND
			lead.affiliate_id = bonus_leads.affiliate_id
	)
GROUP BY
	affiliate_id
HAVING
	COUNT(*) >= 5;

UPDATE
	lead
SET
	description1		= bonuses.description1,
	description2		= bonuses.description2,
	price				= bonuses.price,
	payment_period_id	= bonuses.payment_period_id
FROM
	(
		SELECT
			affiliate_id,
			'bonus laatst uitgerekend ' || now()::date AS description1,
			'bonus voor ' || (COUNT(*)/5) * 5 || ' leads' AS description2,
			(COUNT(*)/5)*68.01 AS price,
			(SELECT MAX(id) FROM payment_period) AS payment_period_id
		FROM
			lead
		WHERE
			lead_program_id = 2931 AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			created >= '2010-10-04'
		GROUP BY
			affiliate_id
	) AS bonuses
WHERE
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 4853 AND
	lead.affiliate_id = bonuses.affiliate_id;
	
END;

/* ID 2929 Rechtsbijstandverzekering: 30 e en bij iedere 5 verzekeringen 60 e extra. -> 4854 */
BEGIN;

INSERT INTO lead (
	click_id, 
	lead_program_id, 
	description1,
	price, 
	status,  
	referrer, 
	ip_address, 
	user_agent, 
	payment_period_id, 
	affiliate_id, 
	click_created,
	created
)

SELECT
	MAX(click_id) AS click_id,
	 4854 AS lead_program_id,
	 'Nieuwe bonuslead' AS description1,
	 0 AS price,
	 'ACCEPTED'::approval_status AS status,
	 'automatic lead'::text AS referrer,
	 '127.0.0.1'::inet AS ip_address,
	 'inserted by m4n'::text AS user_agent,
	 (SELECT MAX(id) FROM payment_period WHERE processed = false) AS payment_period_id,
	 affiliate_id AS affiliate_id,
	 MAX(click_created) AS click_created,
	 now() - interval '7 hours' 
FROM
	lead
WHERE
	status = 'ACCEPTED' AND
	created >= '2010-10-04' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2929 AND
	NOT EXISTS (
		SELECT
			affiliate_id
		FROM
			lead AS bonus_leads
		WHERE
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			bonus_leads.lead_program_id = 4854 AND
			lead.affiliate_id = bonus_leads.affiliate_id
	)
GROUP BY
	affiliate_id
HAVING
	COUNT(*) >= 5;

UPDATE
	lead
SET
	description1		= bonuses.description1,
	description2		= bonuses.description2,
	price				= bonuses.price,
	payment_period_id	= bonuses.payment_period_id
FROM
	(
		SELECT
			affiliate_id,
			'bonus laatst uitgerekend ' || now()::date AS description1,
			'bonus voor ' || (COUNT(*)/5) * 5 || ' leads' AS description2,
			(COUNT(*)/5)*60 AS price,
			(SELECT MAX(id) FROM payment_period) AS payment_period_id
		FROM
			lead
		WHERE
			lead_program_id = 2929 AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			created >= '2010-10-04'
		GROUP BY
			affiliate_id
	) AS bonuses
WHERE
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 4854 AND
	lead.affiliate_id = bonuses.affiliate_id;
	
END;

/* ID 2960: bij iedere 5 leads 105 e extra. -> 4942 */
BEGIN;

INSERT INTO lead (
	click_id, 
	lead_program_id, 
	description1,
	price, 
	status,  
	referrer, 
	ip_address, 
	user_agent, 
	payment_period_id, 
	affiliate_id, 
	click_created,
	created
)

SELECT
	MAX(click_id) AS click_id,
	 4942 AS lead_program_id,
	 'Nieuwe bonuslead' AS description1,
	 0 AS price,
	 'ACCEPTED'::approval_status AS status,
	 'automatic lead'::text AS referrer,
	 '127.0.0.1'::inet AS ip_address,
	 'inserted by m4n'::text AS user_agent,
	 (SELECT MAX(id) FROM payment_period WHERE processed = false) AS payment_period_id,
	 affiliate_id AS affiliate_id,
	 MAX(click_created) AS click_created,
	 now() - interval '7 hours' 
FROM
	lead
WHERE
	status = 'ACCEPTED' AND
	created >= '2010-11-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2960, 3431, 3432) AND
	NOT EXISTS (
		SELECT
			affiliate_id
		FROM
			lead AS bonus_leads
		WHERE
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			bonus_leads.lead_program_id = 4942 AND
			lead.affiliate_id = bonus_leads.affiliate_id
	)
GROUP BY
	affiliate_id
HAVING
	COUNT(*) >= 5;

UPDATE
	lead
SET
	description1		= bonuses.description1,
	description2		= bonuses.description2,
	price				= bonuses.price,
	payment_period_id	= bonuses.payment_period_id
FROM
	(
		SELECT
			affiliate_id,
			'bonus laatst uitgerekend ' || now()::date AS description1,
			'bonus voor ' || (COUNT(*)/5) * 5 || ' leads' AS description2,
			(COUNT(*)/5)*105 AS price,
			(SELECT MAX(id) FROM payment_period) AS payment_period_id
		FROM
			lead
		WHERE
			lead_program_id  IN (2960, 3431, 3432) AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			created >= '2010-11-01'
		GROUP BY
			affiliate_id
	) AS bonuses
WHERE
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 4942 AND
	lead.affiliate_id = bonuses.affiliate_id;
	
END;

/* ID 3302: bij iedere 5 leads 105 e extra. -> 4941 */
BEGIN;

INSERT INTO lead (
	click_id, 
	lead_program_id, 
	description1,
	price, 
	status,  
	referrer, 
	ip_address, 
	user_agent, 
	payment_period_id, 
	affiliate_id, 
	click_created,
	created
)

SELECT
	MAX(click_id) AS click_id,
	 4941 AS lead_program_id,
	 'Nieuwe bonuslead' AS description1,
	 0 AS price,
	 'ACCEPTED'::approval_status AS status,
	 'automatic lead'::text AS referrer,
	 '127.0.0.1'::inet AS ip_address,
	 'inserted by m4n'::text AS user_agent,
	 (SELECT MAX(id) FROM payment_period WHERE processed = false) AS payment_period_id,
	 affiliate_id AS affiliate_id,
	 MAX(click_created) AS click_created,
	 now() - interval '7 hours' 
FROM
	lead
WHERE
	status = 'ACCEPTED' AND
	created >= '2010-11-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (3302, 3433, 3434) AND
	NOT EXISTS (
		SELECT
			affiliate_id
		FROM
			lead AS bonus_leads
		WHERE
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			bonus_leads.lead_program_id = 4941 AND
			lead.affiliate_id = bonus_leads.affiliate_id
	)
GROUP BY
	affiliate_id
HAVING
	COUNT(*) >= 5;

UPDATE
	lead
SET
	description1		= bonuses.description1,
	description2		= bonuses.description2,
	price				= bonuses.price,
	payment_period_id	= bonuses.payment_period_id
FROM
	(
		SELECT
			affiliate_id,
			'bonus laatst uitgerekend ' || now()::date AS description1,
			'bonus voor ' || (COUNT(*)/5) * 5 || ' leads' AS description2,
			(COUNT(*)/5)*105 AS price,
			(SELECT MAX(id) FROM payment_period) AS payment_period_id
		FROM
			lead
		WHERE
			lead_program_id IN (3302, 3433, 3434) AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			created >= '2010-11-01'
		GROUP BY
			affiliate_id
	) AS bonuses
WHERE
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 4941 AND
	lead.affiliate_id = bonuses.affiliate_id;
	
END;

/* November 20 2009, Jan, ticket #4280
Reported by Bart:
Kan jij bij OHRA (7112) alle leads die binnen komen voor moneymiljonair (307) en zinngeld (5575) die binnen komen op leadpr. 1581 doorsturen naar 3655
Per 1 november, ook voor de gezette leads dus.
*/
UPDATE
	lead
SET
	lead_program_id = 3655
WHERE
	lead_program_id = 1581 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (307, 5575)	AND
	created >= '2009-11-01';

/* November 6 2009, Dineke:
Reported by Bart:
Kan jij alle leads van Homefinance (9897) die binnen komen bij OHRA (7112) op leadprogramma 3501 (lijfrente) doorschuiven naar 3560 (lijfrente special deal)?
*/
UPDATE
	lead
SET
	lead_program_id = 3560
WHERE
	lead_program_id = 3501 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 9897;


/* October 7 2009, Dineke, ticket #4015: new staffel Ohra
Reported by Bart:
Kan jij voor OHRA (7112) twee staffels bouwen

Het gaat om
Uitvaartverzekering
(ID 3302) 0-10 sales (hoofdprogramma)
(ID 3433) 11-20 sales
(ID 3434) >20 sales

Overlijdensrisicoverzekering
(ID 2960) 0-10 sales (hoofdprogramma)
(ID 3431) 11-20 sales
(ID 3432) > 20 sales

Zou jij daarnaats alle sales van ID 2932 op 3302 laten landen?
*/
-- all sales from 2932 go to 3302
UPDATE
	lead
SET
	lead_program_id = 3302
WHERE
	lead_program_id = 2932 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
-- Uitvaartverzekering: 11-20 sales --> 3433
UPDATE
	lead
SET
	lead_program_id = 3433
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3302) AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (3302, 3433, 3434) AND 
 												status = 'ACCEPTED' AND
 												payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 20);
 										
-- Uitvaartverzekering: > 20 sales --> 3434
UPDATE
	lead
SET
	lead_program_id = 3434
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3302, 3434) AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (3302, 3433, 3434) AND 
 												status = 'ACCEPTED' AND
 												payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) > 20);
 										
-- Overlijdensrisicoverzekering: 11-20 sales --> 3431
UPDATE
	lead
SET
	lead_program_id = 3431
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (2960) AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (2960, 3431, 3432) AND 
 												status = 'ACCEPTED' AND
 												payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 20);
	
-- Overlijdensrisicoverzekering: > 20 sales --> 3432
UPDATE
	lead
SET
	lead_program_id = 3432
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (2960, 3431) AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (2960, 3431, 3432) AND 
 												status = 'ACCEPTED' AND
 												payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) > 20);
