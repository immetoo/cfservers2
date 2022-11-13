/** 
* March 25 2009, Dineke:
	new staffel-like construct, requested by Bart, March 23 2009:
	"Kan je bij adverteerder InShared een script bouwen dat alle sales van onderstaande leadprogramma´s die later dan 24 uur zijn gezet na de click worden afgekeurd.
	De andere leads gaan volgens de ingestelde cookietijd."

	Het gaat om onderstaande lp id´s
* 2732
* 2731
* 2726
*/

UPDATE lead SET status = 'REJECTED' WHERE
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED') AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	lead_program_id IN (2732, 2731, 2726) AND
	created > click_created + INTERVAL '1 day';
	
