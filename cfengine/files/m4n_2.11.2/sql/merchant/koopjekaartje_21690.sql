/* October 21 2010, Dineke, #6069:
Aanvrager: Camiel

Special deal
- for affiliate  Sizl (630)
- Alle binnenkomende leads overzetten naar lpid 4878

Startdatum: 20-10-2010
Einddatum: geen
*/
UPDATE
	lead
SET
	lead_program_id = 4878
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed =false) AND
	affiliate_id = 630 AND
	lead_program_id IN (SELECT lead_programs(21690)) AND lead_program_id != 4878 AND
	created > '2010-10-20';