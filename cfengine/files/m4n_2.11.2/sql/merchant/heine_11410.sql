/* 29 June 2010, Jan, ticket: #5431
Zou jij alle sales van Heine (id 11410) standaard op status 1 kunnen zetten?
Kun je dit per vandaag in laten gaan?
*/

UPDATE
	lead
SET
	status = 'ON_HOLD'
WHERE
	status = 'TO_BE_APPROVED' AND
	lead_program_id IN (select id from lead_program where merchant_id = 11410) AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/**
* July 6 2009, Dineke: Ticket #3087
Aanvrager Alexander:
Zou je Lysander (10929) standaard in de hoogste staffel (2137) voor heine (11410) kunnen doen?
Thanx! 
***/

UPDATE
	lead
SET
	lead_program_id = 2137
WHERE
	lead_program_id IN (2134,2135, 2136) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 10929 AND
	created > '2009-07-06';