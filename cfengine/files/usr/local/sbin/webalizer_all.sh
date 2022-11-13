#/bin/bash

LOGFILES="/var/www/*/logs/*.log";
TEMPLATE="/etc/webalizer/webalizer.conf.template";
WEBALIZER="/usr/bin/webalizer";

for file in `ls $LOGFILES`; do

        site=${file/\/var\/www\//};
        site=${site/\/logs*/};
        echo "SITE: $site";

        echo -n "Creating tempate ";
        CONF_TEMP=/tmp/webalizer.conf-temp;
        cat $TEMPLATE | sed "s/###VIRTUALHOSTNAME###/$site/g"  > $CONF_TEMP;echo done;

        if [ ! -e "$CONF_TEMP" ]; then
                echo "ERROR: No config file: $CONF_TEMP";
                continue;
        fi

        echo "------------ Running webalizer -------------"
        $WEBALIZER -i -c $CONF_TEMP
        echo "DONE";
        echo "";

done
