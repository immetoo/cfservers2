/* December 20 2010, Jan, ticket: #6461
Zou jij de volgende adid's kunnen hangen aan lpid 5019 van adverteerder Kolibrishop 23375. T/m 30-12-2010. Daarna mogen ze gewoon aan de huidige 
staffel hangen.

685198
685199
685200
685209
685213
685215

Update January 11 2011, Jan, Reactivated deal starting January 6th until the 31st and shortened advertisement list
*/
UPDATE
	lead
SET
	lead_program_id = 5019
FROM
	click
WHERE
	lead.created >= '2011-01-06' AND
	lead.created < '2011-02-01' AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (5009, 5010) AND
	lead.click_id = click.id AND
	advertisement_id IN (
		685198,
		685199,
		685200,
		685209,
		685213,
		685215
	);

/* November 26 2010, Jan, ticket: #6344
Zou jij de volgende staffel kunnen aanmaken voor adverteerder kolibrishop (ID 23375)
lpid: 5009 --> 8% commissie < EUR 1000 orderwaarde
lpid: 5010 --> 10% commissie < EUR 1000 orderwaarde 
*/

UPDATE 
	lead 
SET 
	lead_program_id = 5010
WHERE 
	lead_program_id = 5009 AND
	status = 'ACCEPTED' AND
	click_created < '2011-01-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM 
			lead
		WHERE 
			lead_program_id IN (5009, 5010) AND 
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY 
			affiliate_id 
		HAVING 
			SUM(price) >= 1000
	);