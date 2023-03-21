#!/bin/bash

SCHEMAREGISTRY_LOG_DIR=${SCHEMAREGISTRY_LOG_DIR:-/var/log/schemaregistry/}

mkdir -p $SCHEMAREGISTRY_LOG_DIR

export LOG_DIR=$SCHEMAREGISTRY_LOG_DIR

if [ "$1" == "start" ];then
    python3 /opt/create_log4j_config.py /etc/schema-registry/log4j.properties
    python3 /opt/create_config.py /etc/schema-registry/schema-registry.properties
    /usr/bin/schema-registry-start /etc/schema-registry/schema-registry.properties
else
    "$@"
fi
