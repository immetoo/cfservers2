#
# This file is managed by cfengine.
#

#
# TODO: move to *.images.m4n.nl and to ldap cluster
#
<VirtualHost *:80>
        ServerAdmin     systeembeheer@m4n.nl
        ServerName      images.mbuyu.nl
        ServerAlias     *.images.mbuyu.nl
        ServerAlias     images.dev.mbuyu.nl
        ServerAlias     images.beta.mbuyu.nl
        ServerAlias     images.update.mbuyu.nl
        ServerAlias     images.test.mbuyu.nl       
        
        # TODO: remove
        ServerAlias     update-images.mbuyu.nl
        ServerAlias     beta-images.mbuyu.nl
        ServerAlias     test-images.mbuyu.nl
        
        DirectoryIndex  index.html index.php

        RewriteEngine on
        RewriteCond %{HTTP_HOST} ^(.+)\.images\.mbuyu\.nl [NC]
        RewriteCond %{HTTP_HOST} !^$
        RewriteRule ^/(.*) http://images.mbuyu.nl/%1/$1 [R=301,NE,L]
        
        RewriteRule ^/m4n/(.*)/(.*)$ http://images.mbuyu.nl/$1/$2 [R=301,NE,L]
        RewriteRule ^/images/(.*)/(.*)$ http://images.mbuyu.nl/$1/$2 [R=301,NE,L]

        DocumentRoot     /var/www/images.mbuyu.nl/
        <DirectoryMatch "^/var/www/images.mbuyu.nl/*">
                Options Includes -Indexes FollowSymlinks
                AllowOverride AuthConfig FileInfo Limit Options
                order allow,deny
                allow from all
        </DirectoryMatch>

        # THIS ONlY WORKED FOR <host>.images.mbuyu.nl
        # LogFormat "%V %h %l %u %t \"%r\" %s %b" vcommon
        # CustomLog |/m4n/bin/images_mbuyu_log.pl vcommon
        # ErrorLog  /var/log/apache2/images-error.log
        
        CustomLog       /var/log/apache2/images.mbuyu.nl-access.log combined
        ErrorLog        /var/log/apache2/images.mbuyu.nl-error.log
</VirtualHost>
