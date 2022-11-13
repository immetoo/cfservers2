/* January 17 2011, Jan, ticket: #6563
Kan je alle leads van Werksite (6948) voor de mailing met advertentie id: 686125 in de special deal (leadprogramma: 3438) van NHA (2289( terecht 
laten komen?
*/

UPDATE
	lead
SET
	lead_program_id = 3438
FROM
	click
WHERE
	click.id = click_id AND
	lead_program_id = 535 AND
	click.advertisement_id = 686125 AND
	lead.affiliate_id = 6948 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* May 27 2010, Dineke:
 * Reported by Michiel, May 26:
 * Affiliate 2702 mag per direct standaard in het goud segment van de NHA (2289) staffel vallen.
 */
UPDATE
	lead
SET
	lead_program_id = 4131
WHERE
	lead_program_id IN (4130, 535) AND
	affiliate_id IN (2702) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-05-26';

/* Januari 5 2010, Jan, ticket: #6509
Kunnen jullie ervoor zorgen dat de mailpartijen hieronder per vandaag in de hoogste staffel terecht komen voor NHA (2289)?

Affiliates
Zinngeld (5575)
Euroclix (105)
Money Miljonair (307)
Jiggy (11524)

Leadprogramma id: 535 (hoogste staffel van 11+ sales > 45 euro affiliate) -> 3220
*/
 
UPDATE
	lead
SET
	lead_program_id = 3220
WHERE
	lead_program_id IN (535, 4130, 4131) AND
	affiliate_id IN (105, 307, 5575, 11524) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2011-01-03';
	
/* January 20 2011, Jan, ticket: #6611
Kan je ecpull (id: 11805) in de special deal (id: 3220) van NHA (2289) zetten per morgen 20.01.11? 
*/
UPDATE
	lead
SET
	lead_program_id = 3220	
WHERE
	lead_program_id IN (535, 4130, 4131) AND
	affiliate_id = 11805 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-20';

/* October 9 2009, Dineke, Special deal:
Reported by Michiel: Zouden alle sales die binnenkomen met:

    * affiliate ID 6948 (werksite)
    * bij adverteerder 2289 (NHA)
    * op leadprogramma 535

vanaf vandaag (9 oktober) t/m 30 november overgezet kunnen worden op leadprogramma 3438 ?
*/

UPDATE
	lead
SET
	lead_program_id = 3438
WHERE
	lead_program_id = 535 AND
	affiliate_id = 6948 AND
	created BETWEEN '2009-10-09' AND '2009-11-30';

/* Dineke May 18 2010, #5107
Reported by Michiel, first forgotten by me, but now anyway...
Nieuwe staffel voor NHA (2289) per 1 april

Leadprogramma ID’s:

0 t/m 5 sales: 535
6 t/m 10 sales: 4130
11 en meer: 4131
*/
--6 t/m 10 sales: 4130
UPDATE
	lead
SET	
	lead_program_id = 4130
WHERE
	lead_program_id = 535 AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT affiliate_id FROM lead WHERE
							status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
							click_created < '2011-01-01' AND
							lead_program_id IN (535, 4130, 4131)
					 GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 6 AND 10
					 );

--11 sales and up: 4131
UPDATE
	lead
SET	
	lead_program_id = 4131
WHERE
	lead_program_id IN (4130, 535) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT affiliate_id FROM lead WHERE
							status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
							click_created < '2011-01-01' AND
							lead_program_id IN (535, 4130, 4131)
					 GROUP BY affiliate_id HAVING COUNT(id) > 10
					 );