#!/bin/bash

HADOOP_VERSION=3.3.5
SPARK_VERSION=3.2.2
HIVE_VERSION=3.1.3
AWS_SDK_VERSION=1.12.372
LIVY_VERSION=0.8.0-incubating-SNAPSHOT

SCRIPT_PATH=`realpath $0`
HERE=`dirname $SCRIPT_PATH`
PKGDIR=${HERE}/packages/
HADOOP_JAR_DIR=${HERE}/hadoop-jars/
SPARK_JAR_DIR=${HERE}/spark-jars/
OTHER_JAR_DIR=${HERE}/jars/
HADOOP_MINOR_VERSION=`echo $HADOOP_VERSION|cut -d. -f1-2`

HADOOP_PACKAGE=hadoop-${HADOOP_VERSION}.tar.gz
HADOOP_AWS_JAR=hadoop-aws-${HADOOP_VERSION}.jar
HIVE_PACKAGE=apache-hive-${HIVE_VERSION}-bin.tar.gz
SPARK_PACKAGE=spark-${SPARK_VERSION}-bin-elixier.tgz
AWS_SDK_JAR=aws-java-sdk-bundle-${AWS_SDK_VERSION}.jar
LIVY_PACKAGE=apache-livy-${LIVY_VERSION}-bin.zip
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

download https://repo1.maven.org/maven2/org/apache/spark/spark-hadoop-cloud_2.12/${SPARK_VERSION}/${SPARK_HADOOP_CLOUD_JAR} ${SPARK_JAR_DIR}/${SPARK_HADOOP_CLOUD_JAR}

download https://download.oracle.com/otn-pub/otn_software/jdbc/217/ojdbc8.jar ${OTHER_JAR_DIR}/ojdbc8.jar

download https://dlcdn.apache.org/hive/hive-${HIVE_VERSION}/${HIVE_PACKAGE} ${PKGDIR}/${HIVE_PACKAGE}

cp release/${LIVY_PACKAGE} ${PKGDIR}/${LIVY_PACKAGE}

cp ../core/jars/* jars
