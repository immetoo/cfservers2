/* Oktober 4 2010, Dineke, #6001:
new special deal + staffel
*/
/* Special deal euroclix: always gets lead_program 4538 --> 4539
*/
UPDATE
	lead
SET
	lead_program_id = 4539
WHERE
	lead_program_id = 4538 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 105 AND
	created > '2010-10-04';

/* May 12 2009, Dineke:
	Special deal for certain affiliates: Euroclix (105) and moneymiljonair (307) always get 15 euros instead of 10 euro
	This applies for all statuses
*/
UPDATE
	lead
SET 
	lead_program_id = 1901
WHERE
	lead_program_id = 976 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (105, 307);

/* January 8, 2009, Dineke:
	Special Deal for affiliate Martijn (id: 578): always get lead_program_id 2552 (€ 20,- CPL)
*/
UPDATE 
	lead 
SET 
	lead_program_id = 1901
WHERE 
	lead_program_id = 976 AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 578;

/* May 28 2009, Dineke: Ticket #2876: Special deal
Aanvrager: Tim Markestein Adverteerder: Simyo

Lead programma's ID of advertentie ID (oud en nieuw): 2968

Wat moet er precies gebeuren?
De account tecsound@xs4all.nl (7262) moet standaard de vergoeding van leadprogramma 2968 krijgen.

Startdatum: 01-05-2009 Einddatum: nvt
*/
UPDATE
	lead
SET
	lead_program_id = 2968
WHERE
	lead_program_id IN (976, 1901) AND
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 7262;

/* November 19 2009, Dineke, requested by Tim
Kan je alle leads afkeuren die affiliate TVgids (ID: 8749) voor Simyo (ID: 5953) zet?
*/
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 8749 AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 5953);
	
/* February 1 2011, Dineke, #6674:
Requested by Paul V.
Hoi Dineke,
De volgende affiliates met id's, 105, 307, 5575, 11524 moet alle leads in andere LP's vallen dan de reguliere ivm een lagere marge die wij daar over krijgen.
De volgende structuur kan gehanteerd worden:

veel:		6184 -->	6204
geregeld:	6183 -->	6205
weinig:		6182 -->	6206
zelden:		6102 -->	6207
*/
UPDATE
	lead
SET
	lead_program_id = 
	CASE
		WHEN lead_program_id = 6184 THEN 6204
		WHEN lead_program_id = 6183 THEN 6205
		WHEN lead_program_id = 6182 THEN 6206
		WHEN lead_program_id = 6102 THEN 6207
	END
WHERE
	lead_program_id IN (6184, 6183, 6182, 6102) AND
	affiliate_id IN (105, 307, 5575, 11524) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
