#!/bin/bash

ZOOKEEPER_VERSION=3.9.0

SCRIPT_PATH=`realpath $0`
HERE=`dirname $SCRIPT_PATH`
PKGDIR=${HERE}/packages/

ZOOKEEPER_PACKAGE=apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz

download () {
    if [ ! -f "$2" ];then
        wget "$1" -O "$2";
        if [ "x$?" != "x0" ];then
            echo "Downloading of $2 failed" 1>&2
            rm -f "$2";
        fi
    fi
}

mkdir -p ${PKGDIR}

download https://dlcdn.apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/${ZOOKEEPER_PACKAGE} ${PKGDIR}/${ZOOKEEPER_PACKAGE}
