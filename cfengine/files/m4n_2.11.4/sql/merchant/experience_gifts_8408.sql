/**
 * 12 January 2009, Dineke Tuinhof
 * Special deal for affiliate jeskes (848): always gets 10% (lead_program 2546) 
 *
**/

UPDATE 
    lead
SET 
    lead_program_id = 2546
WHERE 
    lead_program_id = 1314 AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
    affiliate_id = 848;

/* April 21 2010, Jan, ticket: #4859
Aanvrager: Rutger van den Brule

Exploitanten (in geval van special deal. Username + id):
Originelecadeautips              14558

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
10 > boekingen      3779

Wat moet er precies gebeuren?
Het is een special deal, maar de adverteerder heeft verschillende staffels.
Dus mijn verzoek is of de affiliate in de vorm van een special deal in de hogere staffel geplaatst kan worden. (Hoogste staffel is het id hierboven)

Startdatum:    21 April 2010
Einddatum:     22 dec 2010
*/
UPDATE 
    lead
SET 
    lead_program_id = 3779
WHERE 
    lead_program_id IN (3777, 3778) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
    affiliate_id = 14558 AND
    created >= '2010-04-21' AND
    created < '2010-12-22';
   
/* December 24, 2009, Jan, ticket: #4408
Hoi Jan,

Mag ik een staffel aanvragen voor experiencegifts (8408)
Het gaat om leadprogramma 3777.

3777
0-5 boekingen

3778
6-10 boekingen

3779
10 > boekingen

Groet,
Robert Oerlemans
*/

UPDATE
	lead
SET
	lead_program_id  = 3779
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3777, 3778) AND
 	click_created < '2011-01-01' AND
 	affiliate_id IN (
 		SELECT
 			affiliate_id
 		FROM
 			lead
 		WHERE
 			lead_program_id IN (3777, 3778, 3779) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY
			affiliate_id
		HAVING
			COUNT(id) > 10
		);

UPDATE
	lead
SET
	lead_program_id  = 3778
WHERE
	status = 'ACCEPTED' AND
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3777) AND
 	click_created < '2011-01-01' AND
 	affiliate_id IN (
 		SELECT
 			affiliate_id
 		FROM
 			lead
 		WHERE
 			lead_program_id IN (3777, 3778, 3779) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
		GROUP BY
			affiliate_id
		HAVING
			COUNT(id) > 6
		);
			
			 