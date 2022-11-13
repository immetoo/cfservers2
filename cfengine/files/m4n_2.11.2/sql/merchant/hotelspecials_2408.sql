
/* May 5 2010, Dineke, Ticket #4252:
 * Aanvrager: Wouter

Exploitanten (in geval van special deal. Username + id):  hardy@user.nl 19232

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Wat moet er precies gebeuren?
Leads die binnenkomen verplaatsen naar 1212.

Startdatum: 05/05/10
Einddatum: nvt

August 19 2010, Dineke, #5712: add affiliate Actiepag 3571 to deal per August 17
**/
UPDATE
	lead
SET
	lead_program_id = 1212
WHERE
	lead_program_id IN (552, 2249, 1096) AND
	affiliate_id IN (3571, 19232) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-08-17';

/** 17 December 2008, Dineke: reject leads by priceboy (6404) **/
UPDATE 
	lead 
SET 
	status = 'REJECTED'
WHERE 
	affiliate_id = 6404 AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  AND
	lead_program_id IN (552, 1569);

/* 17 november 2008, Dineke: Hotelspecials deals have changed
	552 	Standaard:	0 - 10 leads per maand 	
 	2249	Brons:		11 - 40 leads per maand  	
	1096 	Zilver:		41 - 74 leads per maand 	
	1212 	Goud: 		> 75 leads per maand 	
 */

/* Bronze (11 - 40 leads) */
UPDATE 
    lead
SET 
    lead_program_id = 2249 
WHERE 
	lead_program_id IN (552, 1096, 1212) AND 
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND  
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
	    FROM 
		    lead
		WHERE 
		    lead_program_id IN (552,2249,1096,1212) AND 
		    status = 'ACCEPTED' AND 
		    click_created < '2011-01-01' AND
		    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)   		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 11 AND 40
	);
	
/* Silver (41 - 74 leads) */
UPDATE 
    lead
SET 
    lead_program_id = 1096 
WHERE 
	lead_program_id IN(552, 2249, 1212) AND 
	status = 'ACCEPTED' AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
		    lead_program_id IN (552,1096,1212,2249) AND 
		    status = 'ACCEPTED' AND 
		    click_created < '2011-01-01' AND
		    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 41 AND 74
	);

/* Gold (75 leads and up) */
UPDATE 
    lead
SET 
    lead_program_id =  1212
WHERE 
	lead_program_id IN (552,2249,1096) AND 
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT 
	    	affiliate_id
		FROM 
		    lead
		WHERE 
		    lead_program_id IN (552,2249,1096,1212) AND 
		    status = 'ACCEPTED' AND 
		    click_created < '2011-01-01' AND
		    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)  		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 75
	);

/* Bonus for hotelspecials 
   reizenpaleis (8149) standaard in het hoogste segment van hotelspecials (2408) zetten.

April 9 2009, Dineke, ticket #2726:
Special deal for affiliate EuroNovo (11684). Same deal as reizenpaleis.
Lead programma's ID of advertentie ID (oud en nieuw): 1212

Wat moet er precies gebeuren?
Goedgekeurde leads van EuroNovo? (11684) koppelen aan lpid 1212

October 23 2009, Dineke: add affiliates sizlsizl (630),vipemedia (14674) and kdazl (13856) to deal
*/
UPDATE 
    lead
SET 
    lead_program_id =  1212
WHERE 
	lead_program_id IN (552,2249,1096) AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (630, 8149, 11684, 13856, 14674);

/* July 30 2009, Dineke: ticket #3599
DO NOT MOVE THIS DEAL UPWARDS! Then the user may end up in Bronze anyway.
TODO: currently when the user has 11 to 40 leads (bronze segment) these leads will be promoted back and forth each night.
	  this is unefficient and updates last_modified each night. How can we alter staffel and deal so this no longer happens?
 
Special deal for affiliate Qincqinc (630)
Aanvrager: Fleur

Wat moet er precies gebeuren?

Standaard starten in staffel zilver : 1096 ( ipv 552 (Standaard) of	2249 (Brons))

Startdatum: 29-7-2009 Einddatum: NVT 
*/
UPDATE
	lead
SET
	lead_program_id = 1096
WHERE
	lead_program_id IN (552, 2249) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 630 AND
	created > '2009-07-29';

/* Belgium: > 10? --> program 1569 becomes 1570 */
UPDATE 
    lead 
SET 
    lead_program_id = 1570
WHERE 
    lead_program_id = 1569 AND 
    status = 'ACCEPTED' AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
    click_created < '2011-01-01' AND
    affiliate_id IN (
    	SELECT 
        	affiliate_id 
       	FROM 
            lead 
        WHERE 
            lead_program_id IN (1570, 1569) AND 
            status = 'ACCEPTED' AND 
            click_created < '2011-01-01' AND
            payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
        GROUP BY 
        	affiliate_id 
        HAVING 
        	COUNT(id) >= 10
	);

/* July 31 2009, Dineke: Ticket #3604
 ID Adverteerder: 2408

 Exploitanten (in geval van special deal. Username + id): cadeau 6249

 Welk type staffel is het (maak 1 keuze)?
 2) Special deal

 Lead programma's ID of advertentie ID (oud en nieuw):
 pixel lpid: 552
 special deal lpid: 3180

 Wat moet er precies gebeuren?

 Leads die binnenkomen verplaatsen naar 3180. Vergoeding affiliate 15,65,
 totale vergoeding 21,29. Marge naar 73,51%

 Startdatum: 01/08/09
 Einddatum: 01/08/12
 */
 UPDATE
 	lead
 SET
 	lead_program_id = 3180
 WHERE
 	lead_program_id IN (552,1096,1212,2249) AND
 	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	affiliate_id = 6429 AND
 	created > '2009-08-01';
 