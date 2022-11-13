/* January 27 2011, Jan
 * Automatically place leads for NTI on status 'ON_HOLD'
 */

UPDATE
	lead
SET
	status = 'ON_HOLD'
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 4520) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'TO_BE_APPROVED';

/* October 8 2010, Jan
Alle sales van leadprogramma’s 3033 en 3032 van merchant 4520, gezet door affiliate 307 via advertentie 681698 moeten worden overgezet
naar leadprogramma 4532. Deze regel gaat in vanaf 1 oktober en duurt tot 1 december.
*/
UPDATE
	lead
SET
	lead_program_id = 4532
FROM
	click
WHERE
	lead.click_id = click.id AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id IN (3033, 3032) AND
	lead.created >= '2010-10-01' AND
	lead.created < '2010-12-01' AND
	lead.affiliate_id = 307 AND
 	click.advertisement_id = 681698;
 	
/* October 8 2010, Jan
Alle leads van affiliate 307 op leadprogramma 841 van merchant 4520 die voortgekomen zijn uit advertentie 681698 moeten worden afgekeurd. Deze leads
zullen nu al op goedgekeurd staan, omdat dit leadprogramma automatisch goedkeurt..  Ook dit moet van 1 oktober tot 1 december.
*/
UPDATE
	lead
SET
	status = 'REJECTED'
FROM
	click
WHERE
	lead.click_id = click.id AND
	lead.payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead.lead_program_id = 841 AND
	lead.created >= '2010-10-01' AND
	lead.created < '2010-12-01' AND	
	lead.affiliate_id = 307 AND
	lead.status = 'ACCEPTED' AND
 	click.advertisement_id = 681698;
	

/* August 26 2010, Jan, ticket: #5760
Special Deal: leads van affiliate 6948 op leadprogramma 841 van adverteerder 4520 moeten worden overgezet op leadprogramma 4765. 
Met terugwerkende kracht per 1 augustus.
*/

UPDATE
	lead
SET
	lead_program_id = 4765
WHERE
	lead_program_id = 841 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6948 AND
	created >= '2010-08-01';

/* April 27 2010, Jan, ticket: #4898
Adverteerder:		NTIpartnerprogramma

ID Adverteerder:	4520

Staffel op basis van description2:

Als in description2 van pixels 842, 843 of 3241 de tekst “Korting_” voorkomt, dan dienen leads van onderstaande pixels overgezet te worden op andere pixels:

842 -> 4134
843 -> 4136
3241 -> 4137
*/

/* 842 -> 4134 */
UPDATE
	lead
SET
	lead_program_id = 4134
WHERE
	lead_program_id = 842 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	description2 LIKE 'Korting_%' AND
	created >= '2010-06-01';

/* 843 -> 4136 */
UPDATE
	lead
SET
	lead_program_id = 4136
WHERE
	lead_program_id = 843 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	description2 LIKE 'Korting_%' AND
	created >= '2010-06-01';
	
/* 3241 -> 4137 */
UPDATE
	lead
SET
	lead_program_id = 4137
WHERE
	lead_program_id = 3241 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	description2 LIKE 'Korting_%' AND
	created >= '2010-06-01';

/* March 8 2010, Jan, ticket: #4688
Leads bij adverteerder NTI (4520) moeten op andere leadprogramma’s overgeboekt worden voor specifieke affiliates.

Affiliates:
- Euroclix (105)
- MoneyMiljonair (307)
- Zinngeld.nl (5575)
- Jiggy (11524)
- adsalsa (17075)

Veranderingen leadprogramma ID’s:
ID 842 à ID 3033
ID 843 à ID 3032
ID 3241 à 943

Per 1 maart.
Update Januari 17th 2011, Jan, Removed unsubscribed affiliate from deal
*/

/* 842 -> 3033 */
UPDATE
	lead
SET
	lead_program_id = 3033
WHERE
	lead_program_id = 842 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (105, 307, 5575, 11524, 17075) AND
	created >= '2010-03-01';

/* 843 -> 3032 */
UPDATE
	lead
SET
	lead_program_id = 3032
WHERE
	lead_program_id = 843 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (105, 307, 5575, 11524, 17075) AND
	created >= '2010-03-01';
	
/* 3241 -> 943 */
UPDATE
	lead
SET
	lead_program_id = 943
WHERE
	lead_program_id = 3241 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (105, 307, 5575, 11524, 17075) AND
	created >= '2010-03-01';

/* Januari 17 2011, Jan, ticket: #6564
Kan jij de affiliate mooieaanbieding (id:11523) in de special deals van NTI (id: 4520) plaatsen?

studiegids 841 > 6171
cursus 842 > 6168
mbo/hbo 843 > 6169
university 3241  > 6170
*/
--studiegids 841 > 6171
UPDATE
	lead
SET
	lead_program_id = 6171
WHERE
	lead_program_id = 841 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11523 AND
	created >= '2011-01-17';
	
-- cursus 842 > 6168
UPDATE
	lead
SET
	lead_program_id = 6168
WHERE
	lead_program_id = 842 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11523 AND
	created >= '2011-01-17';

-- mbo/hbo 843 > 6169
UPDATE
	lead
SET
	lead_program_id = 6169
WHERE
	lead_program_id = 843 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11523 AND
	created >= '2011-01-17';

-- university 3241 > 6170
UPDATE
	lead
SET
	lead_program_id = 6170
WHERE
	lead_program_id = 3241 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 11523 AND
	created >= '2011-01-17';