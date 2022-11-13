#
# This file is managed by cfengine.
#
# Please note: this file is build with spaces, not tabs.
#

<VirtualHost *:80>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      www.m4n.nl
        ServerAlias     satellite-mrhweb0.m4n.nl

        RewriteEngine on
        RewriteRule ^/genlink.jsp http://views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_r http://clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/redirectsecure.jsp http://clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/finish_transaction.jsp http://leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/finnish_transaction.jsp http://leads.m4n.nl/_l [R=301,NE]
        
        RewriteRule ^/_v http://views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_c http://clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/_l http://leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/blog http://blog.m4n.nl/ [R=301,NE]
        RewriteRule ^/lasvegas http://lasvegas.m4n.nl/ [R=301,NE]
        
        # Old pages url requests
        RewriteCond %{REQUEST_URI} advertising_rules.jsp
        RewriteCond %{QUERY_STRING} merchant_id=(.*)
        RewriteRule ^(.*)$ http://www.m4n.nl/affiliate/advertising_overview.jsp?merchant_id=%1 [L,R=301]
        
        JkMount /* ajp13
        JkMount /dfurl/* lb_df_ajp13
        
        # Enable the JK manager access from localhost only
        <Location /jkstatus/>
            JkMount status_ajp13
            Order deny,allow
            Deny from all
            Allow from 85.158.204.168
        </Location>
        
        CustomLog       /var/log/apache2/www.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/www.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      www.m4n.nl
        ServerAlias     api.m4n.nl
        ServerAlias     m.m4n.nl
        ServerAlias     mobile.m4n.nl
        ServerAlias     satellite-mrhweb0.m4n.nl
        
        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key

        RewriteEngine on
        RewriteRule ^/genlink.jsp https://views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_r https://clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/redirectsecure.jsp https://clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/finish_transaction.jsp https://leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/finnish_transaction.jsp https://leads.m4n.nl/_l [R=301,NE]

        RewriteRule ^/_v https://views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_c https://clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/_l https://leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/blog http://blog.m4n.nl/ [R=301,NE]
        
        RewriteCond %{REQUEST_URI} advertising_rules.jsp
        RewriteCond %{QUERY_STRING} merchant_id=(.*)
        RewriteRule ^(.*)$ https://www.m4n.nl/affiliate/advertising_overview.jsp?merchant_id=%1 [L,R=301]

        RewriteCond %{HTTP_HOST} m.m4n.nl [OR]
        RewriteCond %{HTTP_HOST} mobile.m4n.nl
        RewriteRule ^$ https://m.m4n.nl/mobile/index.jsf [R=301,NC,L]
        
        RewriteCond %{REQUEST_URI} ^/mobile/?$
        RewriteRule ^(.*)$ https://m.m4n.nl/mobile/index.jsf [R=301,NC,L]
        
        RewriteCond %{HTTP_HOST} m.m4n.nl [OR]
        RewriteCond %{HTTP_HOST} mobile.m4n.nl
        RewriteCond %{REQUEST_URI} !^/mobile(.*)$
        RewriteRule ^/(.*)$ https://m.m4n.nl/mobile/$1 [R=301,NC,L]

        RewriteCond %{HTTP_HOST} api.m4n.nl
        RewriteCond %{REQUEST_URI} !^/restful/(.*)$
        RewriteRule ^/(.*)$ https://api.m4n.nl/restful/xml/affiliate/leads [R=301,NC,L]
        
        RewriteRule ^/hoe_werkt_affiliate_marketing\.jsp http://www.m4n.nl/hoe_werkt_affiliate_marketing.jsp [R=301,NC,L]  

        #Robots file SSL
        RewriteRule ^/robots\.txt$ /robots_ssl.txt [PT]
        
        JkMount /* ajp13
        JkMount /restful/* api_ajp13
        JkMount /mobile/* api_ajp13
        JkMount /dfurl/* lb_df_ajp13

        CustomLog       /var/log/apache2/www-secure.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/www-secure.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:80>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      api.m4n.nl
        ServerAlias     m.m4n.nl
        ServerAlias     mobile.m4n.nl
        
        RewriteEngine on
        RewriteCond %{HTTPS} !=on
        RewriteRule ^/(.*)$ https://%{SERVER_NAME}/$1 [R,L]

        CustomLog       /var/log/apache2/api.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/api.m4n.nl-error.log
</VirtualHost>
