/* March 16 2010, Jan, ticket: #4715
Aangevraagd door: Dianne

Kun jij het ID van affiliate Wilpair: 550  koppelen aan het ID van het leadprogramma van de adverteerder Shoemixx: 4068
*/

UPDATE
	lead
SET
	lead_program_id = 4068
WHERE 
	lead_program_id = 2028 AND
	affiliate_id = 550 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
/* May 8 2009, Dineke:
special deal for affiliate voordelengids.eu (11979) */
UPDATE lead SET lead_program_id = 2943
	WHERE lead_program_id = 2028 AND
			affiliate_id = 11979 AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* November 9 2009, Dineke:
Reported by Liesbeth: Special deal for affiliate Affiliatemeester (7143): they always get lead_program 3578 */
UPDATE
	lead
SET
	lead_program_id = 3578
WHERE
	lead_program_id = 2028 AND
	affiliate_id IN (7143) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/**
* Feb 10 2008: Special deal Shoemixx for affiliate-ids from No Search

AEM SEA account (3144)
ELF Snijder (6059)
Elise (9076)
Erotiek (5223)
Fashionchick.nl (8880)
GSM-Guru (4322)
Kittie (9070)
Kleding-goedkoop.nl (4996)
Postorderaars.nl (3893)
Sportyschoenen.nl (10184)
Startkabeldochters (710)
Startveld-GSM/PC (6019)
Studie.fm (4382)
toppers (9405)
VakantieBoyz (5087)
Viastart.nl (2160)
welovewinter (9404)
www.Startveld.nl (774)
XXLmaten (8582)
Zoeka.nl (6581) 
Welivesites (9070)

**/

UPDATE lead SET lead_program_id = 2646
	WHERE lead_program_id = 2028 AND 
		affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
		status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		(SELECT COUNT(*) FROM lead WHERE lead_program_id IN (2646, 2028) AND
										status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)
		) > 150;
		
	
/* August 18 2010, Jan, ticket: #5705
Kan een van jullie voor adverteerder Shoemixx (ID  11157) de volgende staffel en special deal aanmaken.

Leadprogramma ID 4754: 10% commissie bij 85+ sales, special deal voor RickdeBruin (ID 14923)
Leadprogramma ID 4755: 10% commissie bij 70+ sales, special deal voor Zwart1 (ID 16384) én CP-Schoenen (ID 12228)
*/

-- Leadprogramma ID 4754: 10% commissie bij 85+ sales, special deal voor RickdeBruin (ID 14923)
UPDATE
	lead
SET
	lead_program_id = 4754
WHERE
	lead_program_id IN (2028, 4576, 4577) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-08-19' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (2028, 4576, 4577, 4754, 4755) AND
			affiliate_id IN (14923) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			created >= '2010-08-19'
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) >= 85
	);
	
-- 	Leadprogramma ID 4755: 10% commissie bij 70+ sales, special deal voor Zwart1 (ID 16384) én CP-Schoenen (ID 12228)
UPDATE
	lead
SET
	lead_program_id = 4755
WHERE
	lead_program_id IN (2028, 4576, 4577) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-08-19' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (2028, 4576, 4577, 4754, 4755) AND
			affiliate_id IN (12228, 16384) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			created >= '2010-08-19'
		GROUP BY
			affiliate_id
		HAVING
			COUNT(*) >= 70
	);