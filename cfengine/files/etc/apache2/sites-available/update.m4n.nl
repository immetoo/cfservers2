#
# This file is managed by cfengine.
#

<VirtualHost *:80>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      update.m4n.nl

        RewriteEngine on
        RewriteRule ^/genlink.jsp http://update-views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_r http://update-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/redirectsecure.jsp http://update-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/finish_transaction.jsp http://update-leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/finnish_transaction.jsp http://update-leads.m4n.nl/_l [R=301,NE]
        
        RewriteRule ^/_v http://update-views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_c http://update-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/_l http://update-leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/blog http://blog.m4n.nl/ [R=301,NE]
        		
        JkMount /* ajp13

        CustomLog       /var/log/apache2/update.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/update.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:80>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      update-api.m4n.nl
        ServerAlias     update-mobile.m4n.nl
        ServerAlias     update-m.m4n.nl

        RewriteEngine on
        RewriteRule ^/(.*)$ https://%{HTTP_HOST}/$1 [R=301,NE]
        CustomLog       /var/log/apache2/update.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/update.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      update.m4n.nl
        
        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key

        RewriteEngine on
        RewriteRule ^/genlink.jsp https://update-views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_r https://update-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/redirectsecure.jsp https://update-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/finish_transaction.jsp https://update-leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/finnish_transaction.jsp https://update-leads.m4n.nl/_l [R=301,NE]
        
        RewriteRule ^/_v https://update-views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_c https://update-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/_l https://update-leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/blog http://blog.m4n.nl/ [R=301,NE]

        JkMount /* ajp13

        CustomLog       /var/log/apache2/update-secure.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/update-secure.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      update-api.m4n.nl
       
        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key
       
        RewriteEngine on
        RewriteCond %{REQUEST_URI} !^/restful/(.*)$
        RewriteRule ^/(.*)$ https://%{HTTP_HOST}/restful/xml/affiliate/leads [R=301,NC,L]
       
        JkMount /restful/* api_ajp13

        CustomLog       /var/log/apache2/update-secure.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/update-secure.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      update-mobile.m4n.nl
        ServerAlias     update-m.m4n.nl
       
        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key
    
	    RewriteEngine on   
      
        # rewrite alias to human readable server name
        RewriteCond %{HTTP_HOST} update-m.m4n.nl
        RewriteRule ^/(.*) https://update-mobile.m4n.nl/$1 [R=301,NC,L]
       
        # rewrite to index for: hostname only        
        RewriteRule ^$ https://%{HTTP_HOST}/mobile/index.jsf [R=301,NC,L]
       
        # rewrite to index for: incorrect path
        RewriteCond %{REQUEST_URI} ^/mobile/?$
        RewriteRule ^(.*)$ https://%{HTTP_HOST}/mobile/index.jsf [R=301,NC,L]
       
        # rewrite to index for: incorrect context path (mobile)
        RewriteCond %{REQUEST_URI} !^/mobile(.*)$
        RewriteRule ^/(.*)$ https://%{HTTP_HOST}/mobile/$1 [R=301,NC,L]

        JkMount /mobile/* api_ajp13

        CustomLog       /var/log/apache2/update-secure.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/update-secure.m4n.nl-error.log
</VirtualHost>
