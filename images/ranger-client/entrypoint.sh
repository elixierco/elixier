#!/bin/bash


if [ "$1" == "create-service" ];then
   python3 /opt/create-service.py "${@:2}"
   exit $?
else
   echo "Unknown command"
fi
