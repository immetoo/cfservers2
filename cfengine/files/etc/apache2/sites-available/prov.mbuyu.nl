#
# This file is managed by cfengine.
#

<VirtualHost *:80>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      prov.mbuyu.nl

        RewriteEngine	on
        RewriteCond %{HTTPS} !=on
        RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L]
        
        CustomLog       /var/log/apache2/prov.mbuyu.nl-access.log combined
        ErrorLog        /var/log/apache2/prov.mbuyu.nl-error.log
</VirtualHost>

<VirtualHost *:443>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      prov.mbuyu.nl
        
        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.mbuyu.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.mbuyu.nl.key

        DocumentRoot     /var/www/prov.mbuyu.nl/
        <DirectoryMatch "^/var/www/prov.mbuyu.nl/*">
                Options Includes -Indexes FollowSymlinks
                AllowOverride AuthConfig FileInfo Limit Options
                order allow,deny
                allow from all
        </DirectoryMatch>

        CustomLog       /var/log/apache2/prov.mbuyu.nl-access.log combined
        ErrorLog        /var/log/apache2/prov.mbuyu.nl-error.log
</VirtualHost>

