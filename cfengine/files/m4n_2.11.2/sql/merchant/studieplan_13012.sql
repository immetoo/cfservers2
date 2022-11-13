/* January 9 2011, Jan, ticket: #6746
Kan jij de leads van Applinet (515) voor Studieplan (13012) laten uitkomen op het leadprogramma met 0 euro vergoeding?

2699 > 6185
2698 > 6185

Kan je dat per februari instellen? 
*/

UPDATE
	lead
SET
	lead_program_id = 6185
WHERE
	affiliate_id = 515 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2698, 2699);
	
/* August 16 2010, Jan, ticket: #5695
Alle leads van affiliate 11582 op leadprogramma 2698 van adverteerder 13012 moeten automatisch worden afgekeurd.
*/

UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	affiliate_id = 11582 AND
	status IN ('ON_HOLD', 'TO_BE_APPROVED') AND
	lead_program_id = 2698 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
	

/* 21 August 2009, Dineke:
Reported by Michiel: 
alle leadregistraties bij studieplan (13012) op offid 2699 van affiliate 4619 moeten worden overgeboekt op offid 3124
*/

UPDATE
	lead
SET
	lead_program_id = 3124
WHERE
	affiliate_id = 4619 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2699);
	
/* January 21 2011, Jan, ticket: #6619
Kan jij voor mij de leads van Studieplan (id: 13012) van dit programma (2698) op een 0 euro leadprogramma (6185) laten uitkomen voor onderstaande 
partijen?

Euroclix (105)
Money Miljonair (307)
Doublepoints (5486)
Zinngeld (5575)
Jiggy (11524)
Ladymail (11970)
Mailcollect (21505)
*/

UPDATE
	lead
SET
	lead_program_id = 6185
WHERE
	affiliate_id IN (105, 307, 5486, 5575, 11524, 11970, 21505) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2698 AND 
	created >= '2011-01-21';