{{- define "presto-ranger-security" -}}
<configuration>
  <property>
    <name>ranger.plugin.presto.service.name</name>
    <value>presto</value>
    <description>
      Name of the Ranger service containing policies for this Presto instance
    </description>
  </property>

  <property>
    <name>ranger.plugin.presto.policy.source.impl</name>
    <value>org.apache.ranger.admin.client.RangerAdminRESTClient</value>
    <description>
      Class to retrieve policies from the source
    </description>
  </property>

  <property>
    <name>ranger.plugin.presto.policy.rest.url</name>
    <value>{{ .Values.ranger.url }}</value>
    <description>
      URL to Ranger Admin
    </description>
  </property>

  <property>
    <name>ranger.plugin.presto.policy.rest.ssl.config.file</name>
    <value>/opt/presto/etc/ranger-policymgr-ssl.xml</value>
    <description>
      Path to the file containing SSL details to contact Ranger Admin
    </description>
  </property>

  <property>
    <name>ranger.plugin.presto.policy.pollIntervalMs</name>
    <value>30000</value>
    <description>
      How often to poll for changes in policies?
    </description>
  </property>

  <property>
    <name>ranger.plugin.presto.policy.rest.client.connection.timeoutMs</name>
    <value>120000</value>
    <description>
      S3 Plugin RangerRestClient Connection Timeout in Milli Seconds
    </description>
  </property>

  <property>
    <name>ranger.plugin.presto.policy.rest.client.read.timeoutMs</name>
    <value>30000</value>
    <description>
      S3 Plugin RangerRestClient read Timeout in Milli Seconds
    </description>
  </property>
<property>
        <name>ranger.plugin.presto.policy.cache.dir</name>
        <value>/etc/ranger/presto/policycache</value>
    </property>
</configuration>

{{ end }}
