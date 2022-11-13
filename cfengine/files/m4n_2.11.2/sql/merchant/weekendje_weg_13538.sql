/* July 23 2010, Dineke ticket #5579:
 * TODO: can be added to deal below when this period has passed!
 * Aanvrager: Fleur

> > Welk type staffel is het (maak 1 keuze)?
> > Special deal

> > Affiliate:  vanzon 7902
> > Wat moet er precies gebeuren?
> > 
> > Affiliate krijgt standaard de hoogste staffel (3170)
> > 
> > Startdatum: 23-7-2010
> > Einddatum: 23-7-2011
*/
UPDATE
	lead
SET
	lead_program_id = 3170
WHERE
	lead_program_id IN (2900, 2902, 2903) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (7902) AND
	created > '2010-07-23';
	
/*April 29 2010, Dineke, Ticket #4917
 * Aanvrager: Fleur

Welk type staffel is het (maak 1 keuze)?

Special deal

Affiliate:  hansrinsma (5133)
            caroline (8480)

Wat moet er precies gebeuren?
Affiliates krijgt standaard de hogere staffel (3170)

Startdatum: 28-4-2010
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 3170
WHERE
	lead_program_id IN (2900, 2902, 2903) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (5133, 8480) AND
	created > '2010-04-28';
	
/* December 30, Dineke:
Aanvrager: Wouter
Adverteerder: Weekendjeweg.nl
ID Adverteerder: 13538

Exploitanten (in geval van special deal. Username + id): 
> sizlsizl (630)

Welk type staffel is het (maak 1 keuze)?
2) Special deal

Lead programma's ID of advertentie ID (oud en nieuw):  2900 > 3170
Graag de leads van dit account koppelen een lpid 3170, ook nog van de maand december.

Startdatum: 01-12-2009
Einddatum:01-12-2010

Update: January 27 2011, Jan, removed end-date from deal.
*/
UPDATE
	lead
SET
	lead_program_id = 3170
WHERE
	affiliate_id = 630 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2900, 2902, 2903) AND
	created >= '2009-11-30';
	
/** September 29 2009, Dineke, ticket #3939

Aanvrager: Wouter
Adverteerder: Weekendjeweg.nl ID Adverteerder: 13538

Welk type staffel is het (maak 1 keuze)?
1) echte staffel

Lead programma's ID of advertentie ID (oud en nieuw): 2900 > 2903

Wat moet er precies gebeuren?

Weekendjeweg.nl is een nieuwe adverteerder. 
Om een aantal grotere affiliates te motiveren om het programma op te nemen hebben we die standaard een hogere vergoeding aangeboden 
ipv meedraaien met de staffel, voor een periode van 2 maanden.

De standaard staffel is:
Segment	Sales p/m	Vergoeding	lpid
Standaard	0 -10	5%	2900
Brons	11 - 40		6%	2902
Zilver	41 -74		7%	2903
Goud	75+			8%	3170


**/

UPDATE lead SET lead_program_id = 2902
	WHERE lead_program_id = 2900 AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			affiliate_id IN (SELECT affiliate_id
								FROM lead
								WHERE lead_program_id IN (2900, 2902, 2903, 3170) AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										click_created < '2011-01-01' AND
										status = 'ACCEPTED'
								GROUP BY affiliate_id HAVING count(id) BETWEEN 11 AND 40
							);
			
UPDATE lead SET lead_program_id = 2903
	WHERE lead_program_id IN (2900, 2902) AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			affiliate_id IN (SELECT affiliate_id
								FROM lead
								WHERE lead_program_id IN (2900, 2902, 2903, 3170) AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										click_created < '2011-01-01' AND
										status = 'ACCEPTED'
								GROUP BY affiliate_id HAVING count(id) BETWEEN 41 AND 74
							);
							
UPDATE lead SET lead_program_id = 3170
	WHERE lead_program_id IN (2900, 2902, 2903) AND
			status = 'ACCEPTED' AND
			payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
			click_created < '2011-01-01' AND
			affiliate_id IN (SELECT affiliate_id
								FROM lead
								WHERE lead_program_id IN (2900, 2902, 2903, 3170) AND
										payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										click_created < '2011-01-01' AND
										status = 'ACCEPTED'
								GROUP BY affiliate_id HAVING count(id) >= 75
							);

/* September 29 2009, Dineke
Aanvrager: Wouter
Welk type staffel is het (maak 1 keuze)?
2) Special deal + 
De affiliates hieronder hebben we aangeboden in het zilver segment te plaatsen, allemaal met een aparte startdatum waarop de periode van 2 maanden ingaat:
Ps. bij meer dan 75 sales geldt uiteraard alsnog het gouden segment van 8%

Aanvrager: Wouter
jeskes (848) - from 30-11-2009 until 01-07-2010

May 31 2010, Dineke:
add affiliate vanzon 7902:
Voor 2 maanden leads standaard naar Zilver (41 -74):  lpid 2903. Bij meer dan 75 sales geldt alsnog het gouden segment van 8%
*/
UPDATE
	lead
SET
	lead_program_id = 2903
WHERE
	lead_program_id IN (2900, 2902) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	(
	  (affiliate_id = 848 AND created BETWEEN '2009-11-30' AND '2010-07-01') OR
	  (affiliate_id = 7902 AND created BETWEEN '2009-05-01' AND '2010-07-01')
	);
	