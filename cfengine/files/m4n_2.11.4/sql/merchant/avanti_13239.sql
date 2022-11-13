/* June 18 2010, Jan, ticket: #5363
Kun je een special deal maken voor Avantisport ( 13239) en Kortingkorting (8420).
Zijn leads moeten voor avantisport altijd in Lead ID (2834) vallen.
 

Kun je dit per 17 juni in laten gaan. 
*/
UPDATE 
    lead 
SET 
    lead_program_id = 2834
WHERE 
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 13239) AND
	created >= '2010-06-17' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 8420;
/*
 * Ticket #3623.
 * Andre Augusto Cesta.  Avanti Sport.
 * Echte staffel, 3 segments.
 * 2009-08-19 Modified by Andre Cesta according to ticket: https://svn.mbuyu.nl/projects/m4n/ticket/3694
 */
UPDATE 
    lead 
SET 
    lead_program_id = 2833
WHERE 
	lead_program_id IN (2782) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (2782, 2833) AND 
				         status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND 
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 7 AND 15);
 
UPDATE 
    lead 
SET 
    lead_program_id = 2834
WHERE 
	lead_program_id IN (2782, 2833) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT	
	                     affiliate_id
			         FROM 
			             lead
			         WHERE 
			             lead_program_id IN (2782, 2833, 2834) AND 
				         status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND 
				         click_created < '2011-01-01' AND
				         payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
			         GROUP BY affiliate_id HAVING COUNT(id) > 15);
 
 /*
* August 11 2009: Special deal Avanti for affiliate-ids from No Search: they count together

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

2009-08-19 Modified by Andre Cesta according to ticket: https://svn.mbuyu.nl/projects/m4n/ticket/3694
**/

UPDATE lead SET lead_program_id = 2833
	WHERE lead_program_id = 2782 AND 
		affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
		status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		(SELECT COUNT(*) FROM lead WHERE lead_program_id IN (2782, 2833, 2834) AND
										status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)
		) BETWEEN 7 AND 15;
		
UPDATE lead SET lead_program_id = 2834
	WHERE lead_program_id IN (2782, 2833) AND 
		affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
		status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		(SELECT COUNT(*) FROM lead WHERE lead_program_id IN (2782, 2833, 2834) AND
										status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)
		) > 15;
		
		

/* #4721, March 19 2010, Dineke:
 * Aanvrager: Wouter S.

Adverteerder: AvantiSport?
ID Adverteerder: 13239

Exploitanten (in geval van special deal. Username + id): Mats (17934)

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):

Wat moet er precies gebeuren?
Sales standaard naar lpid 2834 (8%)

Startdatum: 15/03/’10
Einddatum: 15/03/2012
*/
--TODO: can be combined with deals below once some time has passed
UPDATE
	lead
SET
	lead_program_id = 2834
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 13239 AND id != 2834) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 17934 AND
	created > '2010-03-15';

		
/**
 * Special deal for affiliates: worldweb1 + 9683 , Caridion + 450, Twenga + 11672, Welovesites + 9070, Mooieaanbieding + 11523, Winkelpower + 52, Shopwiki + 12953
 * Worldweb + 9683, Onlinepostorder + 3893, Albertknol12 + 13243, Onlinefashion + 8174. 
 * Staffel: #3805.
 * Andre Cesta: .
 */
UPDATE 
    lead 
SET 
    lead_program_id = 2834
WHERE 
	lead_program_id IN (2782, 2833) AND
	created > '2009-09-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (9683, 450, 11672, 9070, 11523, 52, 12953, 9683, 3893, 13243, 8174);

	
/**
 * Andre Cesta - 2009-09-28
 * Special deal for affiliate avanti.
 */
UPDATE 
    lead 
SET 
    lead_program_id = 2834
WHERE 
	lead_program_id IN (select id from lead_program where merchant_id = 13239) AND
	created >= '2009-09-28' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 12307;
