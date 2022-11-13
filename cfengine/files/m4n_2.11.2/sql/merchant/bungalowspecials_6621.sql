/* January 2011, Dineke, #6547:
 * Aanvrager: Camiel
 * Exploitanten: DijkICT - 10557
 * Special deal 
Alle binnenkomende leads overzetten van lpid 1068 naar lpid 6164
*/
UPDATE
	lead
SET
	lead_program_id = 6164
WHERE
	lead_program_id = 1068 AND
	affiliate_id = 10557 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2011-01-13';

/* September 13 2010, Dineke, #5892:
 * Aanvrager: Wouter S.
==Correction to deal below, which didn't work==
Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):

Wat moet er precies gebeuren?

Leads voor  info2@tndmedia.nl (11976) moeten naar lpid 4719
Startdatum: 25-08-‘10
Einddatum: 25-08-‘12
*/

/* August 12, Dineke, Ticket #5686:
Aanvrager: Fleur

Special deal

Exploitanten (in geval van special deal. Username + id):
info2@tndmedia.nl (11976)

Wat moet er precies gebeuren?
Standaard starten in hoogste staffel:
1068 à 4719

Startdatum: 12-8-2010
Einddatum: NVT
*/
UPDATE	
	lead
SET
	lead_program_id = 4719
WHERE
	affiliate_id = 11976 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (1068, 2114) AND
	created > '2010-08-12';
	
/*Staffel bungalowspecials: ticket 1855 */

/** 17 December 2008, Dineke: reject leads by priceboy (6404) **/
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	affiliate_id = 6404 AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  AND
	lead_program_id = 1068;	

/** November 26, 2009, Jan, ticket #4305
 Aanvrager: Fleur 
 Welk type staffel is het (maak 1 keuze)?
 2)Special deal 

 Exploitanten (in geval van special deal. Username + id): 13856 kdazl

 Wat moet er precies gebeuren?
 Standaard starten in hoogste staffel: 2114 ( ipv 1068)

 Startdatum: 1-11-2009
 Einddatum: NVT 
**/
UPDATE 
	lead 
SET 
	lead_program_id = 2114
WHERE
	lead_program_id IN (1068, 2119, 2120, 2121)  AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 13856 AND
	created >= '2009-11-01';
	
/** April 22 2009, Dineke, ticket # 2748:
 Aanvrager:Fleur
 Adverteerder: Bungalowspecials (6621)

 Exploitanten (in geval van special deal. Username + id): caroline (8480)
 Welk type staffel is het (maak 1 keuze)?
 2) Special deal

 Lead programma's ID of advertentie ID (oud en nieuw): oud:1068
 nieuw:2114

 Alle leads van affiliate (8480) moeten standaard gekoppeld worden aan 2114

 Startdatum: 15-4-2009
 Einddatum: 15-4-2011
**/
UPDATE lead SET lead_program_id = 2114
WHERE
	lead_program_id = 1068 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 8480 AND
	created BETWEEN '2009-04-15' AND '2011-04-15';
	
/** Special deal for affiliates 3421, 11684 separate from staffels

	-23 January 2009, Dineke: add roas (3421) and euronovo (11684) to this deal
	but only starting from the first of january (lead time) 
	
    -14 July 2009, Updated by Andre. Cesta for ticket: https://svn.mbuyu.nl/projects/m4n/ticket/3200

	- August 28 2009, Dineke Correction: #3740 (reported by Wouter): moved affiliate info2@tndmedia to this deal
**/
UPDATE
    lead 
SET 
    lead_program_id = 2114
WHERE 
	lead_program_id = 1068 AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  AND
	affiliate_id IN (3421, 11684);
	
/* August 2 2010, Jan, ticket: #5627
Aanvrager: Fleur
Welk type staffel is het (maak 1 keuze)?
2)Special deal

Exploitanten (in geval van special deal. Username + id):  hansrinsma (5133)

Wat moet er precies gebeuren?
Standaard starten in hoogste staffel:
1068 à 3092

Startdatum: 26-7-2010
Einddatum: NVT
*/
	
UPDATE 
    lead 
SET 
    lead_program_id = 3092
WHERE 
	lead_program_id = 1068 AND
	affiliate_id = 5133 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
/**
   Ticket: https://svn.mbuyu.nl/projects/m4n/ticket/3200
   2009-07-14 Andre Cesta
   Special deal for affiliate qincqinc (630)
**/
UPDATE 
    lead 
SET 
    lead_program_id = 3092
WHERE 
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  AND
	affiliate_id IN (630) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 6621) AND
	created BETWEEN '2009-07-01' AND '2012-07-01';

/** 23 January Dineke: Affiliate uw.vanderbeek@iid.nl (7743) is always gold *

*** 11 february 2009, Dineke: as of 11 february 2009, affiliate Trader (11033) is also always gold *

*** Ticket #2694. Andre Cesta. Special deal for affiliate jeskes 848.

*** August 4 2009, Dineke, Ticket #3625: add affiliate 11976 (info2@tndmedia.nl) to deal
	August 28 2009, Dineke Correction: #3740: moved affiliate to deal with lead_program 2114
*/
UPDATE 
	lead 
SET 
	lead_program_id = 2121
WHERE 
	lead_program_id = 1068 AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  AND
	affiliate_id IN (848, 7743, 11033);

/** Staffel: bronze for 11 up to 40 sales **/
UPDATE 
    lead
SET 
    lead_program_id = 2119
WHERE 
	lead_program_id IN (1068) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE 
		                 lead_program_id IN (1068, 2119, 2120, 2121) AND 
		                 status = 'ACCEPTED' AND
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
	                 GROUP BY 
	                     affiliate_id 
	                 HAVING 
	                     COUNT(id) BETWEEN 11 AND 40
	                 );
	
/** Staffel: silver for 41 up to 74 sales **/
UPDATE 
    lead
SET 
    lead_program_id = 2120
WHERE 
	lead_program_id IN (1068, 2119) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE 
		                 lead_program_id IN (1068, 2119, 2120, 2121) AND 
		                 status = 'ACCEPTED' AND
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	                 GROUP BY 
	                     affiliate_id 
	                 HAVING 
	                     COUNT(id) BETWEEN 41 AND 74
	                 );

/** Staffel: gold for 75 sales and more **/
UPDATE 
	lead 
SET 
	lead_program_id = 2121
WHERE 
	lead_program_id IN (1068, 2119, 2120) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
	                	 lead
	                 WHERE 
		                 lead_program_id IN (1068, 2119, 2120, 2121) AND 
		                 status = 'ACCEPTED' AND 
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)		
	                 GROUP BY 
	                     affiliate_id 
	                 HAVING 
	                     COUNT(id) >= 75
	                 );
	                 

      