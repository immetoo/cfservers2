/* 
 * Obfuscate email address for m4nusers that are unsubscribed to prevent 
 * them from being e-mailed.
 * Related trac ticket: https://svn.mbuyu.nl/projects/m4n/ticket/2696
 * Note: obfuscating the email address is a quick and dirty workaround, 
 * the actual solution should be verification in the email job(s) itself.
 */   
UPDATE 
	m4nuser 
SET
	email = email || '_' || id || '_unsubscribed' 
WHERE
	email NOT LIKE '%_unsubscribed' AND 
	m4nuser.id IN (
		SELECT 
			distinct(userid)
		FROM 
			users_roles
		WHERE 
			role = 0
	);