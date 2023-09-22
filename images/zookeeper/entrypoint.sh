#!/bin/bash

K8S_POD_NAME=${K8S_POD_NAME:-node-0}

if [ "$1" == "start" ];then
    python3 /opt/create_zk_config.py /opt/apache/zookeeper/conf/zoo.cfg
    /opt/apache/zookeeper/bin/zkServer.sh start-foreground 
else
    "$@"
fi
