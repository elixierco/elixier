#!/bin/bash

if [ "x$1" == "x" ];then
    me=`realpath $0`
    echo 'Set environment variables to airflow dag repository. ' >&2
    echo "Usage: " >&2
    echo "    source $me [PATH-TO-AIRFLOW-REPO]" >&2
    echo "" >&2
    echo 'Dag repository must have `dags` and `plugins` subdirectories' >&2
    exit 1
fi

if [ ! -d "$1" ];then
    echo "No such directory $1" >&2
    exit 1
fi

repo=`realpath $1`
if [ ! -d "$repo/dags" ];then
    echo "WARNING: $repo/dags directory not found" >&2
fi

if [ ! -d "$repo/plugins" ];then
    echo "WARNING: $repo/plugins directory not found" >&2
fi

export AIRFLOW__CORE__DAGS_FOLDER=`realpath $1`/dags
export AIRFLOW__CORE__PLUGINS_FOLDER=`realpath $1`/plugins

