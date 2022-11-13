/* April 1 2010, Dineke
 * Requested by Michiel: 
 * Alle leads van affiliate 17059 (Media Inkoop – Ilse Media) en Quickad CV (6622) bij merchant 9806 (Stepstone) moeten standaard afgekeurd worden. 
 * Deze partijen hebben een 100% CPC deal. Kun je hiervoor zorgen? Alvast dank!
 */
UPDATE
	lead
SET
	status = 'REJECTED'
WHERE
	lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 9806) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
	affiliate_id IN (6622, 17059) AND
	status IN ('TO_BE_APPROVED', 'ON_HOLD', 'ACCEPTED');
