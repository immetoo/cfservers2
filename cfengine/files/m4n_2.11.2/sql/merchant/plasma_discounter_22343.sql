/* Oktober 5 2010, Arjan, ticket #6007
Adverteerdersaccount Plasma-Discounter ID 22343

Graag zou ik een special deal willen voor besteconsumentenkoop (9181) en Plasma-Discounter (22343),
Indien Besteconsumentenkoop meer dan 15 sales doet, mogen de sales in lead ID (4839) vallen. 
Dit mag ingaan per 4 oktober. 

UPDATE: 6-okt-2010
Kun je 98Hulse (19895) aan deze special deal toevoegen? En de limiet van target van 15 sales laten vallen (voor beide accounts)?
*/
		
UPDATE
	lead
SET
	lead_program_id = 4839
WHERE
	lead_program_id = 4818 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	created >= '2010-10-4' AND
	affiliate_id IN (9181, 19895);	
	