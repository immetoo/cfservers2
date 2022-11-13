#
# This file is managed by cfengine.
#

# normal masshosting
<VirtualHost 85.158.204.178:80>

	# Ldap vhost config
	VhostLDAPEnabled on
	VhostLDAPUrl "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=cluster0,ou=www,dc=m4n,dc=nl"
	VhostLdapBindDN "uid=apache2,ou=services,dc=m4n,dc=nl"
	VhostLDAPBindPassword "superA"
	# VhostLDAPDereferenceAliases always
	VhostLDAPFallback go.m4n.nl
	VhostLDAPWildcards on
	VhostLDAPWildcardsTopLevel on

	# default dir options
	<Directory />
		Options FollowSymlinks
		AllowOverride None
	</Directory>
	<Directory /data/www/>
	        Options +Includes 
	        AllowOverride AuthConfig FileInfo Limit Options Indexes
	        order allow,deny
	        allow from all
	</Directory>
	
	# logging
	# Server_Root is set to the docroot by mod_vhost_ldap
	LogFormat "%{SERVER_ROOT}e %h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" masshosting
	CustomLog "| /usr/local/sbin/apache2splitlogfile /data/www" masshosting
	
	# stats
	RewriteEngine On
	RewriteRule ^/webalizer/(.*)$ /data/www/%{HTTP_HOST}/webalizer/$1
	
	<Location /webalizer>
		# Auth
		AuthType Basic
		AuthName "WWW Stats"
		AuthBasicProvider ldap
		AuthLDAPGroupAttribute memberUid
		AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
		AuthLDAPBindPassword "superA"
		AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=cluster0%2cou=www%2cdc=m4n%2cdc=nl?apacheServerName?sub?(objectClass=posixAccount)"
		AuthzLDAPAuthoritative off
		AuthLDAPGroupAttributeIsDN off
		Require valid-user
    </Location>
	
	CustomLog       /var/log/apache2/webcluster0-access.log combined
	ErrorLog        /var/log/apache2/webcluster0-error.log
</VirtualHost>

<VirtualHost 85.158.204.178:443>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      m4n.nl
       ServerAlias     *.m4n.nl

       SSLEngine on
       SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
       SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key

       RewriteEngine On
       RewriteCond %{SERVER_NAME} ^m4n.nl$ [OR]
       RewriteCond %{SERVER_NAME} ^w+.m4n.nl$
       RewriteRule /(.*) https://www.m4n.nl/$1 [R=301,NE,L]

       RewriteRule /(.*) http://%{SERVER_NAME}/$1 [R=301,NE,L]
</VirtualHost>