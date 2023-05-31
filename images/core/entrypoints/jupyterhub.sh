#!/bin/bash

TOKEN=${JUPYTER_LAB_TOKEN:-''}
JUPYTERHUB_CONFIG=${JUPYTERHUB_CONFIG:-/etc/jupyterhub/jupyterhub_config.py}
set -ex

if [ "$1" == "debug" ];then
    tail -f /dev/null
elif [ "$1" == "hub" ];then
    pushd `dirname $JUPYTERHUB_CONFIG`
        jupyterhub upgrade-db
    popd
    jupyterhub -f /etc/jupyterhub/jupyterhub_config.py
elif [ "$1" == "lab" ];then
    /opt/jupyterhub/bin/jupyter lab --ip 0.0.0.0 --port 8000 --NotebookApp.token="${TOKEN}"
elif [ "$1" == "jupyterhub-singleuser" ];then
    export K8S_POD_NAME=`hostname -s`
    userdel -f user
    groupadd ${JUPYTERHUB_USER} -g 1000
    useradd ${JUPYTERHUB_USER} -u 1000 -g 1000
    cd /home/${JUPYTERHUB_USER}
    chown -R ${JUPYTERHUB_USER}:${JUPYTERHUB_USER} /home/${JUPYTERHUB_USER}
    chmod 0755 /home/${JUPYTERHUB_USER}/
    mkdir -p /home/${JUPYTERHUB_USER}/.config/airflow
    export AIRFLOW_HOME=/home/${JUPYTERHUB_USER}/.config/airflow
    sudo -E -u ${JUPYTERHUB_USER} -- env "PATH=$PATH" "$@"
else
    "$@"
fi
