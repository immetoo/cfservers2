/* September 3 2010, Jan, ticket: #5839
Hierbij een staffelverzoek voor Kortingswinkel.nl id:21930

ID:4783            Orderbedrag < €100,- = 8% CPO
ID:4784            Orderbedrag > €100,- = 10% CPO

Startdatum: zsm
Einddatum: geen
*/

UPDATE
	lead
SET
	lead_program_id = 4784
WHERE
	lead_program_id = 4783 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	price >= 100;