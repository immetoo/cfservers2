#
# This file is managed by cfengine.
#


<VirtualHost 85.158.204.173:80>
	# Ldap vhost config
	VhostLDAPEnabled on
	VhostLDAPUrl "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=cluster2,ou=www,dc=m4n,dc=nl"
	VhostLdapBindDN "uid=apache2,ou=services,dc=m4n,dc=nl"
	VhostLDAPBindPassword "superA"
	# VhostLDAPDereferenceAliases always
	VhostLDAPFallback www.mbuyu.nl
	VhostLDAPWildcards on
	VhostLDAPWildcardsTopLevel on
	
	RewriteEngine	on
	RewriteCond %{HTTPS} !=on
	RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L]

	CustomLog       /var/log/apache2/webcluster2-access.log combined
	ErrorLog        /var/log/apache2/webcluster2-error.log	
</VirtualHost>

# ssl hosting
<VirtualHost 85.158.204.173:443>

    SSLEngine on
    SSLCertificateFile /etc/ssl/wildcard.mbuyu.nl.crt
    SSLCertificateKeyFile /etc/ssl/wildcard.mbuyu.nl.key

	# Ldap vhost config
	VhostLDAPEnabled on
	VhostLDAPUrl "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=cluster2,ou=www,dc=m4n,dc=nl"
	VhostLdapBindDN "uid=apache2,ou=services,dc=m4n,dc=nl"
	VhostLDAPBindPassword "superA"
	# VhostLDAPDereferenceAliases always
	VhostLDAPFallback www.mbuyu.nl
	VhostLDAPWildcards on
	VhostLDAPWildcardsTopLevel on

	# default dir options
	<Directory />
		Options FollowSymlinks
		AllowOverride None
	</Directory>
	<Directory /data/www2/>
	        Options +Includes +FollowSymlinks
	        AllowOverride AuthConfig FileInfo Limit Options Indexes
	        order allow,deny
	        allow from all
	</Directory>
	
	# logging
	# Server_Root is set to the docroot by mod_vhost_ldap
	LogFormat "%{SERVER_ROOT}e %h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" masshosting
	CustomLog "| /usr/local/sbin/apache2splitlogfile /data/www2" masshosting
	
	# stats
	RewriteEngine On
	RewriteRule ^/webalizer/(.*)$ /data/www2/%{HTTP_HOST}/webalizer/$1
	
	<Location /webalizer>
		# Auth
		AuthType Basic
		AuthName "WWW Stats"
		AuthBasicProvider ldap
		AuthLDAPGroupAttribute memberUid
		AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
		AuthLDAPBindPassword "superA"
		AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=cluster2%2cou=www%2cdc=m4n%2cdc=nl?apacheServerName?sub?(objectClass=posixAccount)"
		AuthzLDAPAuthoritative off
		AuthLDAPGroupAttributeIsDN off
		Require valid-user
    </Location>
	
	
	CustomLog       /var/log/apache2/webcluster2-access.log combined
	ErrorLog        /var/log/apache2/webcluster2-error.log
</VirtualHost>