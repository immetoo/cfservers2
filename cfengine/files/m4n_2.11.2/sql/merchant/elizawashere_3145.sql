/* Sep 3 2010, Dineke, #5842:
 Reported by Wouter S.

Exploitanten (in geval van special deal. Username + id):

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
646
4016

Wat moet er precies gebeuren?
Boekingen met transactiedatum van 01-09 t/m 30-09 naar lpid 4016

Startdatum: 01-09-2010
Einddatum: 30-09-2010
*/
UPDATE
	lead
SET
	lead_program_id = 4016
WHERE
	lead_program_id = 646 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-09-01' AND '2010-10-01';

/* October 29 2010, ticket #6151, Dineke
 * Reported by Camiel

Special deal for certain accomodations

Alle boekingen van acco:
Montejaque
Finca los ciruelos
Casa la malvasia
Caserio de san jose
Casa dominique

Lpid: van 646 à 4935

Startdatum: 01-11-2010
Einddatum: 01-12-2010
*/
UPDATE
	lead
SET
	lead_program_id = 4935
WHERE
	lead_program_id = 646 AND
	(	LOWER(description2) LIKE '%montejaque' OR
		LOWER(description2) LIKE '%finca los ciruelos' OR
		LOWER(description2) LIKE '%casa la malvasia' OR
		LOWER(description2) LIKE '%caserio de san jose' OR
		LOWER(description2) LIKE '%casa dominique'
	) AND
	created BETWEEN '2010-11-01' AND '2010-12-01';
 
	