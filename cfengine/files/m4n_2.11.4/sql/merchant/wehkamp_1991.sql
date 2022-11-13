/* November 12 2009, Dineke:
Reported by Jesse:
Wehkamp gets different rewards and 7 days cookietime.

They calculate the reward and put it in the price field, so all leads are put in the 100% - 143% reward.
-          Staffel 7,8% 2511  vervalt behalve voor Affiliate 13770
-          Staffel 3,5% 2426 voor de mailpartijen komt te vervallen
-          Automatisch leads goedkeuren onder 500 euro orderwaarde wordt: leads tot € 25 euro Affiliate moeten automatisch worden goedgekeurd. 
			Daarboven automatisch op “laten staan” (1)
*/

-- Auto accept below price = 15 euro (reward for affiliate)
UPDATE lead SET status = 'ACCEPTED' 
WHERE	status = 'TO_BE_APPROVED' AND
		lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 1991) AND
		price < 25;

--Set on hold price = 15 euro and up
UPDATE lead SET status = 'ON_HOLD' 
WHERE	status = 'TO_BE_APPROVED' AND
		lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 1991) AND
		price >= 25;

/* December 11 2008, Dineke: Special deal for top-affiliates */
--August 6 2009, Dineke: add affiliate trader (11033) to deal and remove 7193
--November 12: remove all except affiliate 13770!
UPDATE lead SET lead_program_id = 2511
WHERE	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 1991 AND id != 2511) AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		status != 'REJECTED' AND
		affiliate_id IN (13770);


/* November 17, 2009, Jan, ticket #4258
Aanvrager: Jesse le Grand

Exploitanten (in geval van special deal. Username + id): zinngeld 5575

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
From: 1082 to: 2426

Wat moet er precies gebeuren?
Alle sales van 5575 moeten op lpid 2426 worden gezet.

Startdatum: 13-11-09
Einddatum: geen
*/

UPDATE 
	lead
SET 
	lead_program_id = 2426
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 1082 AND
 	affiliate_id = 5575 AND
 	created >= '2009-11-13';
 	
/* September 10 2010, Jan, ticket: #5889
Zou jij voor account 8639 (Fourpeople) de volgende special deals kunnen regelen?

Wehkamp (id 1991): aan lp 2426 koppelen
*/	
UPDATE 
	lead
SET 
	lead_program_id = 2426
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 1082 AND
 	affiliate_id = 8639 AND
 	created >= '2010-09-10';