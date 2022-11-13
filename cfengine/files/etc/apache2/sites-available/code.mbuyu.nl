#
# This file is managed by cfengine.
#

# code.mbuyu.nl
<VirtualHost 85.158.204.167:80>
        ServerAdmin systeembeheer@m4n.nl
        ServerName code.mbuyu.nl
        ServerAlias svn.mbuyu.nl

        RewriteEngine on
        RewriteCond %{HTTPS} !=on
        RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L]
</virtualhost>

<virtualhost 85.158.204.167:443>
        ServerAdmin systeembeheer@m4n.nl
        ServerName code.mbuyu.nl
        ServerAlias svn.mbuyu.nl

        RewriteEngine on
        RewriteRule ^/projects/m4n/wiki/Look&Feel* /projects/m4n/wiki/LookAndFeel%1 [R]
        RewriteRule ^/projects/(.*) https://trac.mbuyu.nl/$1 [R=permanent,NE,L]

        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.mbuyu.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.mbuyu.nl.key

		<LocationMatch "/svn/sandbox/android/*">
				AuthType Basic
				AuthName "Sandbox Repro"
				AuthBasicProvider ldap
				AuthLDAPGroupAttribute memberUid
				AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
				AuthLDAPBindPassword "superA"
				AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=users%2cdc=m4n%2cdc=nl?uid?sub?(&(objectClass=m4nAccount)(m4nAccountActive=TRUE))"
				AuthzLDAPAuthoritative off
				AuthLDAPGroupAttributeIsDN off
				Require ldap-group cn=syssandbox,ou=groups,dc=m4n,dc=nl
		</LocationMatch>
		
		<LocationMatch "/svn/sandbox/usability_testing_hva_2010/*">
				AuthType Basic
				AuthName "Sandbox Repro"
				AuthBasicProvider ldap
				AuthLDAPGroupAttribute memberUid
				AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
				AuthLDAPBindPassword "superA"
				AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=users%2cdc=m4n%2cdc=nl?uid?sub?(&(objectClass=m4nAccount)(m4nAccountActive=TRUE))"
				AuthzLDAPAuthoritative off
				AuthLDAPGroupAttributeIsDN off
				Require ldap-group cn=usability,ou=groups,dc=m4n,dc=nl
		</LocationMatch>
		
		<LocationMatch "/svn/links2start/*">
				AuthType Basic
				AuthName "Sandbox Repro"
				AuthBasicProvider ldap
				AuthLDAPGroupAttribute memberUid
				AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
				AuthLDAPBindPassword "superA"
				AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=users%2cdc=m4n%2cdc=nl?uid?sub?(&(objectClass=m4nAccount)(m4nAccountActive=TRUE))"
				AuthzLDAPAuthoritative off
				AuthLDAPGroupAttributeIsDN off
				Require ldap-group cn=links2start,ou=groups,dc=m4n,dc=nl
		</LocationMatch>
			
        <LocationMatch "/*">
				# Auth
				AuthType Basic
				AuthName "SVN Repro"
				AuthBasicProvider ldap
				AuthLDAPGroupAttribute memberUid
				AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
				AuthLDAPBindPassword "superA"
				AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=users%2cdc=m4n%2cdc=nl?uid?sub?(&(objectClass=m4nAccount)(m4nAccountActive=TRUE))"
				AuthzLDAPAuthoritative off
				AuthLDAPGroupAttributeIsDN off
				Require ldap-group cn=syssvn,ou=groups,dc=m4n,dc=nl
        </LocationMatch>

        <LocationMatch "/style.css">
                Require valid-user
        </LocationMatch>
        <LocationMatch "/style.xsl">
                Require valid-user
        </LocationMatch>
        <LocationMatch "/images/*">
                Require valid-user
        </LocationMatch>
        <LocationMatch "/m4n_design/*">
                Require valid-user
        </LocationMatch>
        <LocationMatch "/icons/*">
                Require valid-user
        </LocationMatch>
        <LocationMatch "/favicon.ico">
                Require valid-user
        </LocationMatch>
        <LocationMatch "/robots.txt">
                Require valid-user
        </LocationMatch>

        ScriptAlias /cgi-bin/ /var/www/svn.mbuyu.nl/cgi-bin/
        <Directory /var/www/svn.mbuyu.nl/cgi-bin/>
               AllowOverride None
               Options ExecCGI -MultiViews +SymLinksIfOwnerMatch
               Order allow,deny
               Allow from all
        </Directory>

        # Move to symlink somewhere like /trac/htdocs with next upgrade
        Alias /trac-htdocs /var/www/svn.mbuyu.nl/trac-htdocs/
        Alias /projects/m4n/chrome/common/ /var/www/svn.mbuyu.nl/trac-htdocs-m4n/common/
        Alias /projects/m4n/chrome/site/ /var/www/svn.mbuyu.nl/trac-htdocs-m4n/site/

        DocumentRoot /var/www/svn.mbuyu.nl/
        <Directory />
                Options FollowSymLinks
                AllowOverride None
        </Directory>
        <Directory /var/www/svn.mbuyu.nl/m4n_design>
                Options +Indexes
                IndexOptions +FancyIndexing
                AllowOverride None
        </Directory>
        
        <Location /svn>
                DAV svn
                SVNParentPath /svn
                AuthzSVNAccessFile /svn/.svnauth
                SVNIndexXSLT "/style.xsl"
        </Location>

        CustomLog /var/log/apache2/svn.mbuyu.nl-access.log combined
        ErrorLog /var/log/apache2/svn.mbuyu.nl-error.log
        LogLevel info
</virtualhost>