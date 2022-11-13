#
# This file is managed by cfengine.
#

<VirtualHost *:80>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      www.dev.m4n.nl
       ServerAlias     dev.m4n.nl

       RewriteEngine on

       RewriteCond %{HTTP_HOST} ^dev.m4n.nl$
       RewriteRule ^/(.*) http://www.dev.m4n.nl/$1 [R=301,NC,L]
      
       RewriteRule ^/genlink.jsp http://ads.dev.m4n.nl/_v [R=301,NE]
       RewriteRule ^/_r http://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/redirectsecure.jsp http://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/finish_transaction.jsp http://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/finnish_transaction.jsp http://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/_v http://ads.dev.m4n.nl/_v [R=301,NE]
       RewriteRule ^/_c http://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/_l http://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/blog http://blog.m4n.nl/ [R=301,NE]
                     
       JkMount /*       ajp13
       JkMount /dfurl/* df_ajp13

       CustomLog       /var/log/apache2/www.dev.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/www.dev.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:80>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      app.dev.m4n.nl
            
       JkMount /*      app_ajp13

       CustomLog       /var/log/apache2/www.dev.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/www.dev.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:80>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      api.dev.m4n.nl
       ServerAlias     mobile.dev.m4n.nl
       ServerAlias     m.dev.m4n.nl
       
       RewriteEngine on
       RewriteRule ^/(.*)$ https://%{HTTP_HOST}/$1 [R=301,NE]
       CustomLog       /var/log/apache2/www.dev.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/www.dev.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      www.dev.m4n.nl
       ServerAlias     dev.m4n.nl
       
       SSLEngine on
       SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
       SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key
		
	      
       RewriteEngine on

       RewriteCond %{HTTP_HOST} ^dev.m4n.nl$
       RewriteRule ^/(.*) http://www.dev.m4n.nl/$1 [R=301,NC,L]

       RewriteRule ^/genlink.jsp https://ads.dev.m4n.nl/_v [R=301,NE]
       RewriteRule ^/_r https://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/redirectsecure.jsp https://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/finish_transaction.jsp https://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/finnish_transaction.jsp https://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/_v https://ads.dev.m4n.nl/_v [R=301,NE]
       RewriteRule ^/_c https://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/_l https://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/blog http://blog.m4n.nl/ [R=301,NE]

       JkMount /*       ajp13
       JkMount /dfurl/* df_ajp13

       CustomLog       /var/log/apache2/secure.www.dev.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/secure.www.dev.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      api.dev.m4n.nl
       
       SSLEngine on
       SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
       SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key
       
       RewriteEngine on
       RewriteCond %{REQUEST_URI} !^/restful/(.*)$
       RewriteRule ^/(.*)$ https://%{HTTP_HOST}/restful/xml/affiliate/leads [R=301,NC,L]
       
       JkMount /restful/* api_ajp13

       CustomLog       /var/log/apache2/secure.www.dev.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/secure.www.dev.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      app.dev.m4n.nl
                     
       JkMount /*      app_ajp13

       CustomLog       /var/log/apache2/secure.www.dev.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/secure.www.dev.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      mobile.dev.m4n.nl
       ServerAlias     m.dev.m4n.nl
       
       SSLEngine on
       SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
       SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key
       
       RewriteEngine on
             
       # rewrite alias to human readable server name
       RewriteCond %{HTTP_HOST} m.dev.m4n.nl
       RewriteRule ^/(.*) https://mobile.dev.m4n.nl/$1 [R=301,NC,L]
       
       # rewrite to index for: hostname only        
       RewriteRule ^$ https://%{HTTP_HOST}/mobile/index.jsf [R=301,NC,L]
       
       # rewrite to index for: incorrect path
       RewriteCond %{REQUEST_URI} ^/mobile/?$
       RewriteRule ^(.*)$ https://%{HTTP_HOST}/mobile/index.jsf [R=301,NC,L]
       
       # rewrite to index for: incorrect context path (mobile)
       RewriteCond %{REQUEST_URI} !^/mobile(.*)$
       RewriteRule ^/(.*)$ https://%{HTTP_HOST}/mobile/$1 [R=301,NC,L]

       JkMount /mobile/* api_ajp13

       CustomLog       /var/log/apache2/secure.www.dev.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/secure.www.dev.m4n.nl-error.log
</VirtualHost>

