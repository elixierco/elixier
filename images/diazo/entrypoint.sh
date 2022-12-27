#!/bin/bash

if [ "$1" == "start" ];then
    /opt/elixier/diazo/bin/gunicorn \
        -b $WEB_LISTEN_ADDRESS \
        -w $WEB_WORKERS \
        -k gevent \
        --timeout 120 \
        --limit-request-line 0 \
        --limit-request-field_size 0 \
        --forwarded-allow-ips="*" \
        --paste "$DIAZO_PASTE_INI" \
        --chdir "$DIAZO_PROJECT_DIR"
else
    "$@"
fi
