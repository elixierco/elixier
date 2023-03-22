#!/bin/bash

if [ "$1" == "shell" ];then
    /bin/bash
else
    if [ ! -f /var/lib/neo4j/initial-password-configured ];then
        set -e
        /usr/share/neo4j/bin/neo4j-admin set-initial-password ${NEO4J_INITIAL_PASSWORD:-neo4j}
        touch /var/lib/neo4j/initial-password-configured
        set +e
    fi
    /usr/share/neo4j/bin/neo4j "$@"
fi
