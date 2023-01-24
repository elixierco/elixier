#!/bin/bash 

set -xe

cd /opt/ranger-${RANGER_VERSION}-admin/

bash ./setup.sh

function stopranger() {
    echo "Received SIGTERM"
    /usr/bin/ranger-admin stop
    sleep 5
    exit
}

trap stopranger SIGTERM

rm -f /opt/ranger-${RANGER_VERSION}-admin/ews/webapp/WEB-INF/classes/conf/ranger-admin-env-*

export RANGER_ADMIN_LOGBACK_CONF_FILE=/opt/ranger-${RANGER_VERSION}-admin/ews/webapp/WEB-INF/classes/conf/logback.xml

bash /opt/ranger-${RANGER_VERSION}-admin/ews/ranger-admin-services.sh start

tail -f /var/log/ranger/catalina.out &

set +x
while true;do sleep 1; done
