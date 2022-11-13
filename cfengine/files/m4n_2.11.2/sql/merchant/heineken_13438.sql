 /* April 27 2009, Dineke:

Dit is een verzoek die niet logisch is in een staffel formulier. Het gaat om het volgende:

Voor Heineken willen we de mailpublishers anders belonen dan de websites.  We hebben drie lead ID’s

Click na landingspagina: 2881
Vergoeding mailpublishers: 2877
Vergoeding websites: 2870

Om die rede wil ik vragen of de mailpublishers met de onderstaande ID’s uit kan sluiten van de click vergoeding met ID 2881 
door middel van een automatische afkeuring van die leads iedere dag.

Daarnaast hebben we alleen de website lead op de bedankpagina dus wil ik ook vragen of we voor onderstaande ID’s automatisch
Lead voor mailpublishers met nummer 2877 kunnen zetten in plaats van 2870.

MoneyMiljonair (307)
EuroClix (105)
8euromail (7718)
181279 (7723)
VBWEBMEDIA (7284)
zinngeld.nl (5575)
ronisonline (6678)
jakko (8281)
zakgeld internet services (327)
De Heus (4318)
info@jiggy.nl (11524)
18mbakx (9869)
goudbrief (7732)
kingolotto (10059)
ecpull_nl_m4n (11805)
e-Markethings (163)
Martijn Pronk (5486)
goudkliks (11224)
spaarbron (6625)
voorniets (4501)
gamie (3812)
vpvpaffiliate (4601)
ippies.nl (9592)
vrijheidspers (8350)
*/

UPDATE lead SET lead_program_id = 2877 WHERE
	lead_program_id = 2870 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (	307,  --moneymiljonair
						105,  --EuroClix
						7718, --8euromail
						7723, --181279
						7284, --VBWEBMEDIA
						5575, --zinngeld.nl
						6678, --ronisonline
						8281, --jakko
						327,  --zakgeld internet services
						4318, --De Heus
						11524,--info@jiggy.nl
						9869, --18mbakx
						7732, --goudbrie
						10059,--kingolotto
						11805,--ecpull_nl_m4n
						163,  --e-Markethings
						5486, --Martijn Pronk
						11224,--goudkliks
						6625, --spaarbron
						4501, --voorniets
						3812, --gamie
						4601, --vpvpaffiliate
						9592, --ippies.nl
						8350  --vrijheidspers
					  );
					  
UPDATE lead SET status = 'REJECTED' WHERE
	lead_program_id = 2881 AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (	307,  --moneymiljonair
						105,  --EuroClix
						7718, --8euromail
						7723, --181279
						7284, --VBWEBMEDIA
						5575, --zinngeld.nl
						6678, --ronisonline
						8281, --jakko
						327,  --zakgeld internet services
						4318, --De Heus
						11524,--info@jiggy.nl
						9869, --18mbakx
						7732, --goudbrie
						10059,--kingolotto
						11805,--ecpull_nl_m4n
						163,  --e-Markethings
						5486, --Martijn Pronk
						11224,--goudkliks
						6625, --spaarbron
						4501, --voorniets
						3812, --gamie
						4601, --vpvpaffiliate
						9592, --ippies.nl
						8350  --vrijheidspers
					  );
					  
