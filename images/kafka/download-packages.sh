#!/bin/bash

KAFKA_VERSION=3.3.1
SCALA_VERSION=2.12

SCRIPT_PATH=`realpath $0`
HERE=`dirname $SCRIPT_PATH`
PKGDIR=${HERE}/packages/

KAFKA_PACKAGE=kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

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

download https://downloads.apache.org/kafka/${KAFKA_VERSION}/${KAFKA_PACKAGE} ${PKGDIR}/${KAFKA_PACKAGE}
