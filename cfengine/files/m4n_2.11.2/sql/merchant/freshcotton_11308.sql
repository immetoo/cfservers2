/*
 * FreshCotton
 */
 
 /* February 19 2009, Dineke:

	2093 	13% vergoeding voor 10+ sales per maand 	
	2077 	10% vergoeding tot 10 sales per maand
   
    Updated due to ticket #3755 to exclude month of September.

October 27 2009, Dineke: highest tier stops 1st of November!

July 28 2010, Jan: Removed the unused highest tier and changed second tier from 10-20 to 10+ leads per month
*/
 
UPDATE lead SET 
    lead_program_id = 2093
    WHERE status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
    		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    		lead_program_id IN (2077, 2094) AND
    		created not between '2009-09-01' and '2009-10-01' AND
    		affiliate_id IN (SELECT affiliate_id FROM lead WHERE lead_program_id IN (2077, 2093, 2094) AND
    							status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND payment_period_id IN  (SELECT id FROM payment_period WHERE processed = false)
    							GROUP BY affiliate_id HAVING COUNT(id) >= 10);
    							
   							
/* April 6 2009, Dineke
No-search accounts count together for the staffel.

No search accounts:
AEM SEA account (3144)
ELF Snijder (6059)
Elise (9076)
Erotiek (5223)
Fashionchick.nl (8880)
GSM-Guru (4322)
Kittie (9070)
Kleding-goedkoop.nl (4996)
Postorderaars.nl (3893)
Sportyschoenen.nl (10184)
Startkabeldochters (710)
Startveld-GSM/PC (6019)
Studie.fm (4382)
toppers (9405)
VakantieBoyz (5087)
Viastart.nl (2160)
welovewinter (9404)
www.Startveld.nl (774)
XXLmaten (8582)
Zoeka.nl (6581)
Welovesites (9070)

Updated due to ticket #3755 to exclude month of September.
*/

UPDATE lead SET 
    lead_program_id = 2093
    WHERE status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
    		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    		lead_program_id IN (2077, 2094) AND
    		created not between '2009-09-01' and '2009-10-01' AND
    		affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)	AND 
    		(SELECT COUNT(*) FROM lead WHERE lead_program_id IN (2094, 2077, 2093) AND
										status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
										affiliate_id IN (3144, 6059, 9076, 5223, 8880, 4322, 9070, 4996, 3893, 10184, 710, 6019, 4382, 9405, 5087, 2160, 9404, 774, 8582, 6581, 9070)
		) >= 10;


