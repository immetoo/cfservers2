/* July 27th 2010, Jan, ticket: #5578
Aanvrager: Fleur
Adverteerder: BungalowS.nl
ID Adverteerder: 13539

Welk type staffel is het (maak 1 keuze)?
Special deal

Affiliate:  info2@tndmedia.nl 11976

Wat moet er precies gebeuren?
Affiliate krijgt standaard de hogere staffel (3865)

Startdatum: 23-7-2010
Einddatum: 23-10-2010
*/
UPDATE
	lead
SET
	lead_program_id = 3865
WHERE
	lead_program_id IN (2901, 2904, 2905) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11976 AND
	created >= '2010-07-23' AND
	created < '2010-10-23';


/* April 29 2010, Dineke Ticket #4916:
 * Aanvrager: Fleur

Welk type staffel is het (maak 1 keuze)?
Special deal

Affiliate:  hansrinsma (5133)
            caroline (8480)

Wat moet er precies gebeuren?
Affiliates krijgt standaard de hogere staffel (3865)

Startdatum: 28-4-2010
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 3865
WHERE
	lead_program_id IN (2901, 2904, 2905) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (5133, 8480) AND
	created > '2010-04-28';



/* June 10 2010, Dineke, #5318
Aanvrager: Wouter

Exploitanten (in geval van special deal. Username + id):
EuroNovo (11684)

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 2901 > 2905

Wat moet er precies gebeuren?

Leads komen binnen op 2901 en moeten naar 2905, tenzij reguliere staffel van 75 of meer wordt behaald (lpid 3865)

Startdatum: 01-07-2010
Einddatum: 31-08-2010
*/
UPDATE
	lead
SET
	lead_program_id = 2905
WHERE
	lead_program_id IN (2901, 2904) AND
	affiliate_id IN (11684) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-07-01' AND '2010-09-01';

/* July 14th 2010, Jan, ticket: #5525
Aanvrager: Wouter

Exploitanten (in geval van special deal. Username + id):
Eggplant > 11825

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Wat moet er precies gebeuren?
Leads komen binnen op 2901 en moeten naar 2905, tenzij reguliere staffel van 75 of meer wordt behaald (lpid 3865)

Startdatum: 01-07-2010
Einddatum: 31-10-2010
*/
UPDATE
	lead
SET
	lead_program_id = 2905
WHERE
	lead_program_id IN (2901, 2904) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11825 AND
	created >= '2010-07-01' AND
	created < '2010-10-31';

/* February 18 2010, Dineke, #
 * Aanvrager: Wouter

Adverteerder: BungalowS.nl
ID Adverteerder: 13539

Exploitanten (in geval van special deal. Username + id): 
ton.vandenhoogen@iid.nl > 7743
cadeau > 6429
dovest > 17214
info2@tndmedia.nl > 11976

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):  2901 > 2905

Wat moet er precies gebeuren?

Leads komen binnen op 2901 en moeten naar 2905, tenzij reguliere staffel van
75 of meer wordt behaald (lpid 3865)

Startdatum: 01-02-2010
Einddatum: 31-03-2010
 */

UPDATE
	lead
SET
	lead_program_id = 2905
WHERE
	lead_program_id IN (2901, 2904) AND
	affiliate_id IN (7743, 6429, 17214, 11976) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-02-01';

/** Ticket#2783: 27 April 2009, Andre: Echte Staffel. **/
/** Ticket#2783: 11-40 sales goes from 2901 to 2904. */
UPDATE
	lead 
SET
	lead_program_id = 2904
WHERE
	lead_program_id = 2901 AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id in (2901, 2904) AND 		
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
    GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 40
	);

/** For 41 up to 75 sales or more goes from (2901, 2904) to 2905  **/
UPDATE lead
SET lead_program_id = 2905
WHERE
	lead_program_id IN (2901, 2904) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id IN (2901, 2904, 2905) AND 		  
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 41 AND 75
	);

	/** More than 75 sales the leads are promoted to 3865 **/
UPDATE
	lead
SET
	lead_program_id = 3865
WHERE
	lead_program_id IN (2901, 2904, 2905) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id IN (2901, 2904, 2905, 3865) AND 	
		click_created < '2011-01-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
    GROUP BY affiliate_id HAVING COUNT(id) > 75
	);