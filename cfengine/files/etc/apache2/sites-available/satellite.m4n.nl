#
# This file is managed by cfengine.
#

# Settings for access via http://
<VirtualHost *:80>
        ServerAdmin     systeembeheer@mbuyu.nl
        ServerName      ads.m4n.nl
        ServerAlias     views.m4n.nl
        ServerAlias     clicks.m4n.nl
        ServerAlias     leads.m4n.nl
        ServerAlias     m4n.mbuyu.nl
        
        # satellite-<hostname> used by system checks (WAN)
        ServerAlias     satellite-mrhsat0.m4n.nl
        ServerAlias     satellite-mrhsat1.m4n.nl
        ServerAlias     satellite-mrhsat2.m4n.nl
        # satellite-<hostname> used by system checks (LAN)
        ServerAlias     satellite-mrxsat0.m4n.nl
        ServerAlias     satellite-mrxsat1.m4n.nl
        ServerAlias     satellite-mrxsat2.m4n.nl
        
        # Aliases for dev platform
        ServerAlias     ads.dev.m4n.nl
        ServerAlias     ads.doxads0.m4n.nl
        
        # Aliases for beta platform
        ServerAlias     ads.beta.m4n.nl
        ServerAlias     ads.boxads0.m4n.nl
        
        # TODO: remove
        ServerAlias     satellite-toxsat2.m4n.nl
        ServerAlias     beta-views.m4n.nl
        ServerAlias     beta-clicks.m4n.nl
        ServerAlias     beta-leads.m4n.nl
        
        # Aliases for update platform
        ServerAlias     ads.update.m4n.nl
        ServerAlias     ads.uoxads0.m4n.nl
        
        # TODO: remove
        ServerAlias     satellite-toxsat1.m4n.nl
        ServerAlias     update-views.m4n.nl
        ServerAlias     update-clicks.m4n.nl
        ServerAlias     update-leads.m4n.nl
        
        # Aliases for test platform
        ServerAlias     ads.test.m4n.nl
        ServerAlias     ads.toxads0.m4n.nl
        
        # TODO: remove
        ServerAlias     satellite-toxsat3.m4n.nl
        ServerAlias     test-views.m4n.nl
        ServerAlias     test-clicks.m4n.nl
        ServerAlias     test-leads.m4n.nl
        
        RewriteEngine on
        RewriteRule ^/genlink.jsp _v [R=301,NE]
        RewriteRule ^/_r _c [R=301,NE]
        RewriteRule ^/redirectsecure.jsp _c [R=301,NE]
        RewriteRule ^/finish_transaction.jsp _l [R=301,NE]
        RewriteRule ^/finnish_transaction.jsp _l [R=301,NE]

        JkMount /_v ajp13
        JkMount /_c ajp13
        JkMount /_l ajp13
        JkMount /_s ajp13
        
        JkMount /robots.txt			ajp13
        JkMount /w3c/mbuyu.p3p      ajp13
        JkMount /w3c/p3p.xml		ajp13
        JkMount /w3c/policy.html	ajp13
        JkMount /googlea2ac2773162e30a6.html  ajp13
		JkMount /crossdomain.xml	ajp13
		        
        CustomLog       /var/log/apache2/satellite.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/satellite.m4n.nl-error.log
</VirtualHost>

# Settings for access via https://
<VirtualHost *:443>
        ServerAdmin     systeembeheer@mbuyu.nl
        ServerName      ads.m4n.nl
        ServerAlias     views.m4n.nl
        ServerAlias     clicks.m4n.nl
        ServerAlias     leads.m4n.nl
        ServerAlias     m4n.mbuyu.nl
        
        # satellite-<hostname> used by system checks
        ServerAlias     satellite-mrhsat0.m4n.nl
        ServerAlias     satellite-mrhsat1.m4n.nl
        ServerAlias     satellite-mrhsat2.m4n.nl
        ServerAlias     satellite-mrxsat3.m4n.nl
        ServerAlias     satellite-mrxsat3.m4n.nl
        
        # Aliases for dev platform
        ServerAlias     ads.dev.m4n.nl
        ServerAlias     ads.doxads0.m4n.nl
        
        # Aliases for beta platform
        ServerAlias     ads.beta.m4n.nl
        ServerAlias     ads.boxads0.m4n.nl
        
        # TODO: remove
        ServerAlias     satellite-toxsat2.m4n.nl
        ServerAlias     beta-views.m4n.nl
        ServerAlias     beta-clicks.m4n.nl
        ServerAlias     beta-leads.m4n.nl
        
        # Aliases for update platform
        ServerAlias     ads.update.m4n.nl
        ServerAlias     ads.uoxads0.m4n.nl
        
        # TODO: remove
        ServerAlias     satellite-toxsat1.m4n.nl
        ServerAlias     update-views.m4n.nl
        ServerAlias     update-clicks.m4n.nl
        ServerAlias     update-leads.m4n.nl
        
        # Aliases for test platform
        ServerAlias     ads.test.m4n.nl
        ServerAlias     ads.toxads0.m4n.nl
        
        # TODO: remove
        ServerAlias     satellite-toxsat3.m4n.nl
        ServerAlias     test-views.m4n.nl
        ServerAlias     test-clicks.m4n.nl
        ServerAlias     test-leads.m4n.nl

        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key

        RewriteEngine on
        RewriteRule ^/genlink.jsp _v [R=301,NE]
        RewriteRule ^/_r _c [R=301,NE]
        RewriteRule ^/redirectsecure.jsp _c [R=301,NE]
        RewriteRule ^/finish_transaction.jsp _l [R=301,NE]
        RewriteRule ^/finnish_transaction.jsp _l [R=301,NE]

        JkMount /_v ajp13
        JkMount /_c ajp13
        JkMount /_l ajp13
        JkMount /_s ajp13

		JkMount /robots.txt			ajp13
        JkMount /w3c/mbuyu.p3p      ajp13
        JkMount /w3c/p3p.xml		ajp13
        JkMount /w3c/policy.html	ajp13
        JkMount /googlea2ac2773162e30a6.html  ajp13
        JkMount /crossdomain.xml	ajp13

        CustomLog       /var/log/apache2/satellite.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/satellite.m4n.nl-error.log
</VirtualHost>
