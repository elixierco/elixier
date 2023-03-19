#!/bin/bash

SCHEMAREGISTRY_LOG_DIR=${SCHEMAREGISTRY_LOG_DIR:-/var/log/schemaregistry/}

mkdir -p $SCHEMAREGISTRY_LOG_DIR

export LOG_DIR=$SCHEMAREGISTRY_LOG_DIR

if [ "$1" == "start" ];then
    /usr/bin/schema-registry-start /etc/schema-registry/schema-registry.properties
else
    "$@"
fi
