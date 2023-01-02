#!/bin/bash

K8S_POD_NAME=${K8S_POD_NAME:-node-0}
NODE_ID=$((${K8S_POD_NAME##*-} + 1))
KAFKA_LOG_DIRS=${KAFKA_LOG_DIRS:-/var/lib/kafka/}

cp /etc/kafka/server.properties /tmp/server.properties
echo "node.id=$NODE_ID" >> /tmp/server.properties

for LD in ${KAFKA_LOG_DIRS//,/ };do
    mkdir -p $LD
done

echo "log.dirs=$KAFKA_LOG_DIRS" >> /tmp/server.properties

if [ "$1" == "start" ];then
    if [ "x$KAFKA_CLUSTER_ID" == "x" ];then
        echo "KAFKA_CLUSTER_ID is not set" >&2
        exit 1
    fi
    /opt/apache/kafka/bin/kafka-storage.sh format --config /tmp/server.properties --cluster-id "${KAFKA_CLUSTER_ID}" --ignore-formatted
    /opt/apache/kafka/bin/kafka-server-start.sh /tmp/server.properties
else
    "$@"
fi
