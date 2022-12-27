#!/bin/bash

if [ "$1" == "start" ];then
    /opt/elixier/superset/bin/gunicorn \
        -b $WEB_LISTEN_ADDRESS \
        -w $WEB_WORKERS \
        -k gevent \
        --timeout 120 \
        --limit-request-line 0 \
        --limit-request-field_size 0 \
        --forwarded-allow-ips="*" \
        "superset.app:create_app()"
elif [ "$1" == "worker" ];then
    /opt/elixier/superset/bin/celery \
        --app=superset.tasks.celery_app:app \
        worker \
        --pool=prefork -O fair -c ${CELERY_WORKERS:-2}
elif [ "$1" == "scheduler" ];then
    /opt/elixier/superset/bin/celery --app=superset.tasks.celery_app:app beat
elif [ "$1" == "first-init" ];then
    /opt/elixier/superset/bin/superset db upgrade
    if [ ! -f "/var/lib/superset/initialized" ];then
        /opt/elixier/superset/bin/superset fab create-admin --username $DEFAULT_ADMIN --firstname $DEFAULT_ADMIN --lastname $DEFAULT_ADMIN --email $DEFAULT_ADMIN_EMAIL --password $DEFAULT_ADMIN_PASSWORD
        /opt/elixier/superset/bin/superset init
        touch /var/lib/superset/initialized
    fi
else
    "$@"
fi
