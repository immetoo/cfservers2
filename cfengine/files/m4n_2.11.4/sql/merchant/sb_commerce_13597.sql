/* May 5 2009, Dineke: Ticket #2806
  staffel moederdagwebwinkel

this is a different staffel: the lead program should change depending on what's in description3.
it starts today (May 5 2009) and doesn't have an end date 

SB Commerce (id 13597) gaat vandaag met Moederdagwebwinkel.nl live. 
Ze hebben 2 soorten producten waar verschillende vergoedingen aan moeten hangen. 
Als er in description 3: 5 staat, moet er 5% over de orderwaarde geteld worden voor de affiliate, oftewel het reguliere leadprogramma 2921. 
Als er in description 3: 10 staat, moet er 10% over de orderwaarde geteld worden voor de affiliate, oftewel leadprogramma 2926. 
**/

UPDATE
	lead
SET lead_program_id = 2926
WHERE
	lead_program_id = 2921 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	description3 LIKE '%10%';
	