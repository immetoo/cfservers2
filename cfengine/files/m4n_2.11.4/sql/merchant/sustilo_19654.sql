/* May 20 2010, Jan, ticket: #5139
Zouden jullie Zone ID 764069 willen koppelen aan leadprogramma 4428?
Affiliate ID (Zinngeld): 5575
Adverteerders ID (Sustilo): 19654
*/

UPDATE
	lead
SET
	lead_program_id = 4428
WHERE
	lead_program_id = 4178 AND
	click_id IN (SELECT id FROM click WHERE zone_id = 764069) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 5575;

/* June 28 2010, Jan, ticket: #5420
Zou jij affiliate Fashionchick (ID 8880) kunnen koppelen aan leadprogramma ID 4561 van adverteerder Sustilo (ID  19654)
*/

UPDATE
	lead
SET
	lead_program_id = 4561
WHERE
	lead_program_id = 4178 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 8880 AND
	created >= '2010-06-28';
	
/* August 19 2010, Jan, ticket: #5706
Kan één van jullie affiliate Girlscene (ID 13152) per vandaag (18/08) koppelen aan leadprogramma ID 4561 van adverteerder Sustilo (ID 19654).
*/
UPDATE
	lead
SET
	lead_program_id = 4561
WHERE
	lead_program_id = 4178 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 13152 AND
	created >= '2010-08-18';
	
/* September 8 2010, Arjan, ticket: #5877
Zou jij voor het account Sustilo (id 19654) affiliate Girlstyle (6900) kunnen koppelen aan lp 4561? Dit mag per vandaag.
*/

UPDATE
	lead
SET
	lead_program_id = 4561
WHERE
	lead_program_id = 4178 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 6900 AND
	created >= '2010-09-08';