#!/bin/bash

INTERVAL_SECONDS=${INTERVAL_SECONDS:-60}
VERIFY_SSL=${VERIFY_SSL:-true}



if [ "$1" == "shell" ];then
    /bin/bash
else
    if [ "x$SUPERSET_URL" == "x" ];then
        echo "SUPERSET_URL environment variable is not set" >&2
        exit 1
    fi
    
    if [ "x$SUPERSET_USER" == "x" ];then
        echo "SUPERSET_USER environment variable is not set" >&2
        exit 1
    fi
    
    
    if [ "x$SUPERSET_PASS" == "x" ];then
        echo "SUPERSET_PASS environment variable is not set" >&2
        exit 1
    fi
    
    
    if [ "x$DAG_OUTPUT_DIRECTORY" == "x" ];then
        echo "DAG_OUTPUT_DIRECTORY environment variable is not set" >&2
        exit 1
    fi
    while true;do
        CMD="/usr/bin/python3 /opt/airflow_superset/airflow_superset.py -u ${SUPERSET_URL} -U ${SUPERSET_USER} -P ${SUPERSET_PASS} -O ${DAG_OUTPUT_DIRECTORY}"
        if [ $VERIFY_SSL != "true" ];then
            CMD="${CMD} --insecure"
        fi
        $CMD
        sleep ${INTERVAL_SECONDS}
    done
fi
