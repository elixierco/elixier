#!/bin/bash

HADOOP_VERSION=3.2.3
SPARK_VERSION=3.1.3
NODEJS_VERSION=18.12.1
AWS_SDK_VERSION=1.12.372
PRESTO_VERSION=0.278.1
TRINO_VERSION=389
LIVY_VERSION=0.7.1
CODESERVER_VERSION=4.11.0

SCRIPT_PATH=`realpath $0`
HERE=`dirname $SCRIPT_PATH`
PKGDIR=${HERE}/packages/
SPARK_JAR_DIR=${HERE}/spark-jars/
HADOOP_JAR_DIR=${HERE}/hadoop-jars/
OTHER_JAR_DIR=${HERE}/jars/
HADOOP_MINOR_VERSION=`echo $HADOOP_VERSION|cut -d. -f1-2`

HADOOP_PACKAGE=hadoop-${HADOOP_VERSION}.tar.gz
HADOOP_AWS_JAR=hadoop-aws-${HADOOP_VERSION}.jar
SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-hadoop${HADOOP_MINOR_VERSION}.tgz
NODEJS_PACKAGE=node-v${NODEJS_VERSION}-linux-x64.tar.gz
AWS_SDK_JAR=aws-java-sdk-bundle-${AWS_SDK_VERSION}.jar
PRESTO_CLI_JAR=presto-cli-${PRESTO_VERSION}-executable.jar
TRINO_CLI_JAR=trino-cli-${TRINO_VERSION}-executable.jar
LIVY_PACKAGE=apache-livy-${LIVY_VERSION}-incubating-bin.zip
CODESERVER_PACKAGE=code-server-${CODESERVER_VERSION}-linux-amd64.tar.gz
SPARK_HADOOP_CLOUD_JAR=spark-hadoop-cloud_2.12-${SPARK_VERSION}.jar

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
mkdir -p ${HADOOP_JAR_DIR}
mkdir -p ${SPARK_JAR_DIR}
mkdir -p ${OTHER_JAR_DIR}

# hadoop
download https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/${HADOOP_PACKAGE} ${PKGDIR}/${HADOOP_PACKAGE}

#download https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/${SPARK_PACKAGE} ${PKGDIR}/${SPARK_PACKAGE}

download https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/${HADOOP_VERSION}/${HADOOP_AWS_JAR} ${HADOOP_JAR_DIR}/${HADOOP_AWS_JAR}

download https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/${AWS_SDK_VERSION}/${AWS_SDK_JAR} ${HADOOP_JAR_DIR}/${AWS_SDK_JAR}

download https://nodejs.org/dist/v${NODEJS_VERSION}/${NODEJS_PACKAGE} ${PKGDIR}/${NODEJS_PACKAGE}

download https://dl.min.io/client/mc/release/linux-amd64/mc ${PKGDIR}/mc

download https://repo1.maven.org/maven2/com/facebook/presto/presto-cli/${PRESTO_VERSION}/${PRESTO_CLI_JAR} ${PKGDIR}/${PRESTO_CLI_JAR}

download https://repo1.maven.org/maven2/io/trino/trino-cli/${TRINO_VERSION}/${TRINO_CLI_JAR} ${PKGDIR}/${TRINO_CLI_JAR}

download https://github.com/coder/code-server/releases/download/v${CODESERVER_VERSION}/${CODESERVER_PACKAGE} ${PKGDIR}/${CODESERVER_PACKAGE}

download https://dlcdn.apache.org/incubator/livy/${LIVY_VERSION}-incubating/${LIVY_PACKAGE} ${PKGDIR}/${LIVY_PACKAGE}

download https://repo1.maven.org/maven2/org/apache/spark/spark-hadoop-cloud_2.12/${SPARK_VERSION}/${SPARK_HADOOP_CLOUD_JAR} ${SPARK_JAR_DIR}/${SPARK_HADOOP_CLOUD_JAR}

download https://download.oracle.com/otn-pub/otn_software/jdbc/217/ojdbc8.jar ${OTHER_JAR_DIR}/ojdbc8.jar

