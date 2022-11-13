/* September 6 2010, Jan, ticket: #5858
Voor My collections (id; 21857 ) hebben we een special deal aangemaakt voor Zinngeld (id; 5575 ).

Kan je ervoor zorgen dat alle my collections leads van zinngeld op het het special deal leadprogramma (id; 4787) binnen komen per vandaag?
*/

UPDATE
	lead
SET
	lead_program_id = 4787
WHERE
	lead_program_id = 4774 AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id = 5575 AND
	created >= '2010-09-06';