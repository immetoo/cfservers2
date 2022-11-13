/* March 14 2011, Jan, ticket: #7023
Kan je in het account van WNF 13875, de volgende affiliates toevoegen aan lpid 6288 (met ingang van vandaag):

- Moneymiljonair 307
Euroclix 105
Jiggy 17069
Zinngeld 5575
*/
UPDATE
	lead
SET
	lead_program_id = 6288
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 3001 AND
	affiliate_id IN (105, 307, 5575, 17069) AND
	created >= '2011-03-09';

/* March 2 2011, Jan, ticket: #6931
Kun jij ervoor zorgen dat alle leads die binnenkomen op advertentie ID 688199 vallen onder het leadprogramma 4968 (in plaats van 3001)?
Als het zou kunnen ook graag met terugwerkende kracht (vanaf 1 maart is prima).
*/
UPDATE
	lead
SET
	lead_program_id = 4968
FROM
	click
WHERE
	click.id = click_id AND
	lead_program_id = 3001 AND
	advertisement_id = 688199 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.created >= '2011-03-01';
	
/* November 26 2010, Jan, ticket: #6341
Zou jij er voor kunnen zorgen dat de leads die voortkomen uit Zone ID 827240 (WNF – MM) worden omgezet naar leadprogramma 4968?

Graag met terugwerkende kracht vanaf 07 november.
*/
UPDATE
	lead
SET
	lead_program_id = 4968
FROM
	click
WHERE
	click.id = click_id AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 13875 AND id NOT IN (4968, 4092, 4093, 4094, 4095, 4096)) AND
	zone_id = 827240 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.created >= '2010-11-07';

/* Niovember 8 2010, Dineke, Ticket #6220
 * Requested by Mirte:

Zou je ervoor kunnen zorgen dat alle leads die binnenkomen op zone ID 681019 worden omgezet naar leadprogramma ID 4968?

Dit graag voor de volgende partijen:
MoneyMiljonair       ID 307
LadyMail             ID 11970
DoublePoints         ID 5486
Zinngeld             ID 5575
MailCollect          ID 21505
Jiggy                ID 11524
 */
UPDATE
	lead
SET
	lead_program_id = 4968
FROM
	click
WHERE
	click.id = click_id AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 13875 AND id NOT IN (4968, 4092, 4093, 4094, 4095, 4096)) AND
	advertisement_id IN (681027, 681028) AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.affiliate_id IN (307, 11970, 5486, 5575, 21505, 11524);
	
	
/*March 26 2010, Jan, ticket: #4755
Aanvrager: Wouter Groenewoud

Welk type staffel is het (maak 1 keuze)?
2) Er is een staffel die naast de reguliere leads van Leadprogramma (3001) moet lopen. De staffel moet een fixed fee geven. Zodra er meer dan X goedgekeurde leads zijn.
De fixed fee komt dan bovenop de vergoeding die in het reguliere programma zit.

Omschrijving:
Zodra een affiliate meer dan X goedgekeurde leads heeft krijgt deze een fixed vergoeding.  De staffel ziet er als volgt uit:

Lead ID: 4092        101 tot 150 donateurs: bonus van €100
Lead ID: 4093        151 tot 250 donateurs: bonus van €250
Lead ID: 4094        251 tot 300 donateurs: bonus van €500
Lead ID: 4095        301 tot 350 donateurs: bonus van €750  
Lead ID: 4096        351 en meer donateurs: bonus van €1.000
*/

INSERT INTO lead (
	click_id, 
	lead_program_id, 
	description1,
	price, 
	status,  
	referrer, 
	ip_address, 
	user_agent, 
	payment_period_id, 
	affiliate_id, 
	click_created,
	created
)

SELECT
	MAX(id) AS click_id,
	 4092 AS lead_program_id,
	 'Nieuwe bonuslead' AS description1,
	 0 AS price,
	 'ACCEPTED'::approval_status AS status,
	 'automatic lead'::text AS referrer,
	 '127.0.0.1'::inet AS ip_address,
	 'inserted by m4n'::text AS user_agent,
	 (SELECT MAX(id) FROM payment_period WHERE processed = false) AS payment_period_id,
	 affiliate_id AS affiliate_id,
	 MAX(click_created) AS click_created,
	 now() - interval '7 hours' 
FROM
	lead
WHERE
	status = 'ACCEPTED' AND
	created >= '2010-03-24' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (3001, 4009) AND
	NOT EXISTS (
		SELECT
			affiliate_id
		FROM
			lead AS bonus_leads
		WHERE
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			bonus_leads.lead_program_id IN (4092, 4093, 4094, 4095, 4096) AND
			lead.affiliate_id = bonus_leads.affiliate_id
	)
GROUP BY
	affiliate_id
HAVING
	COUNT(*) >= 101;

/*Lead ID: 4093        151 tot 250 donateurs: bonus van €250*/
UPDATE
	lead
SET
	lead_program_id = 4093
WHERE
	lead_program_id IN (4092) AND
	created >= '2010-03-24' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3001, 4009) AND
			created >= '2010-03-24' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) BETWEEN 151 AND 250
	);
	
/*Lead ID: 4094        251 tot 300 donateurs: bonus van €500*/
UPDATE
	lead
SET
	lead_program_id = 4094
WHERE
	lead_program_id IN (4092, 4093) AND
	created >= '2010-03-24' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3001, 4009) AND
			created >= '2010-03-24' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) BETWEEN 251 AND 300
	);
	
/*Lead ID: 4095        301 tot 350 donateurs: bonus van €750*/
UPDATE
	lead
SET
	lead_program_id = 4095
WHERE
	lead_program_id IN (4092, 4093, 4094) AND
	created >= '2010-03-24' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3001, 4009) AND
			created >= '2010-03-24' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) BETWEEN 301 AND 350
	);
	
/*Lead ID: 4096        351 en meer donateurs: bonus van €1.000*/
UPDATE
	lead
SET
	lead_program_id = 4096
WHERE
	lead_program_id IN (4092, 4093, 4094, 4095) AND
	created >= '2010-03-24' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3001, 4009) AND
			created >= '2010-03-24' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 351
	);	
	