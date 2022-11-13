/* February 2 2011, Jan, ticket: #6680
Ichica wil graag vergoedingen differentiëren aan de hand van de orderwaarde. Leads die hoger zijn dan €100,- moeten in lead id 6197 komen en leads 
die hieronder zijn (normaal) mogen in lead ID 4427 vallen. 
Ingangsdatum is 1 Februari. 
*/

UPDATE 
	lead 
SET 
    lead_program_id = 6197
WHERE 
	lead_program_id = 4427 AND
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    created >= '2011-02-01' AND
    price >= 100.0;