/* September 28 2010, Jan, ticket: #5957
Kan jij voor fbto de volgende staffel inregelen.

leadprogramma's

2225 naar 3276
2274 naar 4819
1199 naar 4820

periode is 27 september tot 1 november

affiliates:

	Cendris

71 www.xgratis.nl
105 EuroClix
112 TestNet
128 www.gratiz.nl
307 MoneyMiljonair
323 www.allesvoorniks.nl
327 Zalgeld internet services
2174 Digimo Media
2253 www.Gratis.nl
3812 www.gamie.nl
4318 Scoot Media
5486 Martijn Pronk
5575 zinngeld.nl
6625 Spaarbron
6387 Prijsvergelijk
6678 RONIS Internetdiensten
6948 Werksite
7718 8euromail
7723 181279
7732 goudbrief
8350 Vrijheidspers
9490 Clansman
9592 ippies.nl
10059 Kingolotto
10101 Maildirect
10134 www.elkedaggratis.nl
10708 Onedream
11343 Planet49
11524 info@jiggy.nl
11690 Zero Condooms
11805 ecpull_nl_m4n
11970 Ladymail
12307 Shopkorting
12359 Yonego
13067 expull_be_m4n
13285 Moneymiljonair website
13328 Crazy
13576 Wij
13894 Kaartenhuis
14878 DMG
14881 Modation
15208 www.gratis.com
16712 EDM Media
17061 MailGarage
17069 Jiggy Website
17075 Ad Salsa
17162 Permission
19610 Beverly Hills Edition
19777 Techno Design
20129 EuroClixBE
21271 Imailo
21461 RTL
21578 www.gratisenvoorniks.nl
*/

-- 2225 naar 3276
UPDATE
	lead 
SET
	lead_program_id = 3276
WHERE
	lead_program_id = 2225 AND
	affiliate_id IN (
		71,-- www.xgratis.nl
		105,-- EuroClix
		112,-- TestNet
		128,-- www.gratiz.nl
		307,-- MoneyMiljonair
		323,-- www.allesvoorniks.nl
		327,-- Zalgeld internet services
		2174,-- Digimo Media
		2253,-- www.Gratis.nl
		3812,-- www.gamie.nl
		4318,-- Scoot Media
		5486,-- Martijn Pronk
		5575,-- zinngeld.nl
		6625,-- Spaarbron
		6387,-- Prijsvergelijk
		6678,-- RONIS Internetdiensten
		6948,-- Werksite
		7718,-- 8euromail
		7723,-- 181279
		7732,-- goudbrief
		8350,-- Vrijheidspers
		9490,-- Clansman
		9592,-- ippies.nl
		10059,-- Kingolotto
		10101,-- Maildirect
		10134,-- www.elkedaggratis.nl
		10708,-- Onedream
		11343,-- Planet49
		11524,-- info@jiggy.nl
		11690,-- Zero Condooms
		11805,-- ecpull_nl_m4n
		11970,-- Ladymail
		12307,-- Shopkorting
		12359,-- Yonego
		13067,-- expull_be_m4n
		13285,-- Moneymiljonair website
		13328,-- Crazy
		13576,-- Wij
		13894,-- Kaartenhuis
		14878,-- DMG
		14881,-- Modation
		15208,-- www.gratis.com
		16712,-- EDM Media
		17061,-- MailGarage
		17069,-- Jiggy Website
		17075,-- Ad Salsa
		17162,-- Permission
		19610,-- Beverly Hills Edition
		19777,-- Techno Design
		20129,-- EuroClixBE
		21271,-- Imailo
		21461,-- RTL
		21578, -- www.gratisenvoorniks.nl
		21539 -- Mailmedia
	) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = FALSE) AND
	created >= '2010-09-27' AND
	created < '2010-11-01';
	
-- 2274 naar 4819
UPDATE
	lead 
SET
	lead_program_id = 4819
WHERE
	lead_program_id = 2274 AND
	affiliate_id IN (
		71,-- www.xgratis.nl
		105,-- EuroClix
		112,-- TestNet
		128,-- www.gratiz.nl
		307,-- MoneyMiljonair
		323,-- www.allesvoorniks.nl
		327,-- Zalgeld internet services
		2174,-- Digimo Media
		2253,-- www.Gratis.nl
		3812,-- www.gamie.nl
		4318,-- Scoot Media
		5486,-- Martijn Pronk
		5575,-- zinngeld.nl
		6625,-- Spaarbron
		6387,-- Prijsvergelijk
		6678,-- RONIS Internetdiensten
		6948,-- Werksite
		7718,-- 8euromail
		7723,-- 181279
		7732,-- goudbrief
		8350,-- Vrijheidspers
		9490,-- Clansman
		9592,-- ippies.nl
		10059,-- Kingolotto
		10101,-- Maildirect
		10134,-- www.elkedaggratis.nl
		10708,-- Onedream
		11343,-- Planet49
		11524,-- info@jiggy.nl
		11690,-- Zero Condooms
		11805,-- ecpull_nl_m4n
		11970,-- Ladymail
		12307,-- Shopkorting
		12359,-- Yonego
		13067,-- expull_be_m4n
		13285,-- Moneymiljonair website
		13328,-- Crazy
		13576,-- Wij
		13894,-- Kaartenhuis
		14878,-- DMG
		14881,-- Modation
		15208,-- www.gratis.com
		16712,-- EDM Media
		17061,-- MailGarage
		17069,-- Jiggy Website
		17075,-- Ad Salsa
		17162,-- Permission
		19610,-- Beverly Hills Edition
		19777,-- Techno Design
		20129,-- EuroClixBE
		21271,-- Imailo
		21461,-- RTL
		21578, -- www.gratisenvoorniks.nl
		21539 -- Mailmedia
	) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = FALSE) AND
	created >= '2010-09-27' AND
	created < '2010-11-01';

-- 1199 naar 4820
UPDATE
	lead 
SET
	lead_program_id = 4820
WHERE
	lead_program_id = 1199 AND
	affiliate_id IN (
		71,-- www.xgratis.nl
		105,-- EuroClix
		112,-- TestNet
		128,-- www.gratiz.nl
		307,-- MoneyMiljonair
		323,-- www.allesvoorniks.nl
		327,-- Zalgeld internet services
		2174,-- Digimo Media
		2253,-- www.Gratis.nl
		3812,-- www.gamie.nl
		4318,-- Scoot Media
		5486,-- Martijn Pronk
		5575,-- zinngeld.nl
		6625,-- Spaarbron
		6387,-- Prijsvergelijk
		6678,-- RONIS Internetdiensten
		6948,-- Werksite
		7718,-- 8euromail
		7723,-- 181279
		7732,-- goudbrief
		8350,-- Vrijheidspers
		9490,-- Clansman
		9592,-- ippies.nl
		10059,-- Kingolotto
		10101,-- Maildirect
		10134,-- www.elkedaggratis.nl
		10708,-- Onedream
		11343,-- Planet49
		11524,-- info@jiggy.nl
		11690,-- Zero Condooms
		11805,-- ecpull_nl_m4n
		11970,-- Ladymail
		12307,-- Shopkorting
		12359,-- Yonego
		13067,-- expull_be_m4n
		13285,-- Moneymiljonair website
		13328,-- Crazy
		13576,-- Wij
		13894,-- Kaartenhuis
		14878,-- DMG
		14881,-- Modation
		15208,-- www.gratis.com
		16712,-- EDM Media
		17061,-- MailGarage
		17069,-- Jiggy Website
		17075,-- Ad Salsa
		17162,-- Permission
		19610,-- Beverly Hills Edition
		19777,-- Techno Design
		20129,-- EuroClixBE
		21271,-- Imailo
		21461,-- RTL
		21578, -- www.gratisenvoorniks.nl
		21539 -- Mailmedia
	) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = FALSE) AND
	created >= '2010-09-27' AND
	created < '2010-11-01';
	
/* June 21 2010, Jan, ticket: #5383
kan jij jwalker83 (14601) toevoegen aan de special deal reizen bij fbto (7485)
dus 1195 naar 3095
Dit mag per vanochtend 21 juni.
June 22 2010, Jan, added besteconsumentenkoop (9181) to the deal
June 23 2010, Jan, added 19610 beverly hills to the deal
*/
UPDATE
	lead 
SET
	lead_program_id = 3095
WHERE
	lead_program_id = 1195 AND
	affiliate_id IN (14601, 9181, 19610) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = FALSE) AND
	click_created >= '2010-06-21';


/* 31 August 2009, Dineke:
Special deal mailing parties
September 17 2009, Dineke:
Add following users:
6404	priceboy
6622	quickad
327		zzakgeld internet services
7723	181279
6678	ronisonline
7284	vbwemmedia
8281	jakko
8098	cospa
9869	18mbakx
12644	cashen
7718	8euromail
7732	goudbrief
163		e-marketings
5486	martijn pronk
4501	topeuro
11970	ladymail
**/

UPDATE
	lead 
SET
	lead_program_id = 3276
WHERE
	lead_program_id IN (2225, 1199, 2274) AND
	affiliate_id IN (	105,	--euroclix
						307,	--moneymiljonair
						5575, 	--zinngeld
						11524, 	--jiggy
						13972,	--VisaVisMarketing
						6404,	--priceboy
						6622,	--quickad
						327,	--zzakgeld internet services
						7723,	--181279
						6678,	--ronisonline
						7284,	--vbwemmedia
						8281,	--jakko
						8098,	--cospa
						9869,	--18mbakx
						12644,	--cashen
						7718,	--8euromail
						7732,	--goudbrief
						163,	--e-marketings
						5486,	--martijn pronk
						4501,	--topeuro
						11970,	--ladymail
						11582	--88denb
					) AND
	payment_period_id IN (select id from payment_period where processed = false) AND
	click_created < '2009-12-01';

/* October 19 2009, Dineke
Reported by Bart, same day:
Special deal for same mailing parties: lead_program 1193 becomes 3476, starting October 18th
--September 3, Dineke, Requested by Tim: added some more affiliates
--September 6 2010, Jan, Requested by Bart: added crazy(13328) to the deal
**/
UPDATE
	lead 
SET
	lead_program_id = 3476
WHERE
	lead_program_id = 1193 AND
	affiliate_id IN (	105, --EuroClix
112, --Remco TestNet
163, --e-Markethings
307, --MoneyMiljonair
327, --zakgeld internet services
2174, --Digimo Media
4318, --Scoot Media
4501, --topeuro
5486, --Martijn Pronk
5575, --zinngeld.nl
6387, --prijsvergelijk
6404, --priceboy
6622, --Quickad
6678, --RONIS Internetdiensten
6948, --werksite
7284, --VBWEBMEDIA
7718, --8euromail
7723, --181279
7732, --goudbrief
8098, --cospa
8281, --jakko
8350, --vrijheidspers
9490, --Clansman Email Media
9869, --18mbakx
10059, --kingolotto
10101, --netdirect
10708, --Onedream
11343, --PLANET4911343
11524, --info@jiggy.nl
11582, --88denb
11690, --info@zerocondooms.nl
11805, --ecpull_nl_m4n
11970, --Ladymail 
12307, --Shopkorting.nl
12359, --j.jacobs
12644, --cashen
13285, --Money Miljonair Website
13328, --crazy
13576, --babyinfo
13972, --VisaVisMarketing
14878, --DMG01
14881, --moda12
14920, --glenzoeteweij
16712, --EDMMedia emailmarketing
17061, --Media Inkoop - Intense Media
17069, --Jiggy Website
17075, --adsalsa
17162, --actieplein
19610, --BeverlyHills
19777, --Techno Design
21271, --imailo
21461 --rtl
	) AND
	payment_period_id IN (select id from payment_period where processed = false) AND
	created BETWEEN '2010-09-06' AND '2010-10-05';
	
/* November 12 2009, Dineke
Reported by Bart, same day:
Special deal for same mailing parties: lead_program 2212 becomes 3604, starting November 1st
November 19 2009, Dineke
Reported by Bart, November 18th:
Add these affiliates to the deal:
* 13158    Simon jorritsma
* 128     Gratiz
* 16752    Entree
* 1332      Zorgverzekering

November 26, 2009, Jan, ticket: #4309
Reported by Bart
Add Shopkorting (12307) and Finance (4382) to the deal

December 18, 2009, Jan, ticket: #4399
Reported by Bart
Added schwaanhuyser(17176) to the deal
*/
UPDATE
	lead 
SET
	lead_program_id = 3604
WHERE
	lead_program_id = 2212 AND
	affiliate_id IN (	105,	--euroclix
						307,	--moneymiljonair
						5575, 	--zinngeld
						11524, 	--jiggy
						6404,	--priceboy
						6622,	--quickad
						327,	--zzakgeld internet services
						7723,	--181279
						6678,	--ronisonline
						7284,	--vbwemmedia
						8281,	--jakko
						8098,	--cospa
						9869,	--18mbakx
						12644,	--cashen
						7718,	--8euromail
						7732,	--goudbrief
						163,	--e-marketings
						5486,	--martijn pronk
						4501,	--topeuro
						11970,	--ladymail
						11582,	--88denb
						13972,	--VisaVisMarketing
						11805,	--ec_pull
						11851,	--m4n_mediainkoop
						7262,	--Klikmedia
						14878,	--DMG
						16712,	--EDM
						13158,  --Simon jorritsma
						128,	--Gratiz
						16752,  --Entree
						1332,   --Zorgverzekering
						9897,	--Homefinance
						12307,  --Shopkorting
						4382,	--Finance
						17176 	--schwaanhuyser
					) AND
	payment_period_id IN (select id from payment_period where processed = false) AND
	created > '2009-11-01' AND
	created < '2010-05-10';

/* January 20th 2011, Jan, ticket: #6610
Kan jij bij FBTO voor affiliate jwalker83(14601) en jwalker84(23156) alles leads op 1199 laten landen op 4856.
Dit mag per vandaag!
*/

UPDATE
	lead 
SET
	lead_program_id = 4856
WHERE
	lead_program_id = 1199 AND
	affiliate_id IN (14601, 23156) AND
	payment_period_id IN (select id from payment_period where processed = false) AND
	created >= '2011-01-19';