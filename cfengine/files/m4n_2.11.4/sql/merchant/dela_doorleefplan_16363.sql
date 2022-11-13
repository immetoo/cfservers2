/* November 30 2010, Jan, ticket: #6375
Zou je alle leads die binnenkomen op zone ID 836556 om willen zetten naar leadprogramma ID 5031?

Het is een mailing van EuroClix (ID 105) voor DELA (ID 16363)
*/
UPDATE
	lead
SET
	lead_program_id = 5031
FROM
	click
WHERE
	click.id = click_id AND
	lead_program_id = 4988 AND
	lead.affiliate_id = 105 AND
	zone_id = 836556 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* June 18 2010, Jan, ticket: #5365
Kan jij bij adverteerder Dela Leefdoorplan (16363) alle leads van Zinngeld (5575) die binnen komen op 3485 laten landen op 4528?
Kan jij hier Euroclix (105) en Media Inkoop - Intense Media (17061) hier ook aan toevoegen
*/

UPDATE
	lead
SET
	lead_program_id = 4528
WHERE
	lead_program_id = 3485 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (5575, 105, 17061);
	
UPDATE
	lead
SET
	lead_program_id = 4531
WHERE
	lead_program_id = 3484 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (5575, 105, 17061);

/*
December 6 2010, #6407, Dineke: Zou jij alle leads die binnenkomen op zone ID 840455 om willen zetten naar leadprogramma: 6048 (voorheen 4988).
Graag in laten gaan vanaf vandaag : 06/12/2010
--December 7, Dineke: same for zone 840469
*/
UPDATE
	lead
SET
	lead_program_id = 6048
FROM
	click
WHERE
	lead_program_id = 4988 AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click.id = click_id AND
	zone_id IN (840469, 840455) AND
	lead.created > '2010-12-06';
