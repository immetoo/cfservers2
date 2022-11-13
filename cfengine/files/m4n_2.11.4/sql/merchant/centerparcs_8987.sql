/*November 22 2010, Dineke, #6319:
 * Aanvrager:Wouter 
 * Leads van BeverlyHills? (19610) en MoneyMiljonair? (307) en Mailcollect (21505) naar lpid 3309. 
 * November 24 2010, Dineke, #6329:
 * Same deal also for:	5486      Martijn Pronk (Doublepoints)
						11970    Ladymail
 * Startdatum: 22/11/2010 Einddatum: 30/01/2011 */
UPDATE
	lead
SET
	lead_program_id = 3309
WHERE
	lead_program_id IN (SELECT lead_programs(8987)) AND lead_program_id != 3309 AND
	affiliate_id IN (19610, 307, 21505, 5486, 11970) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-11-22' AND '2011-01-31';
		
/* September 16 2010, Dineke #5912:
 * Aanvrager: Wouter S.
Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):
Lpid 3918

Wat moet er precies gebeuren?
Boekingen die zijn gemaakt via onderstaande adid’s mogen naar Lpid 3918, ongeacht parkafkorting in descr. 2
* 447856
* 447750
* 447742
* 680019
* 680104
Startdatum: 16-09-2010
Einddatum (t/m): 30-09-2010
 */
UPDATE
	lead
SET
	lead_program_id = 3918
FROM
	click
WHERE
	lead.created BETWEEN '2010-09-16' AND '2010-10-01' AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT lead_programs(8987)) AND lead_program_id != 3918 AND
	click_id = click.id AND
	advertisement_id IN (447856, 447750, 447742, 680019, 680104);

/*August 20 2010, Dineke #5720
Aanvrager: Wouter
Autoapprove all leads that are 10 days old and older
*/
UPDATE
	lead
SET
	status = 'ACCEPTED'
WHERE
	lead_program_id IN (SELECT lead_programs(8987)) AND
	created < now() - INTERVAL '10 days' AND
	status = 'TO_BE_APPROVED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* April 23 2010, Dineke #4879
Aanvrager: Wouter

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 

Wat moet er precies gebeuren?

Alle boekingen  naar lpid 3918. Special deal met 2% extra bij specifiek park dus uitschakelen svp en boekingen die handmatig naar 1,5% vergoeding (lpid 3667) worden gezet overrulen de lpid 3918 special deal

Startdatum: 22/04/2010
Einddatum: t/m 29/04/2010*/
UPDATE
	lead
SET
	lead_program_id = 3918
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 8987 AND lead_program_id != 3667) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-04-22' AND '2010-04-30';
	
/* September 29 2009, Dineke: special deal: info2@tndmedia.nl always gets at least 3308 */
--March 25 2010, Dineke: this affiliate temporarily gets a higher reward (see below), so this one can run again after May 16th
UPDATE
	lead
SET
	lead_program_id = 3308
WHERE
	affiliate_id = 11976 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 3307 AND
	created > '2010-05-16';

	
/* #4751: March 25 2010, Dineke 
Aanvrager:Wouter
Adverteerder: Center Parcs
ID Adverteerder: 8987

Exploitanten (in geval van special deal. Username + id):  info2@tndmedia.nl (11976)

Special deal

Wat moet er precies gebeuren?

Leads van  info2@tndmedia.nl (11976) naar lpid 3309.

Startdatum: 15/03/2010
Einddatum: 15/05/2010
*/
UPDATE
	lead
SET
	lead_program_id = 3309
WHERE
	affiliate_id = 11976 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 3307 AND
	created BETWEEN '2010-03-15' AND '2010-05-16';
	
/* Special Deal for list of affiliates, they get lead_program_id 3309:
mathijs						7035
reizenpaleis				8149
Roas						3421
ton.vandenhoogen@iid.nl 	7743
trader						11033
Thomas25					5673
gratiskortingscode			12903
qincqinc 					630
cadeau						6429
Dovest						17214
Mats						17934 --> added April 6th
*/
UPDATE
	lead
SET
	lead_program_id = 3309
WHERE
	lead_program_id = 3307 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (7035, 8149, 3421, 7743, 11033, 5673, 12903, 630, 6429, 17214, 17934);

/* December 10, 2009, Jan, ticket: #4372
Aanvrager: Wouter

Exploitanten (in geval van special deal. Username + id): Euronovo (11684)

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
Binnenkomende leads voor EuroNovo moeten naar lpid 3722
Deze special deal wordt overruled door incentives met hogere percentages (Bijvoorbeeld lpid 3319)

Startdatum: 01/12/2009
Einddatum: 01/12/2011
*/
UPDATE
	lead
SET
	lead_program_id = 3722
WHERE
	lead_program_id IN (3307, 3309) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11684 AND
	created >= '2009-12-01' AND
	created < '2011-12-01';
	 
/* November 30, 2009, Jan, ticket: #4312
Aanvrager: Wouter

Exploitanten (in geval van special deal. Username + id): lysander (10929)

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 3307 > 3309

Wat moet er precies gebeuren?
Sales die binnenkomen op 3307 verplaatsen naar 3309.

Startdatum: 01/11/´09
Einddatum: 01/11/’11
*/

UPDATE
	lead
SET
	lead_program_id = 3309
WHERE
	lead_program_id IN (3307) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 10929 AND
	created >= '2009-11-01' AND
	created < '2011-11-01';
	
/* July 14th 2010, Jan, ticket: #5524
Aanvrager: Wouter

Exploitanten (in geval van special deal. Username + id):
Vakantieparken.nl (16709)
spanje.nl (8897)

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Wat moet er precies gebeuren?
Leads van Vakantieparken.nl (16709) en spanje.nl (8897)naar lpid 3309.

Startdatum: 01/06/2010
Einddatum: 01/06/2012
*/
UPDATE
	lead
SET
	lead_program_id = 3309
WHERE
	lead_program_id IN (3482, 3307, 3308) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (8897, 16709) AND 
	created >= '2010-06-01' AND
	created < '2012-06-01'; 

/* Ticket #5669, Dineke, August 11 2010,
 * Requested by Fleur: same special deal for affiliate aptiepag (3571), starting August 1st
 */
UPDATE
	lead
SET
	lead_program_id = 3309
WHERE
	lead_program_id IN (3482, 3307, 3308) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (3571) AND 
	created > '2010-08-01';
	
/* Echte staffel

Lead program: 3307 > 3482
			              > 3308 > 3309

Wat moet er precies gebeuren?
0-2 sales per maand = 3% (lpid 3482)
3 - 9 sales per maand	= 4% (lpid 3307)
10 - 24 sales per maand = 5% (lpid 3308)
> 25 sales per maand	= 6% (lpid 3309)

Special deals overrulen deze staffel

Startdatum: 01/10/2009
Einddatum: 01/10/2011
*/

UPDATE
	lead
SET
	lead_program_id = 3482
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3307) AND
 	click_created < '2011-01-01' AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (3482, 3307, 3308, 3309, 3319) AND 
 											status = 'ACCEPTED' AND
 												click_created < '2011-01-01' AND
 											payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 0 AND 2);

UPDATE
	lead
SET
	lead_program_id = 3307
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3482, 3307) AND
 		click_created < '2011-01-01' AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (3482, 3307, 3308, 3309, 3319) AND 
 											status = 'ACCEPTED' AND
 												click_created < '2011-01-01' AND
 											payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 3 AND 9);
UPDATE
	lead
SET
	lead_program_id = 3308
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3482, 3307) AND
 		click_created < '2011-01-01' AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (3482, 3307, 3308, 3309, 3319) AND 
 											status = 'ACCEPTED' AND
 												click_created < '2011-01-01' AND
 											payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 10 AND 24);

UPDATE
	lead
SET
	lead_program_id = 3309
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3482, 3307, 3308) AND
 		click_created < '2011-01-01' AND
 	affiliate_id IN 
 		(SELECT affiliate_id FROM lead WHERE lead_program_id IN (3482, 3307, 3308, 3309, 3319) AND 
 											status = 'ACCEPTED' AND
 												click_created < '2011-01-01' AND
 											payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
 										GROUP BY affiliate_id HAVING COUNT(id) >= 25);

/* #6670:
January 31 2011, Dineke:
Requested by Liesbeth, January 27 2011:

Hoi Jan,

Zou jij voor de sales die in Februari binnenkomen bij Centerparcs en in beschrijving 2 HB, KV of EH hebben staan, deze in lp 3567 laten vallen?
Vanaf Maart moeten deze sales dus weer in het reguliere programma vallen. Dankje! Met vriendelijke groet,

Liesbeth Coopmans

Lead programma's ID of advertentie ID (oud en nieuw):  
3567
*/
UPDATE
	lead
SET
	lead_program_id =	3567
WHERE
	lead_program_id IN (SELECT lead_programs(8987)) AND lead_program_id != 3567 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2011-02-01' AND '2011-03-01' AND
	(description2 LIKE '%HB%' OR description2 LIKE '%ZV%' OR description2 LIKE '%EH%');
