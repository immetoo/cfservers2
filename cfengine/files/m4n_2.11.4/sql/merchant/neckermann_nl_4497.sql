/* February 21 2011, Jan
Test for Neckermann approval script on the DEV environment.
*/
UPDATE
	lead
SET 
	status = 'ACCEPTED'
FROM 
	(
		SELECT 
			description1, ip_address
		FROM 
			lead 
		WHERE 
			lead_program_id IN (4974, 4975, 4976) AND 
			status != 'BLOCKED'
		GROUP BY 
			description1, ip_address
		HAVING 
			SUM(price) < 500 AND
			MAX(payment_period_id) IN (SELECT id FROM payment_period where processed = false)
	) AS elligible_leads
WHERE 
	lead_program_id IN (4974, 4975, 4976) AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	elligible_leads.description1 = lead.description1 AND
	elligible_leads.ip_address = lead.ip_address AND 
	status = 'TO_BE_APPROVED';

/* February 2 2011, Jan, ticket: #6686
Graag een special deal aanmaken voor Besteconsumentkoop (9181) en Neckermann.com (4497)
Leads die Besteconsumentenkoop zet voor Nekckermann mogen in lead ID 6210

Ingangsdatum: 1 februari 
*/

UPDATE
	lead
SET
	lead_program_id = 6210
WHERE
	lead_program_id IN (834, 3050, 2356) AND
	affiliate_id = 9181 AND
	created >= '2011-02-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

--UPDATE lead SET status = 'ACCEPTED' WHERE status = 'TO_BE_APPROVED' AND lead_program_id = 834 AND price < 500.0;

UPDATE lead SET status = 'ON_HOLD' WHERE status = 'TO_BE_APPROVED' AND lead_program_id = 834 AND price > 500.0;

/* October 15th, Jan, ticket: #6049
Hierbij een aanvraag voor special deal.
Adverteerder: 4497 neckermann
Affiliate: 12307 shopkorting

-        834 standaard
-        3050 bij 300 tot 400 Sales (bruto)
-        2356 bij 400 of meer Sales bruto

Indien affiliate eenmaal de desbetreffende target heeft behaald moet hij in deze staffel blijven.
*/
UPDATE
	lead
SET
	lead_program_id = 3050
WHERE
	lead_program_id = (834) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (834, 3050, 2356) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
			affiliate_id = 12307
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) BETWEEN 300 AND 399
	);

	
UPDATE
	lead
SET
	lead_program_id = 3050
WHERE
	lead_program_id = (834) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (834, 3050, 2356) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
			affiliate_id = 12307
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 400
	);
/* June 9 2010, Jan, ticket: #5311
Special deal voor Kortingkorting(8420) starting 09-06-2010 -> 2356
*/
UPDATE
	lead
SET
	lead_program_id = 2356
WHERE
	lead_program_id = 834 AND
	affiliate_id = 8420 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-06-09';

/* Special deal for affiliate Lysander */
UPDATE lead 
	SET lead_program_id = 2356
	WHERE lead_program_id = 834 AND 
		affiliate_id = 10929 AND
		status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* January 11 2010, Jan, ticket: #4456
Aanvrager: Jesse le Grand
Exploitanten (in geval van special deal. Username + id): fkasbergen 11745

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
From: 834 to: 3050

Wat moet er precies gebeuren?
Alle sales van expl. 11745 moeten op lpid 3050 worden gezet.

Startdatum: 11-01-10
Einddatum: geen
*/
UPDATE
	lead
SET
	lead_program_id = 3050
WHERE
	lead_program_id = 834 AND
	affiliate_id = 11745 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-01-11';

/* January 27 2010, Jan, ticket: #4507
Aanvrager: Jesse le Grand
Exploitanten (in geval van special deal. Username + id): DMG01 14878

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
From: 834 to: 3050

Wat moet er precies gebeuren?
Alle sales van aid 14878 moeten op lpid 3050 worden gezet.

Startdatum: 27-01-10
Einddatum: geen
*/

UPDATE
	lead
SET
	lead_program_id = 3050
WHERE
	lead_program_id = 834 AND
	affiliate_id = 14878 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-01-27';

/* July 22nd 2010, Jan, ticket: #5571
Aanvrager: Jesse le Grand
Kun jij voor klant 4497 alle Sales die binnen komen op affliate ID 5575 op LPID 3050 zetten?
*/

UPDATE
	lead
SET
	lead_program_id = 3050
WHERE
	lead_program_id = 834 AND
	affiliate_id = 5575 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-07-22';
	
/**
* Feb 10 2009: Special deal for affiliate-ids from No Search
* March 30 2009: No more quotum for No Search: they always get the special deal.

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
Welovesites (9070)

**/

UPDATE lead SET lead_program_id = 2356
	WHERE lead_program_id = 834 AND 
		affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
		status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		;
		
/* September 15 2009, Dineke:
add staffel to nosearch as follows:
750 - 999 leads together? --> lpid 3316
1000 leads and up? --> lpid 3317
*/

UPDATE lead SET lead_program_id = 3316
	WHERE lead_program_id = 2356 AND 
		affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		(SELECT COUNT(*) FROM lead WHERE lead_program_id IN (2356, 3316, 3317) AND
										status = 'ACCEPTED' AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)
		) BETWEEN 750 AND 999;
		
UPDATE lead SET lead_program_id = 3317
	WHERE lead_program_id IN (2356, 3316) AND 
		affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
		status = 'ACCEPTED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		(SELECT COUNT(*) FROM lead WHERE lead_program_id IN (2356, 3316, 3317) AND
										status = 'ACCEPTED' AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)
		) > 1000;

/* 26 juni 2009, Dineke:
 Zou je offerid 3050 kunnen koppelen aan Moneymiljonair (id 307).
 Per wanneer? per 27 juni */
UPDATE
	lead
SET
	lead_program_id = 3050
WHERE
	created > '2009-06-27' AND
	affiliate_id = 307 AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 4497 AND id != 3050) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* April 20 2010, Jan, ticket: #4852
Aanvrager: paul vogelzang	
Exploitanten (in geval van special deal. Username + id): fgielen id 6305

Welk type staffel is het (maak 1 keuze)?
2) Special deal3050

Lead programma's ID of advertentie ID (oud en nieuw):  oud 3050

Wat moet er precies gebeuren?
fgielen moet standaard in het leadprogramma 3050 vallen, 4%

Startdatum: per direct
Einddatum: -
*/
UPDATE
	lead
SET
	lead_program_id = 3050
WHERE
	created > '2010-04-20' AND
	affiliate_id = 6305 AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 4497 AND id != 3050) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);	
	
/* September 10 2010, Jan, ticket: #5889
Zou jij voor account 8639 (Fourpeople) de volgende special deals kunnen regelen?

Neckermann (id 4497): aan lp 3050 koppelen
*/
UPDATE
	lead
SET
	lead_program_id = 3050
WHERE
	created >= '2010-09-10' AND
	affiliate_id = 8639 AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 4497 AND id != 3050) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);	

/* 27 August 2009, Dineke:
Reported by Jesse:
Zou je de Affiliate 10929 bij Neck 4497 kunnen koppelen op offid 3269 per 1 september?
*/
UPDATE
	lead
SET
	lead_program_id = 3269
WHERE
	created > '2009-09-01' AND
	affiliate_id = 10929 AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 4497 AND id != 3269) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);