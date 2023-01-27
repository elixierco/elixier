#!/bin/bash 

PRESTO_VERSION=0.278.1
COMMONS_COMPRESS_VERSION=1.22
SCRIPT_PATH=`realpath $0`
HERE=`dirname $SCRIPT_PATH`
PKGDIR=${HERE}/packages/

RANGER_PACKAGE=apache-ranger-${RANGER_VERSION}.tar.gz
PRESTO_CLI_JAR=presto-cli-${PRESTO_VERSION}-executable.jar
PRESTO_PACKAGE=presto-server-${PRESTO_VERSION}.tar.gz
COMMONS_COMPRESS_JAR=commons-compress-${COMMONS_COMPRESS_VERSION}.jar

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

download https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/${PRESTO_PACKAGE} ${PKGDIR}/${PRESTO_PACKAGE}
download https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/${PRESTO_CLI_JAR} ${PKGDIR}/${PRESTO_CLI_JAR}
download https://repo1.maven.org/maven2/org/apache/commons/commons-compress/${COMMONS_COMPRESS_VERSION}/${COMMONS_COMPRESS_JAR} ${PKGDIR}/${COMMONS_COMPRESS_JAR}
