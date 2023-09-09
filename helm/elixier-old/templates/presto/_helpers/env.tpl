# vim: set filetype=yaml:
{{- define "elixier.presto.volumes" }}
- name: config
  secret:
    secretName: {{ include "elixier.fullname" . }}-presto-cfg
- name: jvm-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-presto-cfg
- name: ranger-presto-audit
  secret:
    secretName: {{ include "elixier.fullname" . }}-presto-cfg
- name: ranger-presto-security
  secret:
    secretName: {{ include "elixier.fullname" . }}-presto-cfg
- name: ranger-presto-policymgr-ssl
  secret:
    secretName: {{ include "elixier.fullname" . }}-presto-cfg
- name: access-control-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-presto-cfg
- name: log-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-presto-cfg
- name: data
  emptyDir: {}
- name: var
  emptyDir: {}
- name: catalog
  persistentVolumeClaim:
    claimName: {{ include "elixier.fullname" . }}-presto-catalogs
{{- end }}

{{- define "elixier.presto.volume-mounts" }}
- name: jvm-config
  mountPath: "/etc/presto/jvm.config"
  subPath: jvm.config
- name: ranger-presto-audit
  mountPath: "/etc/presto/ranger-presto-audit.xml"
  subPath: ranger-presto-audit.xml
- name: ranger-presto-security
  mountPath: "/etc/presto/ranger-presto-security.xml"
  subPath: ranger-presto-security.xml
- name: ranger-presto-policymgr-ssl 
  mountPath: "/etc/presto/ranger-policymgr-ssl.xml"
  subPath: ranger-policymgr-ssl.xml
- name: access-control-config
  mountPath: "/etc/presto/access-control.properties"
  subPath: access-control.properties
- name: log-config
  mountPath: "/etc/presto/log.properties"
  subPath: log.properties
- name: data
  mountPath: "/data"
- name: var
  mountPath: "/opt/presto/var"
- name: catalog
  mountPath: "/opt/presto/etc/catalog"
{{- end }}
