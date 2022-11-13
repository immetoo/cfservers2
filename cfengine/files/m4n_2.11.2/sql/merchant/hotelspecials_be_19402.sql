/* #4767, March 29 2010, Dineke new staffel (similar to hotelspecials_2408):
Aanvrager: Fleur

Adverteerder: Hotelspecials.be
ID Adverteerder: 19402

Welk type staffel is het (maak 1 keuze)?
2)echte staffel

Wat moet er precies gebeuren?
4104 à 4101 à 4102 à 4103

4104: 0-10 boekingen
4101: 11-40 boekingen
4102: 41-74 boekingen
4103: 75+ boekingen

Startdatum: 26-3-2010
Einddatum: NVT
*/
--4101: 11-40 boekingen
UPDATE 
    lead
SET 
    lead_program_id = 4101 
WHERE 
	lead_program_id IN (4104) AND 
	status = 'ACCEPTED' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND  
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
	    FROM 
		    lead
		WHERE 
		    lead_program_id IN (4104, 4101, 4102, 4103) AND 
		    status = 'ACCEPTED' AND 
		    click_created < '2011-01-01' AND
		    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)   		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 11 AND 40
	);
	
--4102: 41-74 boekingen
UPDATE 
    lead
SET 
    lead_program_id = 4102
WHERE 
	lead_program_id IN (4104, 4101) AND 
	status = 'ACCEPTED' AND 
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND  
	click_created < '2011-01-01' AND
	affiliate_id IN (
		SELECT
			affiliate_id
	    FROM 
		    lead
		WHERE 
		    lead_program_id IN (4104, 4101, 4102, 4103) AND 
		    status = 'ACCEPTED' AND 
		    click_created < '2011-01-01' AND
		    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)   		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) BETWEEN 41 AND 74
	);

--4103: 75 boekingen and up
UPDATE 
    lead
SET 
    lead_program_id = 4103 
WHERE 
	lead_program_id IN (4104, 4101, 4102) AND 
	status = 'ACCEPTED' AND 
	click_created < '2011-01-01' AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND  
	affiliate_id IN (
		SELECT
			affiliate_id
	    FROM 
		    lead
		WHERE 
		    lead_program_id IN (4104, 4101, 4102, 4103) AND 
		    status = 'ACCEPTED' AND 
		    click_created < '2011-01-01' AND
		    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false)   		
		GROUP BY 
			affiliate_id 
		HAVING 
			COUNT(id) >= 75
	);