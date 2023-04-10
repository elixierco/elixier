#!/bin/bash

LIVY_LOG_DIR=${LIVY_LOG_DIR:-/var/log/livy/}

mkdir -p $LIVY_LOG_DIR

if [ "$1" == "start" ];then
    cp /etc/livy/* /opt/apache/livy/conf/
    python3 /opt/create_config.py /opt/apache/livy/conf/livy.conf
    python3 /opt/create_blacklist.py /opt/apache/livy/conf/spark-blacklist.conf
    /opt/apache/livy/bin/livy-server
else
    "$@"
fi
