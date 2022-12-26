# vim: set syntax=xml:

{{ define "httpfs-site" }}

<configuration>
  <property>
    <name>httpfs.proxyuser.hue.hosts</name>
    <value>*</value>
  </property>
  
  <property>
    <name>httpfs.proxyuser.hue.groups</name>
    <value>*</value>
  </property>
</configuration>
{{- end }}
