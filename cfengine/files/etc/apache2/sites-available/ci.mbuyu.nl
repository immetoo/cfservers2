#
# This file is managed by cfengine.
#

<VirtualHost *:80>
       ServerAdmin systeembeheer@m4n.nl
       ServerName ci.mbuyu.nl
       ServerAlias hudson.mbuyu.nl

       RewriteEngine    on
       RewriteCond %{HTTPS} !=on
       RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L]
</virtualhost>

<virtualhost *:443>
        ServerAdmin systeembeheer@m4n.nl
        ServerName ci.mbuyu.nl
        ServerAlias hudson.mbuyu.nl

        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.mbuyu.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.mbuyu.nl.key

        RewriteEngine On	
        RewriteRule ^/$ /jenkins/ [R=permanent,L]

        JkMount /jenkins/* ajp13

        CustomLog /var/log/apache2/ci.mbuyu.nl-access.log combined
        ErrorLog /var/log/apache2/ci.mbuyu.nl-error.log
        LogLevel info
</virtualhost>
