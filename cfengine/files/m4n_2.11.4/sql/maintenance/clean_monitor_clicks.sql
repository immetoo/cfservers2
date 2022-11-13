/*	January 13 2011, Dineke, #6172:
	The ClickMonitor and LeadMonitor set leads and clicks and checks whether they were persisted.
	The clicks have to be present click table, so cannot be blocked by the Blocking system.
	
	The same goes for the clicks by affiliate Daniel (37). These are test clicks, set by 
	"cacti script: http_response_time.pl".
	
	But we can remove them after a while.
	
	The leads set by LeadRequestMonitor and http_response_time.pl are blocked by the Blocking system.
*/
DELETE FROM 
	click
WHERE
	affiliate_id = 18955 AND --m4n nagios
	payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
    user_agent LIKE 'ClickRequestMonitor.checkHealth()%' AND
	created < now() - INTERVAL '1 hour';
	
DELETE FROM
	click
WHERE 
    affiliate_id = 37 AND 
    payment_period_id IN (SELECT id FROM payment_period WHERE processed = false) AND 
    created < now() - INTERVAL '1 hour';
