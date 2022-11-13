#
# This file is managed by cfengine.
#

WSGIPythonOptimize 1
WSGIRestrictEmbedded On

# hg.mbuyu.nl
<VirtualHost 85.158.204.167:80>
       ServerName hg.mbuyu.nl
       ServerAdmin systeembeheer@m4n.nl

       RewriteEngine    on
       RewriteCond %{HTTPS} !=on
       RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L]
</virtualhost>

<virtualhost 85.158.204.167:443>
        ServerAdmin systeembeheer@m4n.nl
        ServerName hg.mbuyu.nl

        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.mbuyu.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.mbuyu.nl.key

        <LocationMatch "/*">
                # Auth
                AuthType Basic
                AuthName "Mercurial"
                AuthBasicProvider ldap
                AuthLDAPGroupAttribute memberUid
                AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
                AuthLDAPBindPassword "superA"
                AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=users%2cdc=m4n%2cdc=nl?uid?sub?(&(objectClass=m4nAccount)(m4nAccountActive=TRUE))"
                AuthzLDAPAuthoritative off
                AuthLDAPGroupAttributeIsDN off
                Require ldap-group cn=syssvn,ou=groups,dc=m4n,dc=nl
        </LocationMatch>

        WSGIDaemonProcess hgweb processes=8 display-name=hg.mbuyu.nl maximum-requests=512
        WSGIProcessGroup hgweb

        WSGIScriptAlias / /hg/script/hgwebdir.wsgi
        <Directory /hg/script>
            Order deny,allow
            Allow from all
        </Directory>

        DocumentRoot /var/www/svn.mbuyu.nl/
        <Directory />
                Options FollowSymLinks
                AllowOverride None
        </Directory>

        CustomLog /var/log/apache2/hg.mbuyu.nl-access.log combined
        ErrorLog /var/log/apache2/hg.mbuyu.nl-error.log
        LogLevel info
</virtualhost>
