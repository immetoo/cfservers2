/* September 27 2010, Jan, ticket: #5947
Requested by: Marco
Kun jij de leads van MoneyMiljonair op de special deal (4821) van NSGK (22061) zetten. Het gaat om de zone 807365. Alle leads van MoneyMiljonair die 
vanaf 26 sept zijn binnen gekomen mogen op de verhoogde vergoeding. 

Update November 15 2010, Jan, Added zone 824976 to the deal.
Update Feb 3 2011, Dineke: This rule can apply to all leads from MoMo, not just certain zones (requested by Mirte) 
*/
UPDATE
	lead
SET
	lead_program_id = 4821
WHERE
	lead_program_id = 4792 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 307 AND
	created >= '2010-09-26';