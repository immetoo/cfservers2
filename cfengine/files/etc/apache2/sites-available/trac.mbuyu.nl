#
# This file is managed by cfengine.
#

WSGIPythonOptimize 1
WSGIRestrictEmbedded On

# code.mbuyu.nl
<VirtualHost 85.158.204.167:80>
        ServerAdmin systeembeheer@m4n.nl
        ServerName trac.mbuyu.nl

        RewriteEngine on
        RewriteCond %{HTTPS} !=on
        RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L]
</virtualhost>

<virtualhost 85.158.204.167:443>
        ServerAdmin systeembeheer@m4n.nl
        ServerName trac.mbuyu.nl

        RewriteEngine on
        RewriteRule ^/m4n/wiki/Look&Feel* /m4n/wiki/LookAndFeel%1 [R]

        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.mbuyu.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.mbuyu.nl.key

        <LocationMatch "/*">
                # Auth
                AuthType Basic
                AuthName "Trac"
                AuthBasicProvider ldap
                AuthLDAPGroupAttribute memberUid
                AuthLDAPBindDN uid=apache2,ou=services,dc=m4n,dc=nl
                AuthLDAPBindPassword "superA"
                AuthLDAPURL "ldaps://ldap1.lan.mbuyu.nl ldap3.lan.mbuyu.nl/ou=users%2cdc=m4n%2cdc=nl?uid?sub?(&(objectClass=m4nAccount)(m4nAccountActive=TRUE))"
                AuthzLDAPAuthoritative off
                AuthLDAPGroupAttributeIsDN off
                Require ldap-group cn=syssvn,ou=groups,dc=m4n,dc=nl
        </LocationMatch>

        <LocationMatch "/images/*">
                Require valid-user
        </LocationMatch>
        <LocationMatch "/favicon.ico">
                Require valid-user
        </LocationMatch>
        <LocationMatch "/robots.txt">
                Require valid-user
        </LocationMatch>

        # Move to symlink somewhere like /trac/htdocs with next upgrade
        Alias /trac-htdocs /var/www/svn.mbuyu.nl/trac-htdocs/
        Alias /images /var/www/svn.mbuyu.nl/images/
        Alias /robots.txt /var/www/svn.mbuyu.nl/robots.txt
        Alias /m4n/chrome/ /var/www/svn.mbuyu.nl/trac-htdocs-m4n/
        Alias /bitten/ /var/www/svn.mbuyu.nl/trac-htdocs-m4n/bitten/
        #Alias /m4n/chrome/common/ /var/www/svn.mbuyu.nl/trac-htdocs-m4n/common/
        #Alias /m4n/chrome/site/ /var/www/svn.mbuyu.nl/trac-htdocs-m4n/site/
        #Alias /m4n/chrome/bitten/ /usr/src/bitten/bitten/htdocs/
        #Alias /m4n/chrome/Billing/ /usr/src/timingandestimationplugin-0.12/timingandestimationplugin/htdocs/
        # bug in tad plugin ?
        #Alias /m4n/m4n/chrome/Billing/ /usr/src/timingandestimationplugin-0.12/timingandestimationplugin/htdocs/
        
        <IfModule mod_expires.c>
            ExpiresByType image/x-icon "access plus 1 year"
        </IfModule>
        <Directory /var/www>
            Header unset ETag
            FileETag None
            <IfModule mod_expires.c>
                ExpiresActive On
                ExpiresByType image/x-icon "access plus 1 year"
                ExpiresByType image/png "access plus 3 months"
                ExpiresByType image/jpg "access plus 3 months"
                ExpiresByType image/gif "access plus 3 months"
                ExpiresByType image/jpeg "access plus 3 months"
                ExpiresByType video/ogg "access plus 1 month"
                ExpiresByType video/mpeg "access plus 1 month"
                ExpiresByType video/mp4 "access plus 1 month"
                ExpiresByType video/quicktime "access plus 1 month"
                ExpiresByType video/x-ms-wmv "access plus 1 month"
                ExpiresByType text/css "access plus 3 months"
                #ExpiresByType text/html "access plus 3 months"
                ExpiresByType text/javascript "access plus 3 months"
                ExpiresByType application/javascript "access plus 3 months"
            </IfModule>
        </Directory>
        <FilesMatch "\.(ico|pdf|flv|jpg|jpeg|png|gif|js|css|swf)$">
            Header set Cache-Control "max-age=290304000, public"
        </FilesMatch>
        <FilesMatch "\.(xml|txt)$">
            Header set Cache-Control "max-age=172800, public, must-revalidate"
        </FilesMatch>
        <FilesMatch "\.(html|htm)$">
            Header set Cache-Control "max-age=7200, must-revalidate"
        </FilesMatch>
        
        WSGIDaemonProcess tracmbuyu processes=8 display-name=trac.mbuyu.nl maximum-requests=512
        WSGIProcessGroup tracmbuyu
        
        WSGIScriptAlias / /trac/trac.wsgi

        DocumentRoot /var/www/svn.mbuyu.nl/
        <Directory />
                Options FollowSymLinks
                AllowOverride None
        </Directory>

        CustomLog /var/log/apache2/trac.mbuyu.nl-access.log combined
        ErrorLog /var/log/apache2/trac.mbuyu.nl-error.log
        LogLevel info
</virtualhost>
