/* Ticket #4566, Dineke, February 9 2010
Aanvrager: Fleur

Adverteerder: kras.nl
ID Adverteerder: 17590

Welk type staffel is het (maak 1 keuze)?
2)Special deal

Exploitanten (in geval van special deal. Username + id):  
    * Euronovo: 11684
    * Olezonl: 13197
    * Olezoo: 22070
    * Spanje.nl – Olezo 14622
    * Summersupport 17511
    * Vakantiesnl 14285 

Wat moet er precies gebeuren?

Standaard in de hoogste staffel:

3733 à 3805

Startdatum: 8-2-2010 (there are no leads before so we don't have to set the start date explicitly
Einddatum: NVT */

UPDATE
	lead
SET
	lead_program_id = 3805
WHERE
	lead_program_id = 3773 AND
	affiliate_id IN (11684, 13197, 22070, 14622, 17511, 14285) AND
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false);
