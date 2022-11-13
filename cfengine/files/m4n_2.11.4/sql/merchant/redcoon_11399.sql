/* February 2 2011, Jan, ticket: #6682
Kan er een special deal worden aangemaakt voor Prijsvergelijk 6387 bij Redcoon 11399. Leads die Prijsvergelijk zet voor Redcoon moeten vanaf 1 
februari in lead ID 6201 vallen. 
*/

UPDATE
	lead
SET
	lead_program_id = 6201
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 11399 AND id != 6201) AND
 	created >= '2011-02-01' AND
 	affiliate_id = 6387; 
 	
/* June 16, Jan, ticket: #5355
Zou je alle leads van account 11399 redcoon automatisch op status 1 “laten staan” kunnen zetten? 
*/

UPDATE
	lead
SET
	status = 'ON_HOLD'
WHERE
	status = 'TO_BE_APPROVED' AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 11399) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	
/* April 23 2010, Jan, ticket: #4883
Adverteerder: Redcoon
ID Adverteerder: 11399

Welk type staffel is het (maak 1 keuze)?
2) Special Deal voor 8420 Kortingkorting.nl

Lead programma's ID of advertentie ID (oud en nieuw): 
Alle leads van 8420 voor 11399 moeten binnen komen op ID 3420

Startdatum: 23-04-2010
Einddatum: geen
*/

UPDATE
	lead
SET
	lead_program_id = 3420
 WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 11399 AND id != 3420) AND
 	created > '2010-04-23' AND
 	affiliate_id = 8420; 


/* October 5 2009, Dineke:
Special deal Requested by Jesse:

Hierbij aanvraag voor special deal voor Redcoon 11399.
Alle leads die op offid nr 2117 binnen komen moeten voor Affiliate 14303 op offid nr 3420 worden gezet.
Per 2 oktober.
*/
 										
UPDATE
	lead
SET
	lead_program_id = 3420
 WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 2117 AND
 	created > '2009-10-02' AND
 	affiliate_id = 14303; 
