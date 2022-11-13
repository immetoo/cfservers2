/* November 1 2010, Dineke #6156:
Aanvrager: Camiel

Exploitanten (in geval van special deal. Username + id): Eric Lang, 5575.
2) Special deal

Alles moet standaard naar hoogste staffel. Lpid: van 1625 -> 2823

Startdatum: 29-10-2010
Einddatum: geen
*/
UPDATE
	lead
SET
	lead_program_id = 2823
FROM
	click
WHERE
	click.id = click_id AND
	lead_program_id = 1625 AND
	lead.affiliate_id = 5575 AND
	lead.payment_period_id IN (SELECT id FROM payment_period where processed = false) AND
	lead.created > '2010-10-29';
	
/* October 26 2010, Dineke, #6128:
Aanvrager: Camiel

Special deal Eric Lang, 22637.
Lead programma's ID of advertentie ID (oud en nieuw): 682420

Wat moet er precies gebeuren?
Alles moet standaard naar hoogste staffel. Lpid: van 1625 -> 2823

Startdatum: 26-10-2010
Einddatum: geen
*/
UPDATE
	lead
SET
	lead_program_id = 2823
FROM
	click
WHERE
	click.id = click_id AND
	lead_program_id = 1625 AND
	lead.affiliate_id = 22637 AND
	lead.payment_period_id IN (SELECT id FROM payment_period where processed = false) AND
	lead.created > '2010-10-26' AND
	advertisement_id = 682420;
	
 /* October 30 2009, Dineke: DO NOT MOVE DOWN! This deal must precede the next.
	per 1 november: requested by Fleur:
	Special deal affiliate chvlieg (14531): all leads from lpid 1625 are promoted to lpid 3505
*/
/* January 26 2010, Dineke:
Aanvrager: Fleur

Adverteerder: Vliegfabriek.nl
ID Adverteerder: 9970
 
Welk type staffel is het (maak 1 keuze)?
2)Special deal

Exploitanten (in geval van special deal. Username + id):8737 MijnAlbum

Wat moet er precies gebeuren?
Standaard in de hoogste staffel in alle categorien dus altijd lpid= 3505, same deal as chvlieg.
--> added to existing deals below.

Startdatum: 26-1 2010
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 3505
WHERE
	lead_program_id = 1625 AND
	affiliate_id IN (14531,8737) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* May 28 2009, Dineke:
 Ticket 2861, Special deal for affiliates:
 * 5673 (Thomas25)
and later also:
 * 14531 (chvlieg)
 * 1601 (w. voskamp)
 * 8480 (Caroline)
 * 5263 (BliXem)
 * 11684 (Euronovo)
 * 13561 (muhavere)
 * 8737 (MijnAlbum)
 Aanvrager: Fleur
 Adverteerder: Vliegfabriek.nl
 Wat moet er precies gebeuren?

 Standaard in de hoogste staffel in alle categorien dus:

 1.      1625>wordt> 2822
 2.      1632> wordt> 2826
 3.      1633 > wordt> 2830
 4.      1636> wordt> 2828

 Einddatum: NVT
*/

UPDATE lead
	SET lead_program_id =
		CASE 	WHEN lead_program_id = 1625 THEN 2822
				WHEN lead_program_id = 1632 THEN 2826
				WHEN lead_program_id = 1633 THEN 2830
				WHEN lead_program_id = 1636 THEN 2828
		END
	WHERE	lead_program_id IN (1625, 1632, 1633, 1636) AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			affiliate_id IN (14531, 5673, 1601, 8480, 11684, 5263, 13561, 8737);
			
/** 
 * 2009-04-06: Andre Cesta. Ticket 2719. Echte staffel + special deal.
 * General > silver> gold > Premium
 * 1625> 2821 > 2822  All adjusted to start on at least 1st Jan 2009.
 * 1632> 2824 > 2825  All adjusted to start on at least 1st Jan 2009.
 * 1633> 2829 > 2830  All adjusted to start on at least 1st Jan 2009.
 * 1636> 2827 > 2828  All adjusted to start on at least 1st Jan 2009.
 * General: 0-10 sales 
 * Silver: 11-20 sales
 * Gold:	>21 sales
 */
 
/** Ticket#2719: silver 11-20 sales goes from lead program: 1625 to 2821 **/
UPDATE
	lead 
SET
	lead_program_id = 2821
WHERE
	lead_program_id =  1625 AND
	status = 'ACCEPTED' AND 	
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id IN (1625, 2821, 2822) AND 		 
		click_created < '2011-02-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 20
	);

/**  Ticket#2719: gold >= 21 sales goes from lead programs: 1625, 2821 to 2822 **/
UPDATE
	lead 
SET
	lead_program_id = 2822
WHERE
	lead_program_id IN (1625, 2821) AND
	status = 'ACCEPTED' AND 	
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id IN (1625, 2821, 2822) AND 		
		click_created < '2011-02-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	    GROUP BY affiliate_id HAVING COUNT(id) >= 21
	);
 
/** Ticket#2719: silver 11-20 sales goes from 1632 to 2824. */
UPDATE
	lead 
SET
	lead_program_id = 2824
WHERE
	lead_program_id =  1632 AND 
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id IN (1632, 2824, 2825) AND 	
		click_created < '2011-02-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 20
	);
/**  Ticket#2719: gold >= 21 sales goes from lead programs: 1632, 2824 to 2825 **/
UPDATE
	lead 
SET
	lead_program_id = 2825
WHERE
	lead_program_id IN (1632, 2824) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id in (1632, 2824, 2825) AND 		 
		click_created < '2011-02-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
    GROUP BY affiliate_id HAVING COUNT(id) >= 21
	);
	

/** 1633> 2829 > 2830  All adjusted to start on at least 1st Jan 2009. */
/** Ticket#2719: silver 11-20 sales goes from lead program: 1633 to 2829 **/
UPDATE
	lead 
SET
	lead_program_id = 2829
WHERE
	lead_program_id =  1633 AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id IN (1633, 2829, 2830) AND
		click_created < '2011-02-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 11 AND 20
	);
/**  Ticket#2719: gold >= 21 sales goes from lead programs: 1633, 2829 to 2830 **/
UPDATE
	lead 
SET
	lead_program_id = 2830
WHERE
	lead_program_id IN (1633, 2829) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id IN (1633, 2829, 2830) AND
		click_created < '2011-02-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
    GROUP BY affiliate_id HAVING COUNT(id) >= 21
	);

	
/** 1636> 2827 > 2828  All adjusted to start on at least 1st Jan 2009. */
/** Ticket#2719: silver 11-20 sales goes from lead program: 1636 to 2827 **/
UPDATE
	lead 
SET
	lead_program_id = 2827
WHERE
	lead_program_id =  1636 AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id in (1636, 2827, 2828) AND
		click_created < '2011-02-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
    GROUP BY affiliate_id HAVING COUNT(id) >= 11 AND COUNT(id) <= 20
	);
/**  Ticket#2719: gold >= 21 sales goes from lead programs: 1636, 2827 to 2828 **/
UPDATE
	lead 
SET
	lead_program_id = 2828
WHERE
	lead_program_id IN (1636, 2827) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-02-01' AND
	affiliate_id IN 
	(SELECT
		affiliate_id
	FROM 
		lead
	WHERE
		status = 'ACCEPTED' AND
		lead_program_id in (1636, 2827, 2828) AND
		click_created < '2011-02-01' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
    GROUP BY affiliate_id HAVING COUNT(id) >= 21
	);