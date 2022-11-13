#
# This file is managed by cfengine.
#

<VirtualHost *:80>
       ServerAdmin systeembeheer@m4n.nl
       ServerName mvn.mbuyu.nl
       ServerAlias nexus.mbuyu.nl

       RewriteEngine    on
       RewriteCond %{HTTPS} !=on
       RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L]
</virtualhost>

<virtualhost *:443>
        ServerAdmin systeembeheer@m4n.nl
        ServerName mvn.mbuyu.nl
        ServerAlias nexus.mbuyu.nl

        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.mbuyu.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.mbuyu.nl.key

        # Rewrites for auto index.html because nexus does dir listing.
        RewriteEngine on
        RewriteRule ^/sites$ https://mvn.mbuyu.nl/sites/index.html
        RewriteRule ^/sites/$ https://mvn.mbuyu.nl/sites/index.html
        RewriteRule ^/sites/(.*)/$ https://mvn.mbuyu.nl/sites/$1/index.html

        # proxy all to nexus with url shortcut for hosted sites.
        <Proxy *>
                Allow from all
        </Proxy>
        ProxyRequests Off
        ProxyPreserveHost On
        ProxyPass /sites http://localhost:8081/content/repositories/sites/parent-super-pom/
        ProxyPass /sites/parent-build-pom http://localhost:8081/content/repositories/sites/parent-build-pom/
        ProxyPass / http://localhost:8081/
        ProxyPassReverse / http://localhost:8081/

        CustomLog /var/log/apache2/mvn.mbuyu.nl-access.log combined
        ErrorLog /var/log/apache2/mvn.mbuyu.nl-error.log
        LogLevel info
</virtualhost>
