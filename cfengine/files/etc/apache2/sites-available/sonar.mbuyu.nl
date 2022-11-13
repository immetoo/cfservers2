#
# This file is managed by cfengine.
#

<VirtualHost *:80>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      sonar.mbuyu.nl

        RewriteEngine   on
        RewriteCond %{HTTPS} !=on
        RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L]
        
        CustomLog       /var/log/apache2/sonar.mbuyu.nl-access.log combined
        ErrorLog        /var/log/apache2/sonar.mbuyu.nl-error.log
</Virtualhost>

<Virtualhost *:443>
        ServerAdmin		systeembeheer@m4n.nl
        ServerName      sonar.mbuyu.nl

        SSLEngine on
        SSLCertificateFile    /etc/ssl/wildcard.mbuyu.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.mbuyu.nl.key

        <LocationMatch "/*">
                AuthType Basic
                AuthName "Sonar - production quality monitoring tools"
                AuthBasicProvider ldap
                AuthLDAPGroupAttribute memberUid
                AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
                AuthLDAPBindPassword "superA"
                AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=users%2cdc=m4n%2cdc=nl?uid?sub?(&(objectClass=m4nAccount)(m4nAccountActive=TRUE))"
                AuthzLDAPAuthoritative off
                AuthLDAPGroupAttributeIsDN off
                Require ldap-group cn=syssvn,ou=groups,dc=m4n,dc=nl

                # Allow hudson to api urls without auth to run sonar:sonar goal
                Satisfy Any
                Allow from 172.16.24.16
        </LocationMatch>

        JkMount /* ajp13

        CustomLog       /var/log/apache2/sonar.mbuyu.nl-access.log combined
        ErrorLog        /var/log/apache2/sonar.mbuyu.nl-error.log
</Virtualhost>
