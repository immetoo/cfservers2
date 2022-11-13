/* September 1 2010, Jan, ticket: #5811
Aanvrager: Liesbeth

Adverteerder: Haburi
ID Adverteerder: 21520


Welk type staffel is het (maak 1 keuze)?
1) Echte staffel

Lead programma's ID of advertentie ID (oud en nieuw):  
lp 4685
lp 4686
lp 4687

Wat moet er precies gebeuren?
Bij < 1000 orderwaarde, moeten alle sales in lp 4685 vallen
Bij > 1000 euro orderwaarde, moeten alle sales in lp 4686 vallen

Wanneer de sales via de volgende advertenties zijn gegenereerd moeten ze in lp 4678 vallen. Dit gaat om de volgende advertenties:
679736
679737
679739
679740
679741
679742

Wanneer het lp 4678 actief is, maar de sales wel op deze advertentie ID's binnenkomen, moeten ze in de reguliere staffel vallen.

(Staffel werkt hetzelfde als die van Dressforless)

Startdatum: 1 september
Einddatum: 30 september

Update January 11 2011, Jan, Reactivated 4687 deal starting January 6th until the 31st
*/

UPDATE 
	lead 
SET 
	lead_program_id = 4686
WHERE 
	lead_program_id IN (4685, 4687) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-09-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (4685, 4686, 4687, 4781) AND 
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			created >= '2010-09-01' 
		GROUP BY 
			affiliate_id 
		HAVING 
			SUM(price) >= 1000
	);
	
UPDATE
	lead
SET
	lead_program_id = 4687
FROM
	click
WHERE
	lead.click_id = click.id AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id IN (4685, 4686) AND
	lead.created >= '2011-01-06' AND
	lead.created < '2011-02-01' AND
 	click.advertisement_id IN (679736, 679737, 679739, 679740, 679741, 679742);
