/* June 21 2010, Jan, ticket: #5384
Zou je de leads van KortingKorting (8420) voor Koopgoedkoop (13784)  in het leadprgramma 4500 kunnen laten vallen.
Kan je dit in laten gaan per: 21 juni 2010?
*/

UPDATE
	lead
SET
	lead_program_id = 4500
WHERE
	lead_program_id IN (3027, 3039) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 8420 AND
	created >= '2010-06-21';

/* June 11 2010, Jan, ticket: 
Aanvrager: Wouter Groenewoud

Zou je voor mij de staffel bij Koopgoedkoop (13784) aan kunnen passen?
Dit moet worden:

1-14 sales  -> 3027
15-25 sales -> 3039
26+ sales   -> 4500
Kun je dit in laten per maandag de 14 juni.
*/

/* 15-25 sales -> 3039 */
UPDATE
	lead
SET
	lead_program_id = 3039
WHERE
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 3027 AND
	created >= '2010-06-14' AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(	SELECT
				affiliate_id
			FROM
				lead
			WHERE
				lead_program_id IN (3039, 3027, 4500) AND
				status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
				click_created < '2011-01-01' AND
				payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
			GROUP BY affiliate_id HAVING COUNT(id) BETWEEN 15 AND 25
		);

/* 26+ sales   -> 4500 */
UPDATE
	lead
SET
	lead_program_id = 4500
WHERE
	status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (3039, 3027) AND
	created >= '2010-06-14' AND
	click_created < '2011-01-01' AND
	affiliate_id IN 
		(	SELECT
				affiliate_id
			FROM
				lead
			WHERE
				lead_program_id IN (3039, 3027, 4500) AND
				status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
				click_created < '2011-01-01' AND
				payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 
			GROUP BY affiliate_id HAVING COUNT(id) > 25
		);

			
