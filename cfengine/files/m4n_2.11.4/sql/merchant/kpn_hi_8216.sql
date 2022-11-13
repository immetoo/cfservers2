/* Dineke, February 8 2011, Ticket #6726:
 * Reported by Patrick Emmen

Zou je de leads die binnenkomen op LP: 2998 willen zetten op special deal LP:3451
Het gaat hierbij om afiliate Webaholics ID: 13435 

Looptijd: 6 maanden
*/
UPDATE
	lead
SET
	lead_program_id = 3451
WHERE
	lead_program_id = 2998 AND
	affiliate_id = 13435 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created < '2011-08-08';
	
/* Special deal Vrijheidspers (8350) + carob (9009) --> programma 2 met mogelijkheid tot doorgroeien, voor 2-jarig */
UPDATE 
    lead 
SET 
    lead_program_id = 3450
WHERE 
	lead_program_id = 2998 AND 
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (9009, 8350);
	
/* Special deal Search Factory (12796), Dekatoo (11315) and Martijn (578) --> programma 3 met mogelijkheid tot doorgroeien, voor 2-jarig */
--2-jarig:
UPDATE 
    lead 
SET 
    lead_program_id = 3451
WHERE 
	lead_program_id IN (2998, 3450) AND 
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (12796, 11315, 578);

/* October 12 2010, Dineke, Ticket #6026:
	Requested by Patrick
	Reject leads from these affiliates, starting October 7th.
*/
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	lead_program_id IN (SELECT lead_programs(8216)) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	status IN ('ACCEPTED', 'TO_BE_APPROVED') AND
	affiliate_id IN (--b9index
					16890,
					--carob
					9009,
					--nielshelms2
					5301,
					--digitalminds
					14847,
					--zpvnuenen
					8648,
					--kingolotto	
					10059,
					--sitepromotie16762
					16762,
					--dominiquehouten@hotmail.com
					21246,
					--BertvdG
					20993,
					--faqtman
					19356,	
					--geldquiz
					531,
					--gratis.nl
					2253,
					--info@yunoo.nl
					11806,
					--Paul Bakker
					14323,
					--michael!
					8577,
					--midsol
					8106,
					--Zoverdiend
					12012,
					--SBS6voordeel
					16755,
					--Postordermode
					13800) AND
	created > '2010-10-07';