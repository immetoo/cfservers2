#
# This file is managed by cfengine.
#

<VirtualHost *:80>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      dev2.m4n.nl

       RewriteEngine on
       RewriteRule ^/genlink.jsp http://ads.dev.m4n.nl/_v [R=301,NE]
       RewriteRule ^/_r http://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/redirectsecure.jsp http://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/finish_transaction.jsp http://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/finnish_transaction.jsp http://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/_v http://ads.dev.m4n.nl/_v [R=301,NE]
       RewriteRule ^/_c http://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/_l http://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/blog http://blog.m4n.nl/ [R=301,NE]
                     
       JkMount /* ajp_root
       JkMount /dfurl/* ajp_dfurl
       JkMount /datafeeds/* ajp_dfui
       JkMount /solr/* ajp_solr
       JkMount /forum/* ajp_forum
       JkMount /dbadmin/* ajp_dbadmin 

        <Location /jkstatus/>
            JkMount status_ajp13
			Order Deny,Allow
			Deny from all
			Allow from 127.0.0.1 172.16.16.0/20 87.215.139.10 95.97.69.226
        </Location>

       CustomLog       /var/log/apache2/dev2.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/dev2.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
       ServerAdmin     systeembeheer@m4n.nl
       ServerName      dev2.m4n.nl

       SSLEngine on
       SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
       SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key

       RewriteEngine on
       RewriteRule ^/genlink.jsp https://ads.dev.m4n.nl/_v [R=301,NE]
       RewriteRule ^/_r https://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/redirectsecure.jsp https://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/finish_transaction.jsp https://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/finnish_transaction.jsp https://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/_v https://ads.dev.m4n.nl/_v [R=301,NE]
       RewriteRule ^/_c https://ads.dev.m4n.nl/_c [R=301,NE]
       RewriteRule ^/_l https://ads.dev.m4n.nl/_l [R=301,NE]
       RewriteRule ^/blog http://blog.m4n.nl/ [R=301,NE]
       
       JkMount /* ajp_root
       JkMount /dfurl/* ajp_dfurl
       JkMount /datafeeds/* ajp_dfui
       JkMount /solr/* ajp_solr
       JkMount /forum/* ajp_forum
       JkMount /dbadmin/* ajp_dbadmin 

       CustomLog       /var/log/apache2/dev2-secure.m4n.nl-access.log combined
       ErrorLog        /var/log/apache2/dev2-secure.m4n.nl-error.log
</VirtualHost>
