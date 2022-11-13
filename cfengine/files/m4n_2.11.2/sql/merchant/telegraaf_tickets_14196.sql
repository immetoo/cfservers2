/* September 7 2010, Dineke, ticket #5874:
 * Reported by Fleur:
 * Kunnen sales  van Telegraaf Tickets 14196   met description 2 =  866   en 826  ook standaard worden afgekeurd
 * Niet enkel morgen (zoals 812) maar altijd?
 * September 16 2010: add a lot of other codes...
 * January 21 2011, Dineke: added 4 more
**/
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	lead_program_id IN (SELECT lead_programs(14196)) AND
	description2 IN (
'1'	, --	RTL Nederland - Tricolores in Concert 2009
'5'	, --	HDC Media - Leidsch Dagblad Stadswandeling
'7'	, --	HDC Media - Haarlems Dagblad IJmuider Courant Winterwandeling
'8'	, --	Relatieplanet
'9'	, --	HDC Media - De Gooi- en Eemlander Winterwandeling
'10'	, --	Pop in je Moerstaal TEST
'11'	, --	Stichting Junior Kamer 's-Gravenhage - NC 2009
'13'	, --	BAD New Beauty/ New Wellness 2009
'14'	, --	BAD New Beauty/ New Welness 2009 7,50
'15'	, --	BAD New Beauty/ New Wellness 10,00
'22'	, --	RTL Nederland - Zeg eens aaaa
'23'	, --	Brand New Life - Pop in je Moerstaal
'24'	, --	BAD Tricolores in Concert BV - Tricolores in Concert 2009
'25'	, --	Thermae 2000 - ABN Amro
'26'	, --	Thermae 2000 - Adecco
'27'	, --	Thermae 2000 - AH
'28'	, --	Thermae 2000 - CAPGEMINI
'29'	, --	Thermae 2000 - CZ
'30'	, --	Thermae 2000 - Deloitte
'31'	, --	Thermae 2000 - Holland Casino
'32'	, --	Thermae 2000 - Delta Lloyd
'34'	, --	Thermae 2000 - Fortis
'35'	, --	Thermae 2000 - Imtech
'36'	, --	Thermae 2000 - ING
'37'	, --	Thermae 2000 - Landal
'38'	, --	Thermae 2000 - Metro
'39'	, --	Thermae 2000 - Postcode Loterij
'40'	, --	Thermae 2000 - Randstad
'41'	, --	Thermae 2000 - SNS Bank
'42'	, --	Thermae 2000 - Sogeti
'43'	, --	Thermae 2000 - TNT
'44'	, --	Thermae 2000 - VGZ
'45'	, --	Thermae 2000 - Vodafone
'46'	, --	Thermae 2000 - Yacht
'47'	, --	Thermae 2000 - Johnson Diversey
'49'	, --	Tricolores in Concert ACTIE
'54'	, --	RTL Nederland - Safaripark Beekse Bergen
'55'	, --	BAD
'56'	, --	RTL Nederland - Stripmuseum Groningen Seizoen 2009
'57'	, --	RTL Nederland - Ecodrome
'58'	, --	RTL Nederland - Dierenrijk
'62'	, --	RTL Nederland - Moviepark Germany
'64'	, --	RTL Nederland - Toverland
'65'	, --	RTL Nederland - Ouwehands 2009
'66'	, --	RTL Nederland - Bobbejaanland
'68'	, --	RTL Nederland - Zuiderzeemuseum
'71'	, --	RTL Nederland - Amsterdam Dungeons
'72'	, --	RTL Nederland - Plopsa de Panne
'77'	, --	Apenheul
'79'	, --	Archeon
'81'	, --	Avifauna
'86'	, --	Dippiedoe
'88'	, --	BAD Drievliet BAD
'91'	, --	BAD
'96'	, --	Linnaeushof
'99'	, --	Neeltje Jans
'100'	, --	NS - VDU trial (E/G)
'102'	, --	Ouwehands
'111'	, --	Bad
'113'	, --	Thermae
'115'	, --	Toverland
'117'	, --	BAD
'119'	, --	Wunderland
'121'	, --	Zuiderzee Museum
'123'	, --	Jetix - Safaripark
'124'	, --	Jetix - Ecodrome
'125'	, --	Jetix - Stripmuseum
'126'	, --	Jetix - Dierenrijk Europa
'127'	, --	Jetix - Amsterdam Dungeons
'128'	, --	Jetix - Zuiderzeemuseum
'129'	, --	Jetix - Plopsaland indoor
'130'	, --	RTL Nederland - Plopsa Coo 2009
'131'	, --	Jetix - Plopsaland Coo
'132'	, --	Jetix - Plopsaland de Panne
'133'	, --	NS - VDU trial (2902G)
'134'	, --	RTL Nederland - Dakar aan Zee 2009
'136'	, --	RTL Nederland -Thermae 2000
'137'	, --	RTL Nederland - Archeon
'138'	, --	RTL Nederland - Aviodrome
'139'	, --	RTL Nederland - Linnaeushof
'140'	, --	Jetix - Aviodrome
'141'	, --	Jetix - Moviepark
'143'	, --	RTL Nederland - Speelland
'144'	, --	Jetix - Speelland Beekse Bergen
'145'	, --	Bad
'146'	, --	Jetix - Deltapark Neeltje Jans
'147'	, --	NS - Dagkaarten 2009
'149'	, --	RTL Nederland - VNU
'151'	, --	Thermae 2000 - Hoteliers
'156'	, --	NS - Lentetoer 2009
'157'	, --	Duinrell 2009
'466'	, --	RTL Nederland - Deltapark Neeltje Jans
'467'	, --	BAD
'485'	, --	RTL Nederland - Duinrell
'486'	, --	Jetix - Duinrell
'488'	, --	Jetix - Deltapark Neeltje Jans
'489'	, --	Wegener - Moviepark Germany
'490'	, --	RTL Nederland - Zwaluwhoeve
'491'	, --	Jetix - Bobbejaanland
'492'	, --	RTL Nederland - House Vision
'493'	, --	Albelli
'494'	, --	Relatiecadeaubon.nl
'495'	, --	Tricolores 2009 - Sligro
'503'	, --	Albelli - Fysieke tickets
'504'	, --	RTL Nederland - Plopsa Indoor
'508'	, --	RTL Nederland - Efteling
'516'	, --	KLM Open 2009
'518'	, --	RTL Nederland - Dancing with the Stars
'521'	, --	RTL Nederland - Drievliet
'523'	, --	Bavaria Open Air 2009
'525'	, --	RTL Nederland - Bavaria Open Air 2009
'529'	, --	RTL Nederland - Masterclass RTL Z
'530'	, --	RTL Nederland - RTL Z Masterclass INLOG
'532'	, --	KLM Open Flying Blue 2=1
'533'	, --	KLM Open Flying Blue gratis
'535'	, --	Tricolores in Concert ACTIE 26 juni
'545'	, --	Ouwehands - NFN
'547'	, --	Variabele Webshop
'595'	, --	RTL Nederland - Ordina Open
'596'	, --	RTL Nederland - RTL Z Masterclass FACTUUR
'597'	, --	Tricolores in Concert - Mijnartiest.nl 26 juni 2009
'599'	, --	Veenpark 2009
'600'	, --	NS - Dagkaart 1e klas (Spannende Boek)
'603'	, --	ING - Safaripark Beekse Bergen
'604'	, --	NS - 3 Maands abonnement (VDU)
'610'	, --	Tricolores in Concert - Reumafonds 26 juni 2009
'612'	, --	NS - Upsell Aanbod 2009
'614'	, --	Tricolores in Concert - 26 juni Examenfeest
'616'	, --	Tricolores in Concert 2009 (eigen site)
'618'	, --	Tricolores in Concert - Banken
'622'	, --	NS - Zomertoer 2009
'623'	, --	Capgemini Consulting (Finance Summit 2009)
'624'	, --	Capgemini Consulting (Finance Summit 2009) - 195 euro
'625'	, --	Jetix - Bries Kids Day
'630'	, --	Jetix - Blokkeractie
'632'	, --	Em Te - Bavaria Open Air 2009
'633'	, --	Thermae 2000 - mailing dagentree actie 22,00
'634'	, --	RTL Nederland - KLM Open
'635'	, --	Lexa - Bavaria Open Air
'637'	, --	RTL Tickets - Over de Kook
'639'	, --	Ticketsplus - Duinrell (affiliate)
'640'	, --	Ticketsplus - Movie Park Germany (affiliate)
'642'	, --	BAD Lexa - Bavaria Open Air (2) BAD
'644'	, --	This is Golf - KLM Open 2009
'645'	, --	VNU Exhibitions - Kreadoe
'646'	, --	NS - Dagkaarten jan/feb 2010
'647'	, --	VNU Exhibitions - Bike Motion
'648'	, --	VNU Exhibitions - Second Home
'649'	, --	VNU Exhibitions - Kampeer & Caravan
'652'	, --	Stichting JCI NC 2010
'653'	, --	Em Te - Bobbejaanland
'658'	, --	Op Hoop van Zegen
'660'	, --	Symphonica in Rosso 2009
'662'	, --	RTL Nederland - Kampeer en Caravan Jaarbeurs
'663'	, --	NS - Dagkaart 1e klas (NL Leest, okt09)
'667'	, --	Toverland - De Limburger
'668'	, --	Toverland - L1
'669'	, --	NS - Dagkaart 2e klas (mrt/ apr 2010)
'671'	, --	Thermae 2000 - Le roi
'678'	, --	BAD
'684'	, --	Toverland - Eind/Brab Dagblad
'685'	, --	Flinterpop
'686'	, --	Ouwehands - Menzis
'689'	, --	Ronde Tafel Benefiet Gala
'690'	, --	Ouwehands Dierenpark - BankGiroLoterij
'691'	, --	Thermae 2000 - Makro
'692'	, --	XtraCold
'694'	, --	RTL Nederland - XtraCold
'699'	, --	Openlucht Museum - Menzis
'700'	, --	NS - BAD Dagkaart 2e klas (mrt/ apr 2010) BAD
'701'	, --	NS - Klantenservice Overgangsbewijzen
'703'	, --	Voetbal Experience
'705'	, --	NS - Overgangsbewijzen 3 periodes
'706'	, --	NS - Dagkaarten Abonnees
'707'	, --	Toverland - Concentra
'708'	, --	Toverland - Rheinische Post
'709'	, --	Toverland - Omroep Brabant
'710'	, --	Thermae 2000 - Flora Holland
'711'	, --	Thermae 2000 - KPN
'712'	, --	Thermae 2000 - Atos Origin
'713'	, --	Thermae 2000 - AON 3
'714'	, --	Thermae 2000 - Achmea
'715'	, --	VNU Exhibitions - Vakantiebeurs
'716'	, --	Thermae - Duitse shop (mailingen/ advertenties)
'717'	, --	Thermae 2000 - Mercedes Benz
'718'	, --	Thermae 2000 - UIC
'719'	, --	Thermae 2000 - DHL
'721'	, --	NS - Dagkaarten Niet - Abonnees
'722'	, --	RTL Nederland - VNU Exhibitions Vakantiebeurs
'723'	, --	Happinez
'726'	, --	123zend.nl
'727'	, --	Toverland - Omroep Gelderland
'728'	, --	VNU Exhibitions - MOTORbeurs Utrecht 2010
'729'	, --	Thermae 2000 - Dagentree 18 euro NL
'730'	, --	Thermae 2000 - Dagentree 18 euro BE
'732'	, --	NC 2010 - Club van 100/ Masterclasses
'733'	, --	NS - Maastricht actie 20 euro
'734'	, --	NS - Maastricht actie 3 euro
'735'	, --	NS - Maastricht actie 12,50 euro
'739'	, --	RTL Nederland - Wunderland Kalkar
'740'	, --	Jetix - Wunderland
'743'	, --	Bavaria Open Air 2010 - JUMBO
'746'	, --	Holland Casino
'747'	, --	Thermae 2000 - B-Bridge
'748'	, --	Thermae 2000 - Axa
'766'	, --	Holland Casino cash sale - Amsterdam
'767'	, --	Holland Casino cash sale - Breda
'768'	, --	Holland Casino cash sale - Eindhoven
'769'	, --	Holland Casino cash sale - Enschede
'770'	, --	Holland Casino cash sale - Groningen
'771'	, --	Holland Casino cash sale - Leeuwarden
'772'	, --	Holland Casino cash sale - Nijmegen
'773'	, --	Holland Casino cash sale - Rotterdam
'774'	, --	Holland Casino cash sale - Scheveningen
'775'	, --	Holland Casino cash sale - Schiphol Airport
'776'	, --	Holland Casino cash sale - Utrecht
'777'	, --	Holland Casino cash sale - Valkenburg
'778'	, --	Holland Casino cash sale - Venlo
'779'	, --	Holland Casino cash sale - Zandvoort
'780'	, --	Bavaria Open Air 2010
'782'	, --	RTL Nederland - Plopsa Indoor Coevorden
'783'	, --	Jetix - Plopsa Indoor Coevorden
'784'	, --	RTL Nederland -Thermae 2000 (actie)
'791'	, --	VOETBALEXPO
'796'	, --	SpitsTickets - Bavaria Open Air
'806'	, --	SpitsTickets - ZAND
'810'	, --	Bavaria Open Air - ACTIE 2010
'811'	, --	NS - Dagkaart actie 2e klas mei 2010
'813'	, --	Jetix - Smoeltjes
'814'	, --	Thermae 2000 - NVD
'815'	, --	KLM Open 2010
'817'	, --	Van Lanschot Senior Open
'818'	, --	NS - Spannende boek 1e klas mei 2010
'819'	, --	RTL Nederland - Dit was het nieuws
'821'	, --	test HC
'826'	, --	KLM Open 2010 Flying Blue Elite
'827'	, --	KLM Open 2010 Flying Blue Silver Gold
'833'	, --	SpitsTickets - Indoor Skydive
'834'	, --	RTL Nederland - Indoor Skydive
'835'	, --	De Efteling - Joris en De Draak
'843'	, --	Holland Casino - Try Out pakket
'845'	, --	Benefiet 5 september 2010
'847'	, --	VIP Try Out
'848'	, --	Go out Try Out
'849'	, --	Magazine Try Out
'850'	, --	Wegener - Safaripark Beekse Bergen
'851'	, --	Wegener - Bavaria Open Air 2010
'852'	, --	Bavaria Open Air - Veronica
'854'	, --	Spits - Skidome
'855'	, --	RTLTickets - Skidome
'856'	, --	Holland Casino - try out 2
'866'	, --	Emesa - Safaripark Beekse Bergen
'867'	, --	RTL tickets - Dierenpark Emmen
'870'	, --	Thermae 2000 - MGL
'871'	, --	NS - 2-persoons Dagkaart 8 sept 2010
'872'	, --	KLM Open 2010 - Golf Weekly'
'888'	, --	4 more numbers added January 2011 (requested by Fleur)
'925'	, --	...
'893'	, --	...
'894'	 --	...
) AND
	status IN ('TO_BE_APPROVED', 'ACCEPTED', 'ON_HOLD') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false); 

/* July 29th 2010, Jan, ticket: #5606
Adverteerder: telegraaf tickets
ID Adverteerder: 14196

Welk type staffel is het (maak 1 keuze)?
Special deal

Affiliate:  sizlsizl 630

Wat moet er precies gebeuren?
Affiliate krijgt standaard de hogere staffel   

3161 > 4663

Startdatum:29-7-2010
Einddatum: NVT
*/
UPDATE
	lead
SET
	lead_program_id = 4663
WHERE
	lead_program_id = 3161 AND
	affiliate_id = 630 AND
	created >= '2010-07-29' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);