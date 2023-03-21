#!/bin/bash

if [ "x$REPO_NAME" != "x" ];then
    if [ "x$REPO_URL" != "x" ];then
        helm repo add --force-update $REPO_NAME $REPO_URL
    fi
fi

"$@"
ECODE=$?

if [ "x$IGNORE_ERRORS" != "x" ];then
    exit 0
fi

exit $ECODE
