/* March 1 2011, Jan, ticket: #6924
Kan jij tot 31 mei alle sales bij Centraal Beheer op 2847 en 3880 laten landen op 6308.

Dit geldt voor onderstaande affiliates

Ladymail 11970
DoublePoints 5486
ZinnGeld 5575
SurfRace 5575
Euroclix 105
Jiggy 11524
MoneyMiljonair 307

Update March 4 2011, Jan, Added Beverly Hills (19610) to the deal
*/

UPDATE
	lead
SET
	lead_program_id = 6308
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2847, 3880) AND
	affiliate_id IN (5486, 11970, 5575, 105, 11524, 307, 19610) AND
	created >= '2011-03-01' AND
	created < '2011-04-01';
	
/* Feb 21 2011, Dineke, Ticket #6849
 * Hi Dineke,

Zou jij voor mij Mailcollect toe willen voegen aan een tweetal special deals?

Mailcollect: 21505

Leadprogramma (Special Deal Woongarantverzekering): 3880 (from 2847)
Leadprogramma (Special Deal Beter Bewust Autoverzekering) 3879 (from 3922)

Alvast bedankt!
Wil je me ook laten weten wanneer je hier tijd voor hebt gehad?

Gr. Mirte
 */
UPDATE
	lead
SET
	lead_program_id =	CASE	WHEN lead_program_id = 2847 THEN 3880
								WHEN lead_program_id = 3922 THEN 3879
						END
WHERE
	affiliate_id = 21505 AND
	created > '2011-02-18' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2847, 3922);
	
/* January 19 2011, Jan, ticket: #6608
Kunnen jullie bij adverteerder Centraal Beheer 13320 alle leads voor affiliate Companeo 21014 op leadprogramma 4079 laten landen op 6172.
Dit mag vanaf vandaag.
*/
UPDATE
	lead
SET
	lead_program_id = 6172
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 4079 AND
	affiliate_id = 21014 AND
	created >= '2011-01-18';


/* December 22 2010, Jan, ticket: #6478
Kan jij bij centraal beheer (13320) voor affiliate Companeo (21014) alle leads die binnenkomen op lead ID 4688 laten landen op 6070

Dit mag vanaf vandaag.
*/

UPDATE
	lead
SET
	lead_program_id = 6070
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 4688 AND
	affiliate_id = 21014 AND
	created >= '2010-12-20';
	
/* November 30 2010, Jan, ticket: #
Kan jij jwalker83 14601 en jwalker84 23156
aan de special deal reis toevoegen van Centraal Beheer 13320

2853 naar 4218
dit mag per 1 november, dus graag vandaag 
Update December 7 2010, Jan, added Intela(22110) to the deal

Update December 14 2010, Jan, added gekkengoud 11965 to the deal
*/
UPDATE
	lead
SET
	lead_program_id = 4218
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2853 AND
	affiliate_id IN (14601, 23156, 22110, 11965) AND
	created >= '2010-11-01';

/* April 14 2010, Jan, ticket: #4817
Kan jij voor centraal beheer (13320) alle sales die van affiliate bronkhorstmedia (14122) binnen komen op leadprogramma 2853 laten landen op 4218.
Dit mag vanaf 1 april.
*/

UPDATE
	lead
SET
	lead_program_id = 4218
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2853 AND
	affiliate_id = 14122 AND
	created >= '2010-04-01';

/* June 28 2010, Jan, ticket: #5419
2853 -> 4218 for jwalker83
*/	
UPDATE
	lead
SET
	lead_program_id = 4218
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2853 AND
	affiliate_id = 14601 AND
	created >= '2010-06-01';

/* 2844 -> 3879 voor prijsvergelijk (6387)
Update June 2 2010, Jan, Added the following affiliates to the deal: 
Euroclix 105
moneymiljonair 307
zinngeld 5575
jiggy 11524
dmg 14878 
Update June 28: added jwalker83 (14601) ticket: #5419
Update October 8th 2010, Jan, Added Doublepoints (id 5486) and LadyMail (11970) to the deal
 */
UPDATE
	lead
SET
	lead_program_id = 3879
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2844 AND
	affiliate_id IN (6387, 105, 307, 5575, 11524, 14878, 14601, 5486, 11970) AND
	created >= '2010-02-01';

/* 2847 -> 3880 voor prijsvergelijk (6387) */
UPDATE
	lead
SET
	lead_program_id = 3880
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2847 AND
	affiliate_id = 6387 AND
	created >= '2010-02-01';

/* January 25 2010, Jan, ticket: #4499
Kan jij bij adverteerder Centraal Beheer (13320) alleen voor affiliate 88deb (11582)

Alle leads van programma ID:
-      2844 kunnen laten landen in 3879
en
-      2847 kunnen laten landen in 3880
?

Dit mag vanaf 1 januari 2010

Thanks
Met vriendelijke groet,

Bart van Raak

Update: January 26 2010, Jan
Changed the start date of the special deal to the 5-1-2010 at Bart's request.

Update: February 24 2010, Jan
Added affiliate 10830 (58tsx) to the deal 

Update: February 26 2010, Jan
Added affiliate Finance (4382) to the deal for autoverzekeringen leads (2844 -> 3879)

Update: March 23 2010, Jan
Added affiliates jmhmadvertising (16810) and Gekkengoud(11965) to both deals

Update: April 13 2010, Jan
Added affiliate Finance(4382) to the woon deal

Update: April 19 2010, Jan
Added affiliate Bronkhorstmedia (14122) to the deals.

Update: October 13th, Jan
Added SOODAA (8283) to the car deal

Update December 7 2010, Jan, added Intela(22110) to both deals

Update December 14 2010, Jan, added jwalker83 14601, jwalker84 23156 and gekkengoud 11965 to woon deal starting December 1st
*/

UPDATE
	lead
SET
	lead_program_id = 3879
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2844 AND
	affiliate_id IN (10830, 11582, 16810, 11965, 14122, 4382, 8283, 22110) AND
	created >= '2010-01-05';
	
/* 2847 -> 3880 */
UPDATE
	lead
SET
	lead_program_id = 3880
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2847 AND
	affiliate_id IN (10830, 11582, 16810, 11965, 4382, 14122, 22110) AND
	created >= '2010-01-05';

UPDATE
	lead
SET
	lead_program_id = 3880
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2847 AND
	affiliate_id IN (14601, 23156, 11965) AND
	created >= '2010-12-01';

/* April 6 2010, Jan, ticket: #4798
kan jij per gister

Euroclix 105
moneymiljonair 307
zinngeld 5575
jiggy 11524
dmg 14878

per gister toevoegen aan de wonen special deal van centraal beheer (13320)
Update June 3 2010, Jan, Added Beverly Hills (19610) to the deal
Update June 29 2010, Jan, Added besteconsumentenkoop (9181) to the deal
*/
UPDATE
	lead
SET
	lead_program_id = 3880
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2847 AND
	affiliate_id IN (105, 307, 5575, 9181, 11524, 14878, 19610) AND
	created >= '2010-04-07';
	
/* February 9 2011, Jan, ticket: #6748
Add the following affiliates to the "wonen" special deal, starting February 1st until the 1st of June.
Doublepoints 5486
Ladymail 11970
*/
UPDATE
	lead
SET
	lead_program_id = 3880
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 2847 AND
	affiliate_id IN (5486, 11970) AND
	created >= '2011-02-01' AND
	created < '2011-06-01';
