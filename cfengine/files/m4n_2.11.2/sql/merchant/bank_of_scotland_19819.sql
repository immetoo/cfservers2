/* December 14 2010, Jan, ticket: #6435
alle leads van leadprogramma 4254 naar 4946

Dit geldt voor onderstaande affiliates vanaf 1 december tot oneindig
soodaa(8283), robvaneeden(12950), jwalker83 (14601), HomeFinance (9897), RiocardovandenHeuvel(13578)
*/

UPDATE
	lead
SET
	lead_program_id = 4946
WHERE
	lead_program_id = 4254 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-12-01' AND
	affiliate_id IN (8283, 12950, 14601, 9897, 13578);
	
/* November 2 2010, Jan, ticket: #6188
Requested by: Bart
Staffel Bank of Scotland(19819) per 8 november 2010

standaard 						-> 4254
20 of meer geopende rekeningen 	-> 4946

*/

UPDATE
	lead
SET
	lead_program_id = 4946
WHERE
	lead_program_id = 4254 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-11-08' AND
	click_created < '2011-02-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4254, 4946) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-02-01' AND
			created >= '2010-11-08'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 20
	);