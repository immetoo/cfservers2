#
# This file is managed by cfengine.
#

<VirtualHost *:80>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      test.m4n.nl

        RewriteEngine on
        RewriteRule ^/genlink.jsp http://test-views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_r http://test-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/redirectsecure.jsp http://test-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/finish_transaction.jsp http://test-leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/finnish_transaction.jsp http://test-leads.m4n.nl/_l [R=301,NE]
        
        RewriteRule ^/_v http://test-views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_c http://test-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/_l http://test-leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/blog http://blog.m4n.nl/ [R=301,NE]
        		
        JkMount /* ajp13

        CustomLog       /var/log/apache2/test.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/test.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:80>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      test-api.m4n.nl
       ServerAlias     test-mobile.m4n.nl
       ServerAlias     test-m.m4n.nl

       RewriteEngine on
       RewriteRule ^/(.*)$ https://%{HTTP_HOST}/$1 [R=301,NE]
       CustomLog       /var/log/apache2/test.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/test.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      test.m4n.nl
        
        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key

        RewriteEngine on
        RewriteRule ^/genlink.jsp https://test-views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_r https://test-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/redirectsecure.jsp https://test-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/finish_transaction.jsp https://test-leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/finnish_transaction.jsp https://test-leads.m4n.nl/_l [R=301,NE]
        
        RewriteRule ^/_v https://test-views.m4n.nl/_v [R=301,NE]
        RewriteRule ^/_c https://test-clicks.m4n.nl/_c [R=301,NE]
        RewriteRule ^/_l https://test-leads.m4n.nl/_l [R=301,NE]
        RewriteRule ^/blog http://blog.m4n.nl/ [R=301,NE]

        JkMount /* ajp13

        CustomLog       /var/log/apache2/test-secure.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/test-secure.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      test-api.m4n.nl
       
       SSLEngine on
       SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
       SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key
       
       RewriteEngine on
       RewriteCond %{REQUEST_URI} !^/restful/(.*)$
       RewriteRule ^/(.*)$ https://%{HTTP_HOST}/restful/xml/affiliate/leads [R=301,NC,L]
       
       JkMount /restful/* api_ajp13

       CustomLog       /var/log/apache2/test-secure.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/test-secure.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      test-mobile.m4n.nl
       ServerAlias     test-m.m4n.nl
       
       SSLEngine on
       SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
       SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key
    
	   RewriteEngine on   
      
       # rewrite alias to human readable server name
       RewriteCond %{HTTP_HOST} test-m.m4n.nl
       RewriteRule ^/(.*) https://test-mobile.m4n.nl/$1 [R=301,NC,L]
       
       # rewrite to index for: hostname only        
       RewriteRule ^$ https://%{HTTP_HOST}/mobile/index.jsf [R=301,NC,L]
       
       # rewrite to index for: incorrect path
       RewriteCond %{REQUEST_URI} ^/mobile/?$
       RewriteRule ^(.*)$ https://%{HTTP_HOST}/mobile/index.jsf [R=301,NC,L]
       
       # rewrite to index for: incorrect context path (mobile)
       RewriteCond %{REQUEST_URI} !^/mobile(.*)$
       RewriteRule ^/(.*)$ https://%{HTTP_HOST}/mobile/$1 [R=301,NC,L]

       JkMount /mobile/* api_ajp13

       CustomLog       /var/log/apache2/test-secure.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/test-secure.m4n.nl-error.log
</VirtualHost>
