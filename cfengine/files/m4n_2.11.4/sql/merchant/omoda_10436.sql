/* April 13 2010, Jan, ticket: #4812
Hoi Jan,

Hopelijk de laatste voor vandaag, zou jij per 07-04 de affiliates
- 3893
- 6059
- 8880
- 9070
op leadprogramma 4214 kunnen zetten van de adverteerder O'Moda (10436)?

Thanks!
Met vriendelijke groet, 
Liesbeth Coopmans
*/
UPDATE 
	lead
SET 
	lead_program_id = 4214
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 1805 AND
 	affiliate_id IN (3893, 6059, 8880, 9070) AND
 	created >= '2010-04-07';
 	
/* June 9 2010, Jan, ticket: #5163
Omoda (id 10436)  aan lpid 4494, zwemkleding.nl (id 17860) en affiliate 9181
*/
UPDATE
	lead
SET
	lead_program_id = 4494
WHERE
	lead_program_id = 1805 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
	affiliate_id IN (17860, 9181) AND
	created >= '2010-06-01';