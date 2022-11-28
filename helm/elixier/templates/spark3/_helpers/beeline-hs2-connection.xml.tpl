{{- define "beeline-hs2-connection" -}}
<?xml version="1.0"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
<configuration>
    <property>
          <name>beeline.hs2.connection.hosts</name>
          <value>{{ include "elixier.fullname" . }}-sparksql:10000</value>
    </property>
</configuration>
{{- end }}
