/*August 20 2010, Dineke #5720
Aanvrager: Wouter
Autoapprove all leads that are 10 days old and older
*/
UPDATE
	lead
SET
	status = 'ACCEPTED'
WHERE
	lead_program_id IN (SELECT lead_programs(8987)) AND
	created < now() - INTERVAL '10 days' AND
	status = 'TO_BE_APPROVED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);

/* September 29 2009, Dineke: special deal: info2@tndmedia.nl always gets at least 3308 */
--March 25 2010, Dineke: this affiliate temporarily gets a higher reward (see below), so this one can run again after May 16th
UPDATE
	lead
SET
	lead_program_id = 3308
WHERE
	affiliate_id = 11976 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 3307 AND
	created > '2010-05-16';

/* Special Deal for list of affiliates, they get lead_program_id 3309:
mathijs						7035
reizenpaleis				8149
Roas						3421
ton.vandenhoogen@iid.nl 	7743
trader						11033
Thomas25					5673
gratiskortingscode			12903
qincqinc 					630
cadeau						6429
Dovest						17214
Mats						17934 --> added April 6th
Lysander - added March 11   10929
Vakantieparken.nl			(16709)
spanje.nl					(8897)
actiepag					(3571)
**/
UPDATE
	lead
SET
	lead_program_id = 3309
WHERE
	lead_program_id = 3307 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (7035, 8149, 3421, 7743, 11033, 5673, 12903, 630, 6429, 17214, 17934, 10929);

	/* March 3 2011, Dineke:
 * Requested by Liesbeth #6930:
 Aanvrager: Liesbeth

 Wat moet er precies gebeuren?
 Alle sales met description SR en SL moeten in lp 3567 komen te staan.
 De sales die in Februari in lp 3567 werden gezet, mogen weer gewoon in lp
 3307 blijven vallen.
	March 11 2011, parkenbonus for special deals:
	+ alle leads uit lp 3309 met description 2 = SR of SL moeten in lp 6337 vallen.
	+ alle leads uit lp 3308 met description 2 = SR of SL moeten in lp 6338 vallen.
 Startdatum: 1 maart
 Einddatum: t/m 31 maart
*/
UPDATE
	lead
SET
	lead_program_id = CASE	WHEN lead_program_id = 3307 THEN 3567
							WHEN lead_program_id = 3308 THEN 6337
							WHEN lead_program_id = 3309 THEN 6338
					  END
WHERE
	lead_program_id IN (SELECT lead_programs(8987)) AND lead_program_id != 3567 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2011-03-01' AND '2011-04-01' AND
	(description2 LIKE '%SR%' OR description2 LIKE '%SL%');
