#!/bin/sh
# Your heartbeat URL here (must be hosted on this server)
URL_TO_CHECK="https://xxxx.yyy"
# Your temp file to monitor downtime
DOWN_FILE="/root/site_down";
# How long will you tolerate downtime in minutes
DOWN_TIME="+10";

HTTP_STATUS=`curl -s -o /dev/null -w "%{http_code}" "$URL_TO_CHECK"`;
SITE_DOWN_TOGGLE=`find "$DOWN_FILE"`;

echo "$SITE_DOWN_TOGGLE";

if [ "$HTTP_STATUS" != "200" ]; then
    echo "Website is down $HTTP_STATUS";
    if [ "$SITE_DOWN_TOGGLE" != "$DOWN_FILE" ]; then
        touch "$DOWN_FILE";
        echo "Made file $DOWN_FILE";
    fi

    SITE_DOWN_PAST_TIME=`find "$DOWN_FILE" -mmin "$DOWN_TIME"`;

    if [ "$SITE_DOWN_PAST_TIME" = "$DOWN_FILE" ]; then
        rm "$DOWN_FILE";
        echo "Site down past timecheck... rebooting apache";

        # IMPORTANT: Choose or add a the line below with web server's restart command
        # CentOS: apache
        # sudo systemctl restart httpd.service

        # Ubuntu: apache
        sudo systemctl restart apache2

        # Ubuntu: nginx
        # sudo systemctl restart nginx
    else
        echo "Site not yet down past $DOWN_TIME tolerance";
    fi
else
    rm "$DOWN_FILE";
    echo "Website is running $HTTP_STATUS";
fi
