#<VirtualHost 85.158.204.174:80>
#    RewriteEngine	on
#	RewriteCond %{HTTPS} !=on
#	RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L] 
#</VirtualHost>

<VirtualHost 85.158.204.174:80>
	# Ldap vhost config
	VhostLDAPEnabled on
	VhostLDAPUrl "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=cluster1,ou=www,dc=m4n,dc=nl"
	VhostLdapBindDN "uid=apache2,ou=services,dc=m4n,dc=nl"
	VhostLDAPBindPassword "superA"
	# VhostLDAPDereferenceAliases always
	VhostLDAPFallback www.mbuyu.nl
	#VhostLDAPWildcards on
	#VhostLDAPWildcardsTopLevel on
        
#        SSLEngine on
#        SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
#        SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key



        CustomLog       /var/log/apache2/tools.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/tools.m4n.nl-error.log
</VirtualHost>

<VirtualHost 85.158.204.174:443>
	# Ldap vhost config
	VhostLDAPEnabled on
	VhostLDAPUrl "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=cluster1,ou=www,dc=m4n,dc=nl"
	VhostLdapBindDN "uid=apache2,ou=services,dc=m4n,dc=nl"
	VhostLDAPBindPassword "superA"
	# VhostLDAPDereferenceAliases always
	VhostLDAPFallback www.mbuyu.nl
	#VhostLDAPWildcards on
	#VhostLDAPWildcardsTopLevel on
        
        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key
        
        CustomLog       /var/log/apache2/tools.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/tools.m4n.nl-error.log
</VirtualHost>        