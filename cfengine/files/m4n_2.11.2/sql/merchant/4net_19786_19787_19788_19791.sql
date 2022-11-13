/*August 16 2010, Jan, ticket: #5691
Kan er voor Ajaxshop (19786) special deal worden aangemaakt voor Nederlandselftalshirt (19834)
Nederlandselftalshirt (19834) moet standaard in leadprogramma 4236 vallen bij Ajaxshop (19786).

Kan dit per vandaag ingaan? En ook de dan al gekeurde leads? 

Update August 17 2010, Jan, Changed start date to the 9th of August
*/

UPDATE
	lead
SET
	lead_program_id = 4236
WHERE
	lead_program_id IN (4226, 4235) AND
	affiliate_id = 19834 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-08-09';

/* April 15 2010, Jan, ticket: #4822
Het gaat om een staffel aanvraag voor 3 verschillende accounts.
Echter de staffels zijn bedoeld voor alle 3.

Aanvrager: Robert Oerlemans
Adverteerder: Ajaxshop, PSVfanstore en Mijnvoetbalshop.nl
ID Adverteerder: 19786    19787         19788

Welk type staffel is het (maak 1 keuze)?
1) Echte staffel

Wat moet er precies gebeuren?
Er moeten de volgende staffels ingezet worden Staffel:  0-9 sales 4% 10-19 sales 6% en 20+ sales 8%
Voor alle 3 de adverteerders

Naam				ID		ID-leadprogramma                     

Ajaxshop			19786		4226			0-9 sales 4%		
								4235			10 - 19 sales - 6% commissie per sale
								4236			20 + sales - 8% commissie per sale
								
PSVfanstore			19787		4227			0-9 sales 4%
								4237			10 - 19 sales - 6% commissie per sale
								4238			20 + sales - 8% commissie per sale
								
Mijnvoetbalshop.nl 	19788		4228			0-9 sales 4%
								4239			10 - 19 sales - 6% commissie per sale
								4240			20 + sales - 8% commissie per sale

Startdatum: 15 April 2010
Einddatum:  13 April 2012
*/

/* Ajaxshop: 10-19 sales -> lpid 4235 */
UPDATE
	lead
SET
	lead_program_id = 4235
WHERE
	lead_program_id = 4226 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4226, 4235, 4236) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			click_created < '2011-01-01'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10 AND COUNT(id) < 20
	);
	
/* Ajaxshop: 20 + sales -> lpid 4236 */
UPDATE
	lead
SET
	lead_program_id = 4236
WHERE
	lead_program_id IN(4226, 4235) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4226, 4235, 4236) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			click_created < '2011-01-01'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 20
	);
	
/* PSVfanstore: 10-19 sales -> lpid 4237 */
UPDATE
	lead
SET
	lead_program_id = 4237
WHERE
	lead_program_id = 4227 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4227, 4237, 4238) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			click_created < '2011-01-01' 
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10 AND COUNT(id) < 20
	);
	
/* PSVfanstore: 20 + sales -> lpid 4238 */
UPDATE
	lead
SET
	lead_program_id = 4238
WHERE
	lead_program_id IN(4227, 4237) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4227, 4237, 4238) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
			click_created < '2011-01-01' 
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 20
	);
	
/* Mijnvoetbalshop.nl: 10-19 sales -> lpid 4239 */
UPDATE
	lead
SET
	lead_program_id = 4239
WHERE
	lead_program_id = 4228 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4228, 4239, 4240) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' 
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10 AND COUNT(id) < 20
	);
	
/* Mijnvoetbalshop.nl: 20 + sales -> lpid 4240 */
UPDATE
	lead
SET
	lead_program_id = 4240
WHERE
	lead_program_id IN(4228, 4239) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4228, 4239, 4240) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' 
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 20
	);