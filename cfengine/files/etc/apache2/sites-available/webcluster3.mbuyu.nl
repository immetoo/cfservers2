#
# This file is managed by cfengine.
#

<VirtualHost 127.0.0.1:80>

	# Ldap vhost config
	VhostLDAPEnabled on
	VhostLDAPUrl "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=cluster3,ou=www,dc=m4n,dc=nl"
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
	<Directory /data/www3>
	        Options +Includes +FollowSymlinks
	        AllowOverride AuthConfig FileInfo Limit Options Indexes
	        order allow,deny
	        allow from all
	</Directory>
	
	# logging
	# Server_Root is set to the docroot by mod_vhost_ldap
	LogFormat "%{SERVER_ROOT}e %h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" masshosting
	CustomLog "| /usr/local/sbin/apache2splitlogfile /data/www3" masshosting
	
	# stats
	RewriteEngine On
	RewriteRule ^/webalizer/(.*)$ /data/www3/%{HTTP_HOST}/webalizer/$1
	
	<Location /webalizer>
		# Auth
		AuthType Basic
		AuthName "WWW Stats"
		AuthBasicProvider ldap
		AuthLDAPGroupAttribute memberUid
		AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
		AuthLDAPBindPassword "superA"
		AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=cluster3%2cou=www%2cdc=m4n%2cdc=nl?apacheServerName?sub?(objectClass=posixAccount)"
		AuthzLDAPAuthoritative off
		AuthLDAPGroupAttributeIsDN off
		Require valid-user
    </Location>
	
	CustomLog       /var/log/apache2/webcluster3-access.log combined
	ErrorLog        /var/log/apache2/webcluster3-error.log
</VirtualHost>