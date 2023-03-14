#!/bin/bash 

TRINO_VERSION=389
RANGER_VERSION=2.3.0
COMMONS_LANG3_VERSION=3.12.0

COMMONS_COMPRESS_VERSION=1.22
SCRIPT_PATH=`realpath $0`
HERE=`dirname $SCRIPT_PATH`
PKGDIR=${HERE}/packages/

RANGER_PACKAGE=apache-ranger-${RANGER_VERSION}.tar.gz
TRINO_CLI_JAR=trino-cli-${TRINO_VERSION}-executable.jar
TRINO_PACKAGE=trino-server-${TRINO_VERSION}.tar.gz
COMMONS_COMPRESS_JAR=commons-compress-${COMMONS_COMPRESS_VERSION}.jar
COMMONS_LANG3_JAR=commons-lang3-${COMMONS_LANG3_VERSION}.jar
RANGER_PLUGIN_PACKAGE=ranger-${RANGER_VERSION}-trino-plugin.tar.gz

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

download https://repo1.maven.org/maven2/io/trino/trino-server/${TRINO_VERSION}/${TRINO_PACKAGE} ${PKGDIR}/${TRINO_PACKAGE}
download https://repo1.maven.org/maven2/io/trino/trino-cli/${TRINO_VERSION}/${TRINO_CLI_JAR} ${PKGDIR}/${TRINO_CLI_JAR}
download https://repo1.maven.org/maven2/org/apache/commons/commons-compress/${COMMONS_COMPRESS_VERSION}/${COMMONS_COMPRESS_JAR} ${PKGDIR}/${COMMONS_COMPRESS_JAR}
download https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/${COMMONS_LANG3_VERSION}/${COMMONS_LANG3_JAR} ${PKGDIR}/${COMMONS_LANG3_JAR}
cp ${HERE}/../ranger/release/${RANGER_PLUGIN_PACKAGE} ${PKGDIR}/${RANGER_PLUGIN_PACKAGE}
