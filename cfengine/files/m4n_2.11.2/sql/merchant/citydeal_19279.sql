/* February 2 2011, Jan, ticket: #6689
In het programma van Groupon (19279) heb ik een special deal aangemaakt met met lpid 6216.
Kan jij affiliate met id: 26074 hier aan koppelen? Per direct aub.
*/
UPDATE
	lead
SET
	lead_program_id = 6216
WHERE
	lead_program_id = 4078 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 26074;

/* May 10 2010, Jan, ticket: #5023
Zou jij alle leads van Citydeal (id 19279) die binnenkomen op lp 4115 en gegenereerd zijn door affiliate zerocondooms (id 11690) voortaan op lp 4376 kunnen laten zetten?
Thanks!
*/
UPDATE
	lead
SET
	lead_program_id = 4376
WHERE
	lead_program_id = 4115 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11690 AND
	created >= '2010-05-10';
	
/* August 13 2010, Jan, ticket: #5687
Aanvrager: Liesbeth
Adverteerder: Groupon
ID Adverteerder: 19279 

Welk type staffel is het (maak 1 keuze)?
1) Echte staffel

Lead programma's ID of advertentie ID (oud en nieuw):  
Standaard: lp 4078

> 20 sales: lp 4714
> 50 sales: lp 4715
> 100 sales: lp 4716
> 250 sales: lp 4717

Wat moet er precies gebeuren?
De affiliates moeten in hogere staffel vallen naarmate ze meer sales doen

Startdatum: 16 augustus
Einddatum: t/m 14 september

De staffel moet dus gelden over 1 maand.
*/

/* 20 sales: lp 4714 */
UPDATE
	lead
SET
	lead_program_id = 4714
WHERE
	lead_program_id IN (4078)  AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-08-16' AND
	created < '2010-09-14' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4078, 4714, 4715, 4716, 4717) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			created >= '2010-08-16' AND
			created < '2010-09-14'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 20
	);
	
/* 50 sales: lp 4715 */
UPDATE
	lead
SET
	lead_program_id = 4715
WHERE
	lead_program_id IN (4078, 4714)  AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-08-16' AND
	created < '2010-09-14' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4078, 4714, 4715, 4716, 4717) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			created >= '2010-08-16' AND
			created < '2010-09-14'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 50
	);
	
/* > 100 sales: lp 4716 */
UPDATE
	lead
SET
	lead_program_id = 4716
WHERE
	lead_program_id IN (4078, 4714, 4715)  AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-08-16' AND
	created < '2010-09-14' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4078, 4714, 4715, 4716, 4717) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			created >= '2010-08-16' AND
			created < '2010-09-14'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 100
	);
	
/* 250 sales: lp 4717 */
UPDATE
	lead
SET
	lead_program_id = 4717
WHERE
	lead_program_id IN (4078, 4714, 4715, 4716)  AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	created >= '2010-08-16' AND
	created < '2010-09-14' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4078, 4714, 4715, 4716, 4717) AND
			status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
			created >= '2010-08-16' AND
			created < '2010-09-14'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 250
	);