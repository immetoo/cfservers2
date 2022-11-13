<VirtualHost *:443>
        ServerName      ssl.mbuyu.nl
        ServerAlias     logstats.mbuyu.nl
        ServerAlias     dev.lunch.mbuyu.nl

        SSLEngine on
        SSLCertificateFile /etc/ssl/wildcard.mbuyu.nl.crt
        SSLCertificateKeyFile /etc/ssl/wildcard.mbuyu.nl.key

        SSLProxyEngine on

        ProxyRequests Off
        # timeout of  10secs (def:300)
        ProxyTimeout 10
        # this lets the http header on lunch.mbuyu.nl instead of moxlun0.dmz.office.mbuyu.com
        ProxyPreserveHost on
        <Proxy *>
                Order deny,allow
                Allow from all
        </Proxy>

        RewriteEngine  on

        RewriteCond %{HTTP_HOST} ^logstats.mbuyu.nl$ [NC]
        RewriteCond %{REQUEST_URI} !^/fwd0(.*)$
        RewriteRule ^/(.*)$ https://logstats.mbuyu.nl/fwd0/$1 [L,R=301]

        ProxyPass /fwd0 http://moxsts1.dmz.office.mbuyu.com/
        ProxyPassReverse /fwd0 http://moxsts1.dmz.office.mbuyu.com/

        CustomLog       /var/log/apache2/logstats.mbuyu.nl-access.log combined
        ErrorLog        /var/log/apache2/logstats.mbuyu.nl-error.log
</VirtualHost>