/* March 30 2010, Dineke:
Reported by Patrick E.:	Zou jij voor 247 Mobiel de orders > 50 op programma 4124 willen zetten.
*/

UPDATE
	lead
SET
	lead_program_id = 4124
WHERE
	lead_program_id = 3743 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status ='ACCEPTED' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (	SELECT
							affiliate_id
						FROM
							lead
						WHERE
							lead_program_id IN (3743, 4124) AND
							payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
							click_created < '2011-01-01' AND
							status = 'ACCEPTED'
						GROUP BY affiliate_id HAVING count(id) > 50);
						
				
 