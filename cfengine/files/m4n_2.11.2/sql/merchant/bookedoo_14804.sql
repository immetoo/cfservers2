/** #4513: January 28 2010, Dineke

Aanvrager: Wouter
Adverteerder: Bookedoo
ID Adverteerder: 14804

Welk type staffel is het (maak 1 keuze)?
4) Bonusdeal

Lead programma's ID of advertentie ID (oud en nieuw):  3899

Wat moet er precies gebeuren?
Extra lead aanmaken lpid 3899  bij goedgekeurde boeking

Startdatum: 01/02/2010
Einddatum: tm 28/02/2010
**/


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
	click_id,
	3899,
	'Bonus for ' || description1,
	 0 AS price,
	 status,
	 referrer,
	 ip_address,
	 user_agent,
	 payment_period_id,
	 affiliate_id,
	 click_created,
	 now() - interval '7 hours' 
FROM
	lead
WHERE
	created BETWEEN '2010-02-01' AND '2010-03-01' AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 14804 AND id != 3899) AND
	NOT EXISTS (
		SELECT
			id
		FROM
			lead as bonus_leads
		WHERE
			bonus_leads.lead_program_id = 3899 AND
			bonus_leads.payment_period_id = (SELECT MAX(id) FROM payment_period WHERE processed = false) AND
			lead.affiliate_id = bonus_leads.affiliate_id AND
			'Bonus for ' || lead.description1 = bonus_leads.description1
	);