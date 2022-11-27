#!/bin/bash

HADOOP_VERSION=3.2.3
SPARK_VERSION=3.2.0
NODEJS_VERSION=18.12.1

SCRIPT_PATH=`realpath $0`
HERE=`dirname $SCRIPT_PATH`
PKGDIR=${HERE}/packages/
HADOOP_MINOR_VERSION=`echo $HADOOP_VERSION|cut -d. -f1-2`

HADOOP_PACKAGE=hadoop-${HADOOP_VERSION}.tar.gz
SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_MINOR_VERSION}.tgz
NODEJS_PACKAGE=node-v${NODEJS_VERSION}-linux-x64.tar.gz

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

# hadoop
download https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/${HADOOP_PACKAGE} ${PKGDIR}/${HADOOP_PACKAGE}
download https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE} ${PKGDIR}/${SPARK_PACKAGE}
download https://nodejs.org/dist/v${NODEJS_VERSION}/${NODEJS_PACKAGE} ${PKGDIR}/${NODEJS_PACKAGE}
download https://dl.min.io/client/mc/release/linux-amd64/mc ${PKGDIR}/mc
