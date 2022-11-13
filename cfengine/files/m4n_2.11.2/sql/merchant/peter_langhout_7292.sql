/* July 9 2010, Dineke, Ticket #5501:
Aanvrager: Wouter S.

Temp deal

Wat moet er precies gebeuren?
Boekingen komen binnen op 1155
En moeten t/m 31-07 naar lpid 4610

Startdatum: 09-07-‘10
Einddatum (t/m): 31-07-10
*/
UPDATE
	lead
SET
	lead_program_id = 4610
WHERE
	lead_program_id = 1155 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-07-09' AND '2010-08-01';

/* October 18 2010, Dineke
	Requested by Camiel:
Kan jij van de volgende id’s de accounts alsjeblieft blokkeren:
* 12612, 11565, 11245, 11159 (Accounts van Edward Endeman)
* 18670, 13121, 10460, 7116  (Accounts van John IJsseldijk)
*/
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	lead_program_id IN (SELECT lead_programs(7292)) AND
	affiliate_id IN (12612, 11565, 11245, 11159, 18670, 13121, 10460, 7116) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'ON_HOLD', 'TO_BE_APPROVED');