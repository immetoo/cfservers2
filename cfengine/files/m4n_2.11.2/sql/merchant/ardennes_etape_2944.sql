/* #4783 April 2 2010, Dineke:
 * Requested by Wouter S.:
	Reject clicks from these affiliates:
 -          Winkelpower 	52
 -          79 denuz	14588
 -          Vrijheidspers	8350
 -          Symbaloo	9610
 -          Mp3speed	198
 -          Martindex	6692
 -          Jiggy website	17069
 -          Ingrid	10906
 -          Copyfile	12976
 -          Bergen 1965	16428
 -          Shlatman	11369
 -          Knutselen ( met uitzondering van de sites : vakantie.101tips.nl & uit.101tips.nl) 	861
 - 			Reisadvies (22204): reject per October 7th
And move all clicks from affiliate 11810 to adid 674403
--April 20 2010, Dineke:
Requested by Wouter S.:
affiliate ekert (12187) mag alleen kliks versturen vanaf 
> http://www.winkelkraam.nl/advertenties/vakanties_en_toerisme/ voor 
> Ardennes-Etape (*2944)*
**/
UPDATE
	click
SET
	status = 'REJECTED'
WHERE
	merchant_id = 2944 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED' AND
	(	affiliate_id IN (	52,    --Winkelpower
							14588, --79 denuz
							8350,  --Vrijheidspers
							9610,  --Symbaloo
							198,   --Mp3speed
							6692,  --Martindex
							17069, --Jiggy website
							10906, --Ingrid
							12976, --Copyfile
							16428, --Bergen 1965
							11369, --Shlatman
							22204) --Reisadvies
	OR
		--861: Knutselen ( met uitzondering van de sites : vakantie.101tips.nl & uit.101tips.nl)
		affiliate_id = 861 AND (referrer NOT LIKE ('%vakantie.101tips.nl%') AND referrer NOT LIKE ('%uit.101tips.nl%'))
	OR
		--ekert (12187) mag alleen kliks versturen vanaf http://www.winkelkraam.nl/advertenties/vakanties_en_toerisme/
		affiliate_id = 12187 AND (referrer NOT LIKE ('%www.winkelkraam.nl/advertenties/vakanties_en_toerisme%'))
	) AND
	created > '2010-10-07';

--move all clicks from affiliate 11810 to adid 674403
UPDATE 
	click
SET
	advertisement_id = 674403
WHERE
	merchant_id = 2944 AND
	affiliate_id = 11810 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status = 'ACCEPTED';
