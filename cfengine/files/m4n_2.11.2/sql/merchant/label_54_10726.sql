/*
 * Label 54
 */

--April 7 2009, Dineke: Autoapprove all leads that have a description2 14, 21 or 1
UPDATE lead SET
	status = 'ACCEPTED'
	WHERE status = 'TO_BE_APPROVED' AND
		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
		lead_program_id IN (SELECT id FROM lead_program WHERE merchant_id = 10726) AND
		description2 IN ('14', '21','1', '28'); 
 
 
 /* December 16, 2008, Dineke: 
   	program 2517 Vanaf 20 sales: 15% commissie  	
	program 2516 10 tot 20 sales 13% commissie 	
	program 1866 0 tot 10 sales: 10% commissie
*/
 
UPDATE lead SET 
    lead_program_id = 2516
    WHERE status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
    		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    		lead_program_id = 1866 AND
    		click_created < '2011-02-01' AND
    		affiliate_id IN (SELECT affiliate_id FROM lead WHERE lead_program_id IN (1866, 2516, 2517) AND
    							status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
    							click_created < '2011-02-01' AND
    							payment_period_id IN  (SELECT id FROM payment_period WHERE processed = false)
    							GROUP BY affiliate_id HAVING COUNT(id) >= 10 AND COUNT(id) < 20);
    							
UPDATE lead SET 
    lead_program_id = 2517
    WHERE status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND 
    		payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    		lead_program_id IN (1866, 2516) AND
    		click_created < '2011-02-01' AND
    		affiliate_id IN (SELECT affiliate_id FROM lead WHERE lead_program_id IN (1866, 2516, 2517) AND
    							status IN ('ACCEPTED', 'TO_BE_APPROVED', 'ON_HOLD') AND
    							click_created < '2011-02-01' AND
    							payment_period_id IN  (SELECT id FROM payment_period WHERE processed = false)
    							GROUP BY affiliate_id HAVING COUNT(id) >= 20);
    							
/* February 6, 2009, Dineke:
	Special Deal: affiliate Lysander (10929) always gets highest program (2517) */
	
UPDATE lead SET
	lead_program_id = 2517
	WHERE   payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND
    		lead_program_id IN (1866, 2516) AND
    		affiliate_id = 10929;