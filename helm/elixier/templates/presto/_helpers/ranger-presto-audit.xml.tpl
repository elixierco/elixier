{{- define "presto-ranger-audit" -}}
<configuration xmlns:xi="http://www.w3.org/2001/XInclude">
    <property>
        <name>xasecure.audit.is.enabled</name>
        <value>true</value>
    </property>

    <!-- HDFS audit provider configuration -->
    <property>
        <name>xasecure.audit.hdfs.is.enabled</name>
        <value>false</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.is.async</name>
        <value>true</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.async.max.queue.size</name>
        <value>1048576</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.async.max.flush.interval.ms</name>
        <value>30000</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.encoding</name>
        <value/>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.destination.directory</name>
        <value>hdfs://__REPLACE__NAME_NODE_HOST:8020/ranger/audit/%app-type%/%time:yyyyMMdd%</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.destination.file</name>
        <value>%hostname%-audit.log</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.destination.flush.interval.seconds</name>
        <value>900</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.destination.rollover.interval.seconds</name>
        <value>86400</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.destination.open.retry.interval.seconds</name>
        <value>60</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.local.buffer.directory</name>
        <value>__REPLACE__LOG_DIR/presto/audit</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.local.buffer.file</name>
        <value>%time:yyyyMMdd-HHmm.ss%.log</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.local.buffer.file.buffer.size.bytes</name>
        <value>8192</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.local.buffer.flush.interval.seconds</name>
        <value>60</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.local.buffer.rollover.interval.seconds</name>
        <value>600</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.local.archive.directory</name>
        <value>__REPLACE__LOG_DIR/presto/audit/archive</value>
    </property>

    <property>
        <name>xasecure.audit.hdfs.config.local.archive.max.file.count</name>
        <value>10</value>
    </property>

    <!-- Audit to HDFS on Azure Datastore (WASB) requires v3 style settings.  Comment the above and uncomment only the
    following to audit to Azure Blob Datastore via hdfs' WASB schema.

    NOTE: If you specify one audit destination in v3 style then other destinations, if any, must also be specified in v3 style
    ====

    <property>
        <name>xasecure.audit.destination.hdfs</name>
        <value>enabled</value>
    </property>

    <property>
        <name>xasecure.audit.destination.hdfs.dir</name>
        <value>wasb://ranger-audit1@youraccount.blob.core.windows.net</value>
    </property>

    the following 3 correspond to the properties with similar name in core-site.xml, i.e.
    - fs.azure.account.key.youraccount.blob.core.windows.net => xasecure.audit.destination.hdfs.config.fs.azure.account.key.youraccount.blob.core.windows.net and
    - fs.azure.account.keyprovider.youraccount.blob.core.windows.net => xasecure.audit.destination.hdfs.config.fs.azure.account.keyprovider.youraccount.blob.core.windows.net,
    - fs.azure.shellkeyprovider.script => xasecure.audit.destination.hdfs.config.fs.azure.shellkeyprovider.script,

    <property>
        <name>xasecure.audit.destination.hdfs.config.fs.azure.account.key.youraccount.blob.core.windows.net</name>
        <value>YOUR ENCRYPTED ACCESS KEY</value>
    </property>

    <property>
        <name>xasecure.audit.destination.hdfs.config.fs.azure.account.keyprovider.youraccount.blob.core.windows.net</name>
        <value>org.apache.hadoop.fs.azure.ShellDecryptionKeyProvider</value>
    </property>

    <property>
        <name>xasecure.audit.destination.hdfs.config.fs.azure.shellkeyprovider.script</name>
        <value>/usr/lib/python2.7/dist-packages/hdinsight_common/decrypt.sh</value>
    </property>
    -->

    <!-- Log4j audit provider configuration -->
    <property>
        <name>xasecure.audit.log4j.is.enabled</name>
        <value>false</value>
    </property>

    <property>
        <name>xasecure.audit.log4j.is.async</name>
        <value>false</value>
    </property>

    <property>
        <name>xasecure.audit.log4j.async.max.queue.size</name>
        <value>10240</value>
    </property>

    <property>
        <name>xasecure.audit.log4j.async.max.flush.interval.ms</name>
        <value>30000</value>
    </property>


    <!-- presto audit provider configuration -->
    <property>
        <name>xasecure.audit.presto.is.enabled</name>
        <value>false</value>
    </property>

    <property>
        <name>xasecure.audit.presto.async.max.queue.size</name>
        <value>1</value>
    </property>

    <property>
        <name>xasecure.audit.presto.async.max.flush.interval.ms</name>
        <value>1000</value>
    </property>

    <property>
        <name>xasecure.audit.presto.broker_list</name>
        <value>localhost:9092</value>
    </property>

    <property>
        <name>xasecure.audit.presto.topic_name</name>
        <value>ranger_audits</value>
    </property>

    <!-- Ranger audit provider configuration -->
    <property>
        <name>xasecure.audit.solr.is.enabled</name>
        <value>false</value>
    </property>

    <property>
        <name>xasecure.audit.solr.async.max.queue.size</name>
        <value>1</value>
    </property>

    <property>
        <name>xasecure.audit.solr.async.max.flush.interval.ms</name>
        <value>1000</value>
    </property>

    <property>
        <name>xasecure.audit.solr.solr_url</name>
        <value>http://localhost:6083/solr/ranger_audits</value>
    </property>
<property>
        <name>xasecure.audit.provider.summary.enabled</name>
        <value>true</value>
    </property>
    <property>
        <name>xasecure.audit.destination.solr</name>
        <value>false</value>
    </property>
    <property>
        <name>xasecure.audit.destination.solr.urls</name>
        <value>NONE</value>
    </property>
    <property>
        <name>xasecure.audit.destination.solr.user</name>
        <value>NONE</value>
    </property>
    <property>
        <name>xasecure.audit.destination.solr.password</name>
        <value>NONE</value>
    </property>
    <property>
        <name>xasecure.audit.destination.solr.zookeepers</name>
        <value>NONE</value>
    </property>
    <property>
        <name>xasecure.audit.destination.solr.batch.filespool.dir</name>
        <value>/var/log/presto/audit/solr/spool</value>
    </property>
    <property>
        <name>xasecure.audit.destination.elasticsearch</name>
        <value>true</value>
    </property>
    <property>
        <name>xasecure.audit.destination.elasticsearch.urls</name>
        <value>{{ .Values.ranger.opensearch_urls }}</value>
    </property>
    <property>
        <name>xasecure.audit.destination.elasticsearch.user</name>
        <value>{{ .Values.ranger.opensearch_user }}</value>
    </property>
    <property>
        <name>xasecure.audit.destination.elasticsearch.password</name>
        <value>{{ .Values.ranger.opensearch_password }}</value>
    </property>
    <property>
        <name>xasecure.audit.destination.elasticsearch.index</name>
        <value>{{ .Values.ranger.opensearch_index | default "ranger_audit" }}</value>
    </property>
    <property>
        <name>xasecure.audit.destination.elasticsearch.port</name>
        <value>{{ .Values.ranger.opensearch_port | default "9200" }}</value>
    </property>
    <property>
        <name>xasecure.audit.destination.elasticsearch.protocol</name>
        <value>{{ .Values.ranger.opensearch_proto | default "http" }}</value>
    </property>
    <property>
        <name>xasecure.audit.destination.amazon_cloudwatch</name>
        <value>false</value>
    </property>
    <property>
        <name>xasecure.audit.destination.amazon_cloudwatch.log_group</name>
        <value>NONE</value>
    </property>
    <property>
        <name>xasecure.audit.destination.amazon_cloudwatch.log_stream_prefix</name>
        <value>NONE</value>
    </property>
    <property>
        <name>xasecure.audit.destination.amazon_cloudwatch.batch.filespool.dir</name>
        <value>NONE</value>
    </property>
    <property>
        <name>xasecure.audit.destination.amazon_cloudwatch.region</name>
        <value>NONE</value>
    </property>
    <property>
        <name>xasecure.audit.destination.hdfs</name>
        <value>false</value>
    </property>
    <property>
        <name>xasecure.audit.destination.hdfs.batch.filespool.dir</name>
        <value>/var/log/presto/audit/hdfs/spool</value>
    </property>
    <property>
        <name>xasecure.audit.destination.hdfs.dir</name>
        <value>hdfs://__REPLACE__NAME_NODE_HOST:8020/ranger/audit</value>
    </property>
    <property>
        <name>xasecure.audit.destination.hdfs.config.fs.azure.shellkeyprovider.script</name>
        <value>__REPLACE_AZURE_SHELL_KEY_PROVIDER</value>
    </property>
    <property>
        <name>xasecure.audit.destination.hdfs.config.fs.azure.account.key.__REPLACE_AZURE_ACCOUNT_NAME.blob.core.windows.net</name>
        <value>__REPLACE_AZURE_ACCOUNT_KEY</value>
    </property>
    <property>
        <name>xasecure.audit.destination.hdfs.config.fs.azure.account.keyprovider.__REPLACE_AZURE_ACCOUNT_NAME.blob.core.windows.net</name>
        <value>__REPLACE_AZURE_ACCOUNT_KEY_PROVIDER</value>
    </property>
    <property>
        <name>xasecure.audit.destination.log4j</name>
        <value>true</value>
    </property>
    <property>
        <name>xasecure.audit.destination.log4j.logger</name>
        <value>xaaudit</value>
    </property>
</configuration>

{{ end }}
