/* September 1 2010, Jan, ticket: #5810
Aanvrager: liesbeth

Adverteerder: Plutosport
ID Adverteerder: 4385

Exploitanten (in geval van special deal. Username + id):

Onlinefashion (id 8174)

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):  
lp 4777

Wat moet er precies gebeuren?
Alle sales van Onlinefashion moeten per 6 september in lp 4777 vallen

Startdatum: 6 september
Einddatum: /
*/
UPDATE
	lead
SET
	lead_program_id = 4777
WHERE
	lead_program_id IN (814, 1315, 1316, 4770) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id = 8174 AND
	created >= '2010-09-06';


/* June 9 2010, Jan, ticket: #5163
Plutosport (id 4385) aan lpid 1316 (standaard hoogste staffel), voor affiliate zwemkleding.nl (id 17860) en affiliate 9181
*/
UPDATE
	lead
SET
	lead_program_id = 1316
WHERE
	lead_program_id IN (814, 1315) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id IN (17860, 9181) AND
	created >= '2010-06-01';

/* April 16 2009, Dineke:
special deal for a group of affiliates: Leadprogramma id 2878 10% voor de affiliate.
De volgende affiliates dienen standaard aan dit leadprogramma toegevoegd te worden.:
Winkelpower= 52
Startveld=774
Sportyschoenen=10184
Welovesites=9070
Fashionchick= 8880
Onlinepostorders=3893
Teamers.nl= 13229
Thanx!
NOTE: Startveld, Fashionchick, Welovesites and Onlinepostorders are also in the nosearch shared staffel
	  below.
	  Because this deal is calculated first these affiliates won't contribute to the shared staffel!
*/

UPDATE lead
	SET lead_program_id = 2878
	WHERE lead_program_id IN (814, 1315, 1316) AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		affiliate_id IN (52, 774, 10184, 9070, 8880, 3893, 13229);
		
/**update more than 7 sales**/
UPDATE 
	lead 
SET 
	lead_program_id = 1315
WHERE 
	lead_program_id IN (814) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created < '2010-09-06' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (814, 1315,1316) AND
		status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		created < '2010-09-06' 
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 8 AND 20
	);
	
/**update more than 20 sales**/
UPDATE 
	lead 
SET 
	lead_program_id = 1316
WHERE 
	lead_program_id IN (814, 1315) AND 
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created < '2010-09-06' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE 
		lead_program_id IN (814,1315,1316) AND 
		status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		created < '2010-09-06'
	GROUP BY affiliate_id HAVING COUNT(id) > 20 
	);

/* August 30 2010, Jan, ticket: #5776
Ik vroeg me af of de staffel veranderd kan worden. Graag zie ik de volgende aanpassing

Lead ID 814  -> 0-20 leads
Lead ID 1315 -> 20-50 leads
Lead ID 1316 -> 50-99 leads
Lead ID 4770 -> 100> leads

Ingangsdatum 1 september 2010
Update September 1 2010, Jan, Changed start date for new staffel
*/

/* Lead ID 1315 -> 20-50 leads */
UPDATE 
	lead 
SET 
	lead_program_id = 1315
WHERE 
	lead_program_id IN (814) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-09-06' AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (814, 1315, 1316, 4770) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			created >= '2010-09-06' 
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 20 AND 49
	);
	
/* Lead ID 1316 -> 50-99 leads */
UPDATE 
	lead 
SET 
	lead_program_id = 1316
WHERE 
	lead_program_id IN (814, 1315) AND 
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-09-06' AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (814, 1315, 1316, 4770) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			created >= '2010-09-06' 
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 50 AND 99
	);

/* Lead ID 4770 -> 100> leads */
UPDATE 
	lead 
SET 
	lead_program_id = 4770
WHERE 
	lead_program_id IN (814, 1315, 1316) AND 
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-09-06' AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (814, 1315, 1316, 4770) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			created >= '2010-09-06' 
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 100
	);
	
/** March 3 2009, Dineke

Aanvrager: Liesbeth
Adverteerder: Plutosport ID Adverteerder: 4385

Exploitanten: No Search, oftwel de volgende accounts 
AEM SEA account (3144) ELF Snijder (6059) Elise (9076) Erotiek (5223) Fashionchick.nl (8880)
 GSM-Guru (4322) Kittie (9070) Kleding-goedkoop.nl (4996) Postorderaars.nl (3893) 
 Sportyschoenen.nl (10184) Startkabeldochters (710) Startveld-GSM/PC (6019) Studie.fm (4382) 
 toppers (9405) VakantieBoyz? (5087) Viastart.nl (2160) welovewinter (9404) www.Startveld.nl (774) 
 XXLmaten (8582) Zoeka.nl (6581) Welovesites (9070)

Welk type staffel is het? 1) Echte staffel

Lead programma's ID of advertentie ID (oud en nieuw): 814, 1315 en 1316.

Wat moet er precies gebeuren? De staffel moet samen gelden voor alle accounts van No Search.

Startdatum: asap Einddatum: /
**/
/**update 8 up to 19 sales**/
UPDATE lead SET lead_program_id = 1315
	WHERE lead_program_id IN (814) AND 
		affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
		status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		(SELECT COUNT(*) FROM lead WHERE lead_program_id IN (814, 1315, 1316) AND
										status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)
		) BETWEEN 8 AND 20;
		
/**update more than 20 sales**/
UPDATE lead SET lead_program_id = 1316
	WHERE lead_program_id IN (814, 1315) AND 
		affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
		status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		(SELECT COUNT(*) FROM lead WHERE lead_program_id IN (814, 1315, 1316) AND
										status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)
		) > 20;
		