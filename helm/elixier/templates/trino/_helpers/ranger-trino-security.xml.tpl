{{- define "trino-ranger-security" -}}
<configuration>
  <property>
    <name>ranger.plugin.trino.service.name</name>
    <value>trino</value>
    <description>
      Name of the Ranger service containing policies for this Trino instance
    </description>
  </property>

  <property>
    <name>ranger.plugin.trino.policy.source.impl</name>
    <value>org.apache.ranger.admin.client.RangerAdminRESTClient</value>
    <description>
      Class to retrieve policies from the source
    </description>
  </property>

  <property>
    <name>ranger.plugin.trino.policy.rest.url</name>
    <value>{{ .Values.ranger.url }}</value>
    <description>
      URL to Ranger Admin
    </description>
  </property>

  <property>
    <name>ranger.plugin.trino.policy.rest.ssl.config.file</name>
    <value>/opt/trino/etc/ranger-policymgr-ssl.xml</value>
    <description>
      Path to the file containing SSL details to contact Ranger Admin
    </description>
  </property>

  <property>
    <name>ranger.plugin.trino.policy.pollIntervalMs</name>
    <value>30000</value>
    <description>
      How often to poll for changes in policies?
    </description>
  </property>

  <property>
    <name>ranger.plugin.trino.policy.rest.client.connection.timeoutMs</name>
    <value>120000</value>
    <description>
      S3 Plugin RangerRestClient Connection Timeout in Milli Seconds
    </description>
  </property>

  <property>
    <name>ranger.plugin.trino.policy.rest.client.read.timeoutMs</name>
    <value>30000</value>
    <description>
      S3 Plugin RangerRestClient read Timeout in Milli Seconds
    </description>
  </property>
<property>
        <name>ranger.plugin.trino.policy.cache.dir</name>
        <value>/etc/ranger/trino/policycache</value>
    </property>
</configuration>

{{ end }}
