#
# This file is managed by cfengine.
#

# Tools hosting
<VirtualHost 85.158.204.180:80>

	# Ldap vhost config
	VhostLDAPEnabled on
	VhostLDAPUrl "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=cluster1,ou=www,dc=m4n,dc=nl"
	VhostLdapBindDN "uid=apache2,ou=services,dc=m4n,dc=nl"
	VhostLDAPBindPassword "superA"
	# VhostLDAPDereferenceAliases always
	VhostLDAPFallback tools.m4n.nl
	VhostLDAPWildcards on
	VhostLDAPWildcardsTopLevel on

	# default dir options
	<Directory />
		Options FollowSymlinks
		AllowOverride None
	</Directory>
	<Directory /data/www1/>
	        Options +Includes +FollowSymlinks
	        AllowOverride AuthConfig FileInfo Limit Options Indexes
	        order allow,deny
	        allow from all
	</Directory>
	
	# logging
	# Server_Root is set to the docroot by mod_vhost_ldap
	LogFormat "%{SERVER_ROOT}e %h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" masshosting
	CustomLog "| /usr/local/sbin/apache2splitlogfile /data/www1" masshosting
	
	# stats
	RewriteEngine On
	RewriteRule ^/webalizer/(.*)$ /data/www1/%{HTTP_HOST}/webalizer/$1
	
	<Location /webalizer>
		# Auth
		AuthType Basic
		AuthName "WWW Stats"
		AuthBasicProvider ldap
		AuthLDAPGroupAttribute memberUid
		AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
		AuthLDAPBindPassword "superA"
		AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=cluster1%2cou=www%2cdc=m4n%2cdc=nl?apacheServerName?sub?(objectClass=posixAccount)"
		AuthzLDAPAuthoritative off
		AuthLDAPGroupAttributeIsDN off
		Require valid-user
    </Location>
	
	CustomLog       /var/log/apache2/webcluster1-access.log combined
	ErrorLog        /var/log/apache2/webcluster1-error.log
</VirtualHost>