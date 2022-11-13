#
# This file is managed by cfengine.
#

<VirtualHost *:80>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      nagios.mbuyu.nl

        RewriteEngine	on
        RewriteCond %{HTTPS} !=on
        RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L]
        
        CustomLog       /var/log/apache2/nagios.mbuyu.nl-access.log combined
        ErrorLog        /var/log/apache2/nagios.mbuyu.nl-error.log
</VirtualHost>

<VirtualHost *:443>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      nagios.mbuyu.nl
        
        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.mbuyu.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.mbuyu.nl.key

        ScriptAlias /cgi-bin/nagios3 /usr/lib/cgi-bin/nagios3
        ScriptAlias /nagios3/cgi-bin /usr/lib/cgi-bin/nagios3
        
        RewriteEngine on
        RewriteRule ^$ /nagios3 [R=301,NE]
        
        Alias /nagios3/stylesheets /etc/nagios3/stylesheets
        Alias /nagios3 /usr/share/nagios3/htdocs
        
        Documentroot	/usr/share/nagios3/htdocs
        
        <DirectoryMatch (/usr/share/nagios3/htdocs|/usr/lib/cgi-bin/nagios3)>
                Options FollowSymLinks
                DirectoryIndex index.html
                AllowOverride AuthConfig
                Order Allow,Deny
                Allow From All
              
                # Auth
                AuthType Basic
                AuthName "Nagios Access"
                AuthBasicProvider ldap
                AuthLDAPGroupAttribute memberUid
                AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
                AuthLDAPBindPassword "superA"
                AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=users%2cdc=m4n%2cdc=nl?uid?sub?(&(objectClass=m4nAccount)(m4nAccountActive=TRUE))"
                AuthzLDAPAuthoritative off
                AuthLDAPGroupAttributeIsDN off
                Require ldap-group cn=users,ou=groups,dc=m4n,dc=nl
        </DirectoryMatch>

        CustomLog       /var/log/apache2/nagios.mbuyu.nl-access.log combined
        ErrorLog        /var/log/apache2/nagios.mbuyu.nl-error.log
</VirtualHost>

