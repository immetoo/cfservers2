/* December 30 2010, Jan, ticket: #6497
Kan jij Shopkorting (12307) en Imbull (11033) toevoegen aan alle VIP staffels van het Leaders (17012) programma?

Op een rijtje zijn dit de volgende leadprogramma's:
4954
4951
4437
4434
4359
4197
4194
4191
4188 
4185
4182
3660

Kan je dit vanaf 22 december (gister) in laten gaan?

Update January 20 2011, Jan, ticket: #6617
Added affiliate Twenga per 1-1-2011
*/
UPDATE
	lead
SET
	lead_program_id = 4954
WHERE
	lead_program_id IN (4952, 4953) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';

UPDATE
	lead
SET
	lead_program_id = 4951
WHERE
	lead_program_id IN (4949, 4950) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';
	
UPDATE
	lead
SET
	lead_program_id = 4437
WHERE
	lead_program_id IN (4435, 4436) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';
	
UPDATE
	lead
SET
	lead_program_id = 4434
WHERE
	lead_program_id IN (4432, 4433) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';

UPDATE
	lead
SET
	lead_program_id = 4359
WHERE
	lead_program_id IN (4357, 4358) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';
	
UPDATE
	lead
SET
	lead_program_id = 4197
WHERE
	lead_program_id IN (4195, 4196) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';

UPDATE
	lead
SET
	lead_program_id = 4194
WHERE
	lead_program_id IN (4192, 4193) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';

UPDATE
	lead
SET
	lead_program_id = 4191
WHERE
	lead_program_id IN (4189, 4190) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';

UPDATE
	lead
SET
	lead_program_id = 4188
WHERE
	lead_program_id IN (4186, 4187) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';
	
UPDATE
	lead
SET
	lead_program_id = 4185
WHERE
	lead_program_id IN (4183, 4184) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';
	
UPDATE
	lead
SET
	lead_program_id = 4182
WHERE
	lead_program_id IN (4177, 4181) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';
	
UPDATE
	lead
SET
	lead_program_id = 3660
WHERE
	lead_program_id IN (3658, 3659) AND
	affiliate_id IN (11033, 12307, 11672) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2011-01-01';
	


/* November 30 2010, Jan, ticket: #6378
Bij adverteerder leaders worden alle publishers tijdelijk in de premium staffel geplaatst. Dit is vandaag ingegaan.

Deze tijdelijke verhoging duurt tot en met 31december.

Zou jij dit kunnen aanpassen?
*/

/* Laptopleader: 3658 -> 3659 */
UPDATE
	lead
SET
	lead_program_id = 3659
WHERE
	lead_program_id = 3658 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';

/* Cameraleader: 4177 -> 4181 */
UPDATE
	lead
SET
	lead_program_id = 4181
WHERE
	lead_program_id = 4177 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';

/* Desktopleader: 4183 -> 4184 */
UPDATE
	lead
SET
	lead_program_id = 4184
WHERE
	lead_program_id = 4183 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';

/* E-bookleader : 4186 -> 4187 */
UPDATE
	lead
SET
	lead_program_id = 4187
WHERE
	lead_program_id = 4186 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';
	
/* MP3leader: 4189 -> 4190 */
UPDATE
	lead
SET
	lead_program_id = 4190
WHERE
	lead_program_id = 4189 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';
	
/* Navigatieleader: 4192 -> 4193 */
UPDATE
	lead
SET
	lead_program_id = 4193
WHERE
	lead_program_id = 4192 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';

/* Telefoonleader: 4195 -> 4196 */
UPDATE
	lead
SET
	lead_program_id = 4196
WHERE
	lead_program_id = 4195 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';

/* Gameleader: 4357 -> 4358 */
UPDATE
	lead
SET
	lead_program_id = 4358
WHERE
	lead_program_id = 4357 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';

/* Scheerleader: 4432 -> 4433 */
UPDATE
	lead
SET
	lead_program_id = 4433
WHERE
	lead_program_id = 4432 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';

/* Tandenborstelleader: 4435 -> 4436 */
UPDATE
	lead
SET
	lead_program_id = 4436
WHERE
	lead_program_id = 4435 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';
	
/* Koffieleader: 4949 -> 4950 */
UPDATE
	lead
SET
	lead_program_id = 4950
WHERE
	lead_program_id = 4949 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';

/* Stofzuigerleader: 4952 -> 4953 */
UPDATE
	lead
SET
	lead_program_id = 4953
WHERE
	lead_program_id = 4952 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-11-24' AND
	created < '2011-01-01';

/* December 2, Jan, ticket #4344
Aanvrager: Jesse le Grand

Welk type staffel is het (maak 1 keuze)?
Staffel

Lead programma's ID of advertentie ID (oud en nieuw): 
From: 3658 to: 3659

Wat moet er precies gebeuren?
Bij het behalen van 30 orders moet Affiliate in 3659 vergoeding komen.
Special deal moet dit echter overrulen indien ingesteld.

Startdatum: 07-12-09
Einddatum: geen
*/
UPDATE
	lead
SET
	lead_program_id = 3659
WHERE
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id = 3658 AND
	status = 'ACCEPTED' AND
	affiliate_id IN (
			SELECT
				affiliate_id
			FROM
				lead
			WHERE
				lead_program_id IN (3658, 3659) AND
				status = 'ACCEPTED' AND
				payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)
			GROUP BY
				affiliate_id
			HAVING
				COUNT(id) >= 30
			) AND
	created >= '2009-12-07' AND
	created <= '2010-04-09';
	
/* April 13 2010, Jan, ticket: #4811
Leader.nl wil per subsite kunnen meten wat de kosten zijn en het aantal leads. Daarom heb ik per site verschillende leadprogramma's aangemaakt
waardoor ze op de 7 subwebsites verschillende meetpixels kunnen implementeren.  Het komt neer op 21 leadprogramma's, waarvan 3 oude.

Aanvrager:Paul Vogelzang

Adverteerder: Leaders
ID Adverteerder: 17012

Cameraleader:
Welk type staffel is het (maak 1 keuze)?
5) Anders, nl: nieuwe leadprogramma's

Lead programma's ID of advertentie ID (nieuw):  
ID 4177 
ID 4181
ID 4182

Wat moet er precies gebeuren?
Leadprogramma ID 4177 is 2% commissie over de sale. Indien er meer dan 10 sales zijn gegenereerd dan naar ID 4181 waardoor de affiliate een commissie
ontvangt van 3%. ID 4182 is een VIP commissie op uitnodiging en ontvangt een commissie van 4%.

Startdatum: ASAP
Einddatum:
*/

UPDATE
	lead
SET
	lead_program_id = 4181
WHERE
	lead_program_id = 4177 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created > '2010-04-09' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4177, 4181) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created > '2010-04-09'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10
	);

/* Special deal for Prijsvergelijk (6387) */
UPDATE
	lead
SET
	lead_program_id = 4181
WHERE
	lead_program_id = 4177 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6387 AND
	created > '2010-04-09';
	
/* Desktopleader:
Welk type staffel is het (maak 1 keuze)?
5) Anders, nl: nieuwe leadprogramma's

Lead programma's ID of advertentie ID (nieuw):  
ID 4183
ID 4184
ID 4185

Wat moet er precies gebeuren?
Leadprogramma ID 4183 is 2% commissie over de sale. Indien er meer dan 10 sales zijn gegenereerd dan naar ID 4184 waardoor de affiliate een commissie
ontvangt van 3%. ID 4185 is een VIP commissie op uitnodiging en ontvangt een commissie van 4%.

Startdatum: ASAP
Einddatum:
*/

UPDATE
	lead
SET
	lead_program_id = 4184
WHERE
	lead_program_id = 4183 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created > '2010-04-09' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4183, 4184) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created > '2010-04-09'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10
	);

/* Special deal for Prijsvergelijk (6387) */
UPDATE
	lead
SET
	lead_program_id = 4184
WHERE
	lead_program_id = 4183 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6387 AND
	created > '2010-04-09';
	
/* E-bookleader: 
Welk type staffel is het (maak 1 keuze)?
5) Anders, nl: nieuwe leadprogramma's

Lead programma's ID of advertentie ID (nieuw):  
ID 4186
ID 4187
ID 4188

Wat moet er precies gebeuren?
Leadprogramma ID 4186 is 2% commissie over de sale. Indien er meer dan 10 sales zijn gegenereerd dan naar ID 4187 waardoor de affiliate een commissie
ontvangt van 3%. ID 4188 is een VIP commissie op uitnodiging en ontvangt een commissie van 4%

Startdatum: ASAP
Einddatum:
*/

UPDATE
	lead
SET
	lead_program_id = 4187
WHERE
	lead_program_id = 4186 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created > '2010-04-09' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4186, 4187) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created > '2010-04-09'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10
	);

/* Special deal for Prijsvergelijk (6387) */
UPDATE
	lead
SET
	lead_program_id = 4187
WHERE
	lead_program_id = 4186 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6387 AND
	created > '2010-04-09';

/* MP3leader:
Welk type staffel is het (maak 1 keuze)?
5) Anders, nl: nieuwe leadprogramma's

Lead programma's ID of advertentie ID (nieuw):  
ID 4189
ID 4190
ID 4191

Wat moet er precies gebeuren?
Leadprogramma ID 4189 is 2% commissie over de sale. Indien er meer dan 10 sales zijn gegenereerd dan naar ID 4190 waardoor de affiliate een commissie
ontvangt van 3%. ID 4191 is een VIP commissie op uitnodiging en ontvangt een commissie van 4%

Startdatum: ASAP
Einddatum:*/

UPDATE
	lead
SET
	lead_program_id = 4190
WHERE
	lead_program_id = 4189 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created > '2010-04-09' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4189, 4190) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created > '2010-04-09'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10
	);

/* Special deal for Prijsvergelijk (6387) */
UPDATE
	lead
SET
	lead_program_id = 4190
WHERE
	lead_program_id = 4189 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6387 AND
	created > '2010-04-09';

/* Navigatieleader: 
Welk type staffel is het (maak 1 keuze)?
5) Anders, nl: nieuwe leadprogramma's

Lead programma's ID of advertentie ID (nieuw):  
ID 4192
ID 4193
ID 4194

Wat moet er precies gebeuren?
ID 4192 krijgt 2% commissie over de sale. Indien er meer dan 10 sales zijn gegenereerd dan naar ID 4193 waardoor de affiliate een commissie ontvangt
van 3%. ID 4194 is een VIP commissie op uitnodiging en ontvangt een commissie van 4%

Startdatum: ASAP
Einddatum:*/

UPDATE
	lead
SET
	lead_program_id = 4193
WHERE
	lead_program_id = 4192 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created > '2010-04-09' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4192, 4193) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created > '2010-04-09'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10
	);

/* Special deal for Prijsvergelijk (6387) */
UPDATE
	lead
SET
	lead_program_id = 4193
WHERE
	lead_program_id = 4192 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6387 AND
	created > '2010-04-09';
	
/* Telefoonleader: 
Welk type staffel is het (maak 1 keuze)?
5) Anders, nl: nieuwe leadprogramma's

Lead programma's ID of advertentie ID (nieuw):  
ID 4195
ID 4196
ID 4197

Wat moet er precies gebeuren?
Leadprogramma ID 4195 is 2% commissie over de sale. Indien er meer dan 10 sales zijn gegenereerd dan naar ID 4196 waardoor de affiliate een commissie
ontvangt van 3%. ID 4197 is een VIP commissie op uitnodiging en ontvangt een commissie van 4%

Startdatum: ASAP
Einddatum:*/

UPDATE
	lead
SET
	lead_program_id = 4196
WHERE
	lead_program_id = 4195 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created > '2010-04-09' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4195, 4196) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created > '2010-04-09'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10
	);

/* Special deal for Prijsvergelijk (6387) */
UPDATE
	lead
SET
	lead_program_id = 4196
WHERE
	lead_program_id = 4195 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6387 AND
	created > '2010-04-09';

/* Laptopleader:
Welk type staffel is het (maak 1 keuze)?
5) Anders, nl: nieuwe leadprogramma's

Lead programma's ID of advertentie ID (OUD):  
ID 3658
ID 3659
ID 3660

Wat moet er precies gebeuren?
Leadprogramma ID 3658 is 2% commissie over de sale. Indien er meer dan 10 sales zijn gegenereerd dan naar ID 3659(voorheen was dit 30 sales) waardoor
de affiliate een commissie ontvangt van 3%. ID 3660 is een VIP commissie op uitnodiging en ontvangt een commissie van 4%.

Startdatum: ASAP
Einddatum:*/

UPDATE
	lead
SET
	lead_program_id = 3659
WHERE
	lead_program_id = 3658 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created > '2010-04-09' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (3658, 3659) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created > '2010-04-09'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) >= 10
	);

/* Special deal for Prijsvergelijk (6387) */
UPDATE 
	lead
SET 
	lead_program_id = 3659
WHERE
 	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
 	lead_program_id IN (3658, 3660) AND
 	affiliate_id = 6387 AND
 	created >= '2009-12-07';

/* May 26 2010, Jan, ticket: #5168
Aanvrager: Paul Vogelzang

Welk type staffel is het (maak 1 keuze)?
1) Echte staffel


Lead programma's ID of advertentie ID (oud en nieuw):  nieuw 4432

Wat moet er precies gebeuren?

In leadprogramma 4432 krijgt de affiliate 2% over de orderwaarde. Als er meer dan 10 sales(dus vanaf 11) sales valt de affiliate in leadprogramma 
4433(nieuw). Leadprogramma 4434 is een VIP comissie en is alleen mogelijk op uitnodiging, hier ontvangt de affiliate 4%.

Startdatum: 25-05
Einddatum: -
*/

UPDATE
	lead
SET
	lead_program_id = 4433
WHERE
	lead_program_id = 4432 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-05-25' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4432, 4433) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created >= '2010-05-25'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 10
	);

/* May 26 2010, Jan, ticket: #5168
Welk type staffel is het (maak 1 keuze)?
1) Echte staffel


Lead programma's ID of advertentie ID (oud en nieuw):  nieuw 4435

Wat moet er precies gebeuren?

In leadprogramma 4435 krijgt de affiliate 2% over de orderwaarde. Als er meer dan 10 sales(dus vanaf 11) sales valt de affiliate in leadprogramma 
4436(nieuw). Leadprogramma 4437 is een VIP comissie en is alleen mogelijk op uitnodiging, hier ontvangt de affiliate 4%.

Startdatum: 25-05
Einddatum: -
*/
UPDATE
	lead
SET
	lead_program_id = 4436
WHERE
	lead_program_id = 4435 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-05-25' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4435, 4436) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created >= '2010-05-25'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 10
	);
		
/* November 15 2010, Jan, ticket: #6301
Onlangs zijn er voor Leaders (17012) twee nieuwe feeds aangeleverd. Het gaat hier om producten voor stofzuigerleader.nl en koffieleader.nl. Voor deze 
sites heb ik een leadprogramma aangemaakt.

Stofzuigerleader heeft lpid: 4952
Koffieleader heeft lpid: 4949

Voor deze sites wordt, net als bij de andere sites van leaders, een staffel gehanteerd.
Standaard: 2%
Premium (10 of meer sales per maand): 3%
VIP (verborgen): 4%

Nou heb ik voor deze staffels al een leadprogramma aangemaakt. Ik weet niet of dat de bedoeling is…
Kunnen deze staffels voor beide sites worden aangemaakt? De datum van ingang is per direct.
*/

/* Stofzuigerleader 4952 -> 4953 */
UPDATE
	lead
SET
	lead_program_id = 4953
WHERE
	lead_program_id = 4952 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-11-10' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4952, 4953) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created >= '2010-11-10'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 10
	);

/* Koffieleader 4949 -> 4950 */
UPDATE
	lead
SET
	lead_program_id = 4950
WHERE
	lead_program_id = 4949 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	created >= '2010-11-10' AND
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
		FROM
			lead
		WHERE
			lead_program_id IN (4949, 4950) AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			status = 'ACCEPTED' AND
			click_created < '2011-01-01' AND
			created >= '2010-11-10'
		GROUP BY
			affiliate_id
		HAVING 
			COUNT(id) > 10
	);
