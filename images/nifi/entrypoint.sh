#!/bin/bash -x


if [ "$1" == "shell" ];then
    /bin/bash
elif [ "$1" == "pause" ];then
    tail -f /dev/null
else
    pushd /opt/nifi/
    cp /opt/nifi/conf.default/* /opt/nifi/conf/
    cp /etc/nifi/conf/* /opt/nifi/conf/
    set -e 
    python3 /opt/nifi/create_nifi_properties.py /opt/nifi/conf/nifi.properties
    python3 /opt/nifi/create_bootstrap_properties.py /opt/nifi/conf/bootstrap.conf
    /opt/nifi/bin/nifi.sh "$@"
    popd
fi
