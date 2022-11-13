/* 17 December 2009, Dineke:
reported by Jonas: Zou je Portable Gear (578 )automatisch in de 20+ staffel (3546 )van Belsimpel (10375 )willen zetten?
*/
UPDATE
	lead
SET
	lead_program_id = 3546
WHERE
	lead_program_id = 1788 AND
	affiliate_id = 578 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* October 7 2010, Dineke, #6013:
 * staffel iphone4: 
Aanvrager: Paul Vogelzang
Welk type staffel is het (maak 1 keuze)? 1) Echte staffel

Lead programma's ID of advertentie ID 4843 --> 4844

Wat moet er precies gebeuren?

leadprogramma 4843 is een vergoeding voor een iphone4 commissie 30 euro CPL. Indien meer dan 40 sales worden gehaald in de maand, dus 41 en meer, 
dan in hoger leadprogramma, namelijk 4844 waarbij de affiliate een commissie ontvangt van 35 euro CPL

Startdatum: 07-10-10 Einddatum: -
*/
UPDATE
	lead
SET	
	lead_program_id = 4844
WHERE
	lead_program_id = 4843 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
    created > '2010-10-07' AND
    click_created < '2011-01-01' AND
	affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE 
		                 lead_program_id IN (4844, 4843) AND 
		                 status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
	                 GROUP BY 
	                     affiliate_id 
	                 HAVING 
	                     COUNT(id) > 40
	                 );

/**
* Staffel Belsimpel 10375
* Ticket #1429	

November 6 2009, Dineke
Reported by Jonas: more tiers to staffel as follows

Gaat om Belsimpel: 10375

Het algemene leadprogramma is 1788. Ik kan de marges niet aanpassen…
Zou jij daarom de onderstaande leadprogramma’s erin willen zetten. De eerste staffel ‘GSM + Abonnement 1-5’ moet 1788 worden. De Losse toestel vergoeding moet op 5 komen.

Heb je zo genoeg gegevens?

lpid	Type product                                             affiliate vergoeding                       Totale kosten per order incl fee M4N (77% voor affiliate)
1788	GSM + Abonnement 1-5                                          €27.5                                                    €35.714
3544	GSM + Abonnement  6-10                                        €32.5                                                    €42.21
3545	GSM + Abonnement  11-20                                       €37.5                                                    €48.70
3546	GSM + Abonnement  20-39                                       €42.5                                                    €51.19
3547	GSM + Abonnement  40+                                         €45                                                      €58.44
		Losse GSM/Prepaid                                                 5

Losse GSM doet niet mee voor de staffel.

Thanks!
**/

/** 6 - 10 leads? Go to lead program 3544 **/
UPDATE 
    lead 
SET 
    lead_program_id = 3544
WHERE
    lead_program_id IN (1788) AND 
    status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE 
		                 lead_program_id IN (1788, 3544, 3545, 3546, 3547) AND 
		                 status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
	                 GROUP BY 
	                     affiliate_id 
	                 HAVING 
	                     COUNT(id) BETWEEN 6 AND 10
	                 );

/** 11 - 20 leads? Go to lead program 3545 **/
UPDATE 
    lead 
SET 
    lead_program_id = 3545
WHERE
    lead_program_id IN (1788, 3544) AND 
    status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE 
		                 lead_program_id IN (1788, 3544, 3545, 3546, 3547) AND 
		                 status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
	                 GROUP BY 
	                     affiliate_id 
	                 HAVING 
	                     COUNT(id) BETWEEN 11 AND 20
	                 );
	                 

/** 21 - 39 leads? Go to lead program 3546 **/
UPDATE 
    lead 
SET 
    lead_program_id = 3546
WHERE
    lead_program_id IN (1788, 3544, 3545) AND 
    status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE 
		                 lead_program_id IN (1788, 3544, 3545, 3546, 3547) AND 
		                 status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
	                 GROUP BY 
	                     affiliate_id 
	                 HAVING 
	                     COUNT(id) BETWEEN 21 AND 39
	                 );
	                 

/** 40 leads and up? Go to lead program 3547 **/
UPDATE 
    lead 
SET 
    lead_program_id = 3547
WHERE
    lead_program_id IN (1788, 3544, 3545, 3546) AND 
    status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    click_created < '2011-01-01' AND
    affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE 
		                 lead_program_id IN (1788, 3544, 3545, 3546, 3547) AND 
		                 status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND 
		                 click_created < '2011-01-01' AND
		                 payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
	                 GROUP BY 
	                     affiliate_id 
	                 HAVING 
	                     COUNT(id) >= 40
	                 );