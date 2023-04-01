#!/bin/bash 

RANGER_VERSION=2.3.0
NIFI_VERSION=1.20.0

SCRIPT_PATH=`realpath $0`
HERE=`dirname $SCRIPT_PATH`
PKGDIR=${HERE}/packages/

NIFI_PACKAGE=nifi-${NIFI_VERSION}-bin.zip

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

download https://dlcdn.apache.org/nifi/${NIFI_VERSION}/${NIFI_PACKAGE}  ${PKGDIR}/${NIFI_PACKAGE}
