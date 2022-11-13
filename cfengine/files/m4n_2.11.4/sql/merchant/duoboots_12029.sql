/* November 2 2010, Jan, ticket: #6189
Aanvrager: Karin

Adverteerder: Duoboots
ID Adverteerder: 12029

Welk type staffel is het (maak 1 keuze)?
1) Echte staffel

Lead programma's ID of advertentie ID (oud en nieuw): 
Off_id 2289

Wat moet er precies gebeuren?
Off_id 2289 moet 7% krijgen bij 1 t/m 19 sales
Dan een nieuw off_id 4955 moet 8% krijgen bij 20 of meer sales

Startdatum: asap
Einddatum:is er niet 
*/

UPDATE
	lead
SET
	lead_program_id = 4955
WHERE
	lead_program_id = 2289 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (2289, 4955) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			status = 'ACCEPTED'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 20
	);