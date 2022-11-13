#
# This file is managed by cfengine.
#

<VirtualHost *:80>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      ldapadmin.mbuyu.nl

        RewriteEngine	on
        RewriteCond %{HTTPS} !=on
        RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L]
        
        CustomLog       /var/log/apache2/ldapadmin.mbuyu.nl-access.log combined
        ErrorLog        /var/log/apache2/ldapadmin.mbuyu.nl-error.log
</VirtualHost>

<VirtualHost *:443>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      ldapadmin.mbuyu.nl
        
        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.mbuyu.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.mbuyu.nl.key

        DocumentRoot     /usr/share/phpldapadmin/htdocs/
		<Directory /usr/share/phpldapadmin/htdocs/>
		    DirectoryIndex index.php
		    Options +FollowSymLinks
		    AllowOverride None
		    Order allow,deny
		    Allow from all
		    <IfModule mod_mime.c>
		      <IfModule mod_php5.c>
		        AddType application/x-httpd-php .php
		        php_flag magic_quotes_gpc Off
		        php_flag track_vars On
		        php_flag register_globals On
		        php_value include_path .
		      </IfModule>
		    </IfModule>
		    
		    	# Auth
				AuthType Basic
				AuthName "LdapAdmin Access"
				AuthBasicProvider ldap
				AuthLDAPGroupAttribute memberUid
				AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
				AuthLDAPBindPassword "superA"
				AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=users%2cdc=m4n%2cdc=nl?uid?sub?(&(objectClass=m4nAccount)(m4nAccountActive=TRUE))"
				AuthzLDAPAuthoritative off
				AuthLDAPGroupAttributeIsDN off
				Require ldap-group cn=admins,ou=groups,dc=m4n,dc=nl
		</Directory>

        CustomLog       /var/log/apache2/ldapadmin.mbuyu.nl-access.log combined
        ErrorLog        /var/log/apache2/ldapadmin.mbuyu.nl-error.log
</VirtualHost>

