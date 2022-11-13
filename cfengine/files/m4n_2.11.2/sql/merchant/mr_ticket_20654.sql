/* July 20 2010, Dineke, #5566:
Aanvrager: Fleur

Special deal for affiliate Sizl: 630

4467 à 4624

Startdatum: 1-7-2010 ( dus graag met terugwerkende kracht)
Einddatum: nvt

August 19 2010, Dineke, #5713: affiliate jeskes gets this deal, starting August 17th

October 19 2010, Dineke, #6062, requested by Camiel:
Add affiliate vergelijknl (21108) to deal, starting today
*/

UPDATE
	lead
SET
	lead_program_id = 4624
WHERE
	lead_program_id = 4467 AND
	affiliate_id IN (630, 848, 21108) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2010-10-19';
