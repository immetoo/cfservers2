#
# This file is managed by cfengine.
#
# Please note: this file is build with spaces, not tabs.
#

<VirtualHost *:80>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      images.m4n.nl
        ServerAlias		images.dev.m4n.nl
        ServerAlias		images.beta.m4n.nl
        ServerAlias		images.update.m4n.nl
        ServerAlias		images.test.m4n.nl
        
        # TODO: remove
        ServerAlias		beta-images.m4n.nl
        ServerAlias		update-images.m4n.nl
        ServerAlias		test-images.m4n.nl

		DocumentRoot     /var/www/images.m4n.nl/
        <DirectoryMatch "^/var/www/images.m4n.nl/*">
                Options Includes -Indexes FollowSymlinks
                AllowOverride AuthConfig FileInfo Limit Options
                order allow,deny
                allow from all
        </DirectoryMatch>

        CustomLog       /var/log/apache2/images.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/images.m4n.nl-error.log
</VirtualHost>

<VirtualHost *:443>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      images.m4n.nl
        ServerAlias		images.dev.m4n.nl
        ServerAlias		images.beta.m4n.nl
        ServerAlias		images.update.m4n.nl
        ServerAlias		images.test.m4n.nl
        
        # TODO: remove
        ServerAlias		beta-images.m4n.nl
        ServerAlias		update-images.m4n.nl
        ServerAlias		test-images.m4n.nl
        
        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.m4n.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.m4n.nl.key

		DocumentRoot     /var/www/images.m4n.nl/
        <DirectoryMatch "^/var/www/images.m4n.nl/*">
                Options Includes -Indexes FollowSymlinks
                AllowOverride AuthConfig FileInfo Limit Options
                order allow,deny
                allow from all
        </DirectoryMatch>

        CustomLog       /var/log/apache2/images-secure.m4n.nl-access.log combined
        ErrorLog        /var/log/apache2/images-secure.m4n.nl-error.log
</VirtualHost>
