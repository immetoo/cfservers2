/* February 23, Jan, ticket: #6864
Aanvrager: Wouter Groenewoud

Adverteerder: Internetshop
ID Adverteerder: 16659

Exploitanten (in geval van special deal. Username + id): Megakeuze(15097)

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):  
Leads die Megakeuze zet voor Internetshop, komen binnen op ID 3552 en deze moeten worden overgezet naar 3572. 

Wat moet er precies gebeuren? Zie bovenstaande

Startdatum: 21 februari
Einddatum: Onbekend. 
*/
UPDATE 
	lead
SET 
	lead_program_id = 3572
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 3552 AND
 	affiliate_id = 15097 AND
 	created >= '2011-02-21';
 	
/* December 14 2010, Jan, ticket: #6438
Kan er een special deal worden klaargezet voor 01-01-2011. Het gaat om het volgende:

Leads die afkomen van 98 hulse (19895) en Besteconsumentenkoop (9181) moeten bij Internetshop (16659) in ID  4311 komen te vallen.
*/
UPDATE 
	lead
SET 
	lead_program_id = 4311
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 3552 AND
 	affiliate_id IN (9181, 19895) AND
 	created >= '2011-01-01';

/* November 12 2009, Jan, ticket #4241

Aanvrager: Jesse le Grand

Adverteerder: Internetshop.nl
ID Adverteerder: 16659

Exploitanten (in geval van special deal. Username + id): ilse media 430

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):  
From: 3552 to: 3572

Wat moet er precies gebeuren?
Alle sales van 430 moeten op 3572 worden gezet. 

Startdatum: 10-11-09
Einddatum: geen


- November 17, 2009, Jan, ticket #4256
Reported by Jesse
Promodeals(10963), Besteconsumentenkoop (9181) and Prijsvergelijk (6387) have been added to the special deal.
--August 19 2010, added affiliate 17465 to deal 
*/

UPDATE 
	lead
SET 
	lead_program_id = 3572
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 3552 AND
 	affiliate_id IN (430, 10963, 9181, 6387, 17465);

/* November 16, 2009, Jan, ticket #4249
Aanvrager: Jesse le Grand

Exploitanten (in geval van special deal. Username + id): dekatoo 11315

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw): 
From: 3552 to: 3572

Wat moet er precies gebeuren?
Alle sales van Affiliate 11315 moeten op LPID 3572 worden gezet.

Startdatum: 13-11-09
Einddatum: geen
*/

UPDATE 
	lead
SET 
	lead_program_id = 3572
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 3552 AND
 	affiliate_id = 11315 AND
 	created >= '2009-11-13';
 	
/* November 24, 2009, Jan, ticket #4297
Added affiliate hoeknet(7863) to the special deal starting on 24-11-2009
*/
UPDATE
	lead
SET 
	lead_program_id = 3572
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 3552 AND
 	affiliate_id = 7863 AND
 	created >= '2009-11-24';
 	
/* September 17 2010, Jan, ticket: #5919
Zou er een special deal kunnen worden aangemaakt voor wasmachines.nl (19895 bij Internetshop (16659)  alle leads die wasmachines zet voor 
internetshop mag vallen in lead ID 4311

Dit mag ingaan per vandaag. 17 september. 
*/
UPDATE
	lead
SET 
	lead_program_id = 4311
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 3552 AND
 	affiliate_id= 19895 AND
 	created >= '2010-09-17';

/* May 28 2010, Jan, ticket: #5210
Aanvrager: Wouter Groenewoud
Daarnaast mogen de leads van Kortingkorting (8420) bij Internetshop (16659) binnekomen op (3572)
*/

UPDATE
	lead
SET 
	lead_program_id = 3572
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 3552 AND
 	affiliate_id = 8420 AND
 	created >= '2010-05-28';

/* September 1 2010, Jan, ticket: #5815
Kan affiliate Bas Lugten (17465 ) voor internetshop 16659 in een special deal worden geplaatst? Het lead programma waar hij in moet vallen moet zijn: 3572

Deze mag dan ingaan per 8 augustus. 

Update September 10 2010, Jan, ticket: #5890
Added affiliate besteonline (19186)
*/ 

UPDATE
	lead
SET 
	lead_program_id = 3572
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id = 3552 AND
 	affiliate_id IN (17465, 19186) AND
 	created >= '2010-08-08';