/* December 7 2010, Jan, ticket: #6411
Zou je de leads die binnenkomen op LP 1290 en LP 4290 die gezet worden voor adverteerder Phoneshop id: 8152  door affiliate Scito media id: 7665     

omzetten naar specialdeal 5037. 
*/

UPDATE
	lead
SET
	lead_program_id = 5037
WHERE
	lead_program_id IN (1290, 4290) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 7665;

/* December 2 2009, Dineke:
Reported by Jonas:
ik heb net de staffel aangepast voor de Phoneshop (8152):
(lead id: 1290) Staffel 1: t/m 5 sales 14,- aff en € 18.67 totaal
(lead id: 1760) Staffel2: vanaf 6 sales 30 aff en 40 totaal

Zou jij deze staffel kunnen doorvoeren?
*/

UPDATE
	lead
SET
	lead_program_id = 1760
WHERE
	lead_program_id = 1290 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (	SELECT
							affiliate_id
						FROM
							lead
						WHERE
							lead_program_id IN (1760, 1290) AND
							click_created < '2011-01-01' AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
						GROUP BY
							affiliate_id
						HAVING
							count(id) >= 6
					);
 
/* August 6 2010, Jan, ticket: #5655
Reported by Patrick E.:
Leadprogramma 4290 voor iphone sales 1 – 5  
En deze staffel komt er nu bij Leadprogramma 4289 voor alle iphone sales > 6

Alle affiliates die > 6 hebben gedaan voor LP 4290 moeten dus in de hogere staffel komen. Het gaat om alle openstaande leads met terugwerkende kracht
*/

UPDATE
	lead
SET
	lead_program_id = 4289
WHERE
	lead_program_id = 4290 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (	
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4289, 4290) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING
			count(id) >= 6
	);
 