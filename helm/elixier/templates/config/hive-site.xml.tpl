{{- define "hive-site.xml" }}
<configuration>
        <property>
                <name>hive.metastore.uris</name>
                <value>{{ include "hivemetastore.url" . }}</value>
        </property>
        <property>
                <name>javax.jdo.option.ConnectionURL</name>
                <value>{{ include "hivemetastore.dbUrl" . }}</value>
        </property>
        <property>
                <name>javax.jdo.option.ConnectionDriverName</name>
                <value>{{ .Values.global.metastore.dbDriver }}</value>
        </property>
        <property>
                <name>javax.jdo.option.ConnectionUserName</name>
                <value>{{ .Values.global.metastore.dbUser }}</value>
        </property>
        <property>
                <name>javax.jdo.option.ConnectionPassword</name>
                <value>{{ .Values.global.metastore.dbPass }}</value>
        </property>
        <property>
                <name>hive.metastore.warehouse.dir</name>
                <value>{{ .Values.global.s3a.warehouseDir }}</value>
        </property>
        <property>
                <name>fs.s3a.endpoint</name>
                <value>{{ .Values.global.s3a.endpoint }}</value>
        </property>
        <property>
                <name>fs.s3a.access.key</name>
                <value>{{ .Values.global.s3a.accessKey }}</value>
        </property>
        <property>
                <name>fs.s3a.secret.key</name>
                <value>{{ .Values.global.s3a.secretKey }}</value>
        </property>
        <property>
                <name>fs.s3a.path.style.access</name>
                <value>true</value>
        </property>
        <property>
                <name>fs.s3a.impl</name>
                <value>org.apache.hadoop.fs.s3a.S3AFileSystem</value>
        </property>
        <property>
                <name>fs.s3a.aws.credentials.provider</name>
                <value>org.apache.hadoop.fs.s3a.SimpleAWSCredentialsProvider</value>
        </property>
        <property>
                <name>hive.metastore.schema.verification</name>
                <value>false</value>
        </property>
        <property>
                <name>hive.metastore.schema.verification.record.version</name>
                <value>false</value>
        </property>
</configuration>
{{- end }}

