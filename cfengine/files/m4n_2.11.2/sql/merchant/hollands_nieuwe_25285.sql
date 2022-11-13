/* January 24 2011, Dineke, #
 * Requested by Patrick:
 * Special deal: Leadprogramma 6188. Zou jij alle leads die door Martijn 578 worden gezet op dit leadprogramma willen zetten. 
 */
UPDATE
	lead
SET
	lead_program_id = 6188
WHERE
	lead_program_id IN (SELECT lead_programs(25285)) AND lead_program_id != 6288 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 578;

/* March 21, Dineke, #7061:
	Aanvrager: Paul Vogelzang

 Adverteerder: hollandsnieuwe
 ID Adverteerder: 25285

 Exploitanten (in geval van special deal. Username + id): lexthoonen +
 25548

 Welk type staffel is het (maak 1 keuze)?
 2) Special deal

 Lead programma's ID of advertentie ID (oud en nieuw):  6363

 Wat moet er precies gebeuren?

 Alle leads van affiliate id 25548 die gerealiseerd worden op leadprogramma
 6071 moeten worden overgezet naar 6363. Hierdoor krijgen de affiliate
 30 euro CPL. De leads mogen automatisch worden goedgekeurd.

 Startdatum: asap
 Einddatum: -
*/
UPDATE
	lead
SET
	lead_program_id = 6363, status = 'ACCEPTED'
WHERE
	lead_program_id = 6071 AND
	status != 'BLOCKED' AND
	affiliate_id = 25548 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created > '2011-03-16'
	