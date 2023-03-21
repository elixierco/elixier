#!/bin/bash

if [ "$1" == "shell" ];then
    /bin/bash
else
    /usr/share/neo4j/bin/neo4j "$@"
fi
