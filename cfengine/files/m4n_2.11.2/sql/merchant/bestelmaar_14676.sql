/* February 22, Dineke, #6856
 * Requested by Patrick Emmen:
 * Zou je alle leads van Vrijheidspers ID 8350 die ze voor bestelmaar zetten (en hebben gezet) automatisch
 * op leadprogramma 6058 Specialdeal Vrijheidspers - Bruto sale kunnen overzetten. Hij heeft een bruto lead afspraak. 

Hij krijgt nu 18 euro per lead. 
Dit geldt tevens voor alle goed- en afgekeurde leads. 
 */
UPDATE
	lead
SET
	lead_program_id = 6058, status = 'ACCEPTED' --lead_program has auto_accept = true, but when a lead is promoted, approval is explicit again
WHERE
	affiliate_id = 8350 AND
	status != 'BLOCKED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT lead_programs(14676)) AND lead_program_id != 6058;
	
/* December 16, Dineke, #6450:
 * Aanvrager:Paul Vogelzang

Lead programma's ID of advertentie ID (oud en nieuw): nieuw 6058

Wat moet er precies gebeuren?

De affiliate vrijheidspers krijgt een bruto vergoeding van 25 euro cpl in de periode van 16 december t/m 27 december. Dus leads die dan worden gezet krijgen deze vergoeding.
Deze leads mogen direct worden goedgekeurd!
Na de periode krijgt de affiliate de vergoeding van 18 euro cpl(dit is tevens leadprogramma id 6058). Deze leads mogen tevens standaard goedgekeurd worden indien gezet.

Startdatum: 16 december
Einddatum: 27 december
*/
UPDATE
	lead
SET
	lead_program_id = 6058, status = 'ACCEPTED'
WHERE
	lead_program_id IN (SELECT lead_programs(14676)) AND lead_program_id != 6058 AND
	affiliate_id = 8350 AND
	status != 'BLOCKED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created BETWEEN '2010-12-16' AND '2010-12-28';
	
/* December 4 2009, Dineke:
special deal staffel for affiliate Lysander:

€ 20,- per bruto order bij 0 tot 50 orders. (Totaal: € 25,-)                              leadprogramma: 3286
€ 22,50 per bruto order bij 50 order en meer. (Totaal: € 28,125)               leadprogramma: 3287

Orders kunnen meteen worden goedgekeurd aangezien ze bruto zijn. Zou je dit voor alle nog openstaande leads willen doen?

Gr.
Jonas
**/
	
/**  Special deal Lysander: always gets lead program 3286 **/
UPDATE
	lead
SET
	lead_program_id = 3286, status = 'ACCEPTED'
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 14676 AND id NOT IN (3286, 3287, 3699)) AND
	payment_period_id IN (SELECT id FROM Payment_period WHERE processed = false) AND
	affiliate_id = 10929;
	
/**  50 leads and up: promote lpid 3286 to lpid 3287 **/
UPDATE 
    lead
SET 
    lead_program_id = 3287
WHERE 
    lead_program_id IN (3286) AND
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	click_created < '2011-01-01' AND
	affiliate_id IN (SELECT
		                 affiliate_id
	                 FROM 
		                 lead
	                 WHERE	
		                 lead_program_id IN (3286, 3287) AND 
	                     status = 'ACCEPTED' AND
	                     click_created < '2011-01-01' AND
	                     payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) 		
	                 GROUP BY 
	                     affiliate_id 
	                 HAVING 
	                     COUNT(id) >= 50
	                 );