/* September 3 2009, #3763
Special deal Mickey123
Zou je de affiliate Mickey123 (id= 11015) in de volgende leadprogrammma willen laten vallen vanaf vandaag?? Leadprogramma: 3274
Dat is voor de adverteerde betaalde mails en geldt voor alle leads die door deze affiliate worden gezet voor deze adverteerder vanaf woensdag 2 september.
*/
UPDATE
	lead
SET
	lead_program_id = 3274
WHERE
	affiliate_id = 11015 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 7723 AND id != 3274) AND
	created > '2009-09-02';