#!/bin/bash

RANGER_VERSION=2.3.0
TRINO_VERSION=389

SCRIPT_PATH=`realpath $0`
HERE=`dirname $SCRIPT_PATH`
PKGDIR=${HERE}/packages/

RANGER_PACKAGE=elixier-ranger-${RANGER_VERSION}.tar.gz
TRINO_DRIVER_JAR=trino-jdbc-${TRINO_VERSION}.jar

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

#download https://dlcdn.apache.org/ranger/${RANGER_VERSION}/${RANGER_PACKAGE} ${PKGDIR}/${RANGER_PACKAGE}
#https://github.com/elixierdata/ranger/archive/refs/heads/elixier-ranger-2.3.0.tar.gz
download https://github.com/elixierco/ranger/archive/refs/heads/${RANGER_PACKAGE} ${PKGDIR}/${RANGER_PACKAGE}
download https://repo1.maven.org/maven2/io/trino/trino-jdbc/${TRINO_VERSION}/${TRINO_DRIVER_JAR} ${PKGDIR}/${TRINO_DRIVER_JAR}
