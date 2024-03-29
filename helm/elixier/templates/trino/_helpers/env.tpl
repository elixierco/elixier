# vim: set filetype=yaml:
{{- define "elixier.trino.volumes" }}
- name: config
  secret:
    secretName: {{ include "elixier.fullname" . }}-trino-cfg
- name: jvm-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-trino-cfg
- name: ranger-trino-audit
  secret:
    secretName: {{ include "elixier.fullname" . }}-trino-cfg
- name: ranger-trino-security
  secret:
    secretName: {{ include "elixier.fullname" . }}-trino-cfg
- name: ranger-trino-policymgr-ssl
  secret:
    secretName: {{ include "elixier.fullname" . }}-trino-cfg
- name: access-control-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-trino-cfg
- name: log-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-trino-cfg
- name: data
  emptyDir: {}
- name: var
  emptyDir: {}
- name: catalog
  persistentVolumeClaim:
    claimName: {{ include "elixier.fullname" . }}-trino-catalogs
{{- end }}

{{- define "elixier.trino.volume-mounts" }}
- name: jvm-config
  mountPath: "/etc/trino/jvm.config"
  subPath: jvm.config
- name: ranger-trino-audit
  mountPath: "/etc/trino/ranger-trino-audit.xml"
  subPath: ranger-trino-audit.xml
- name: ranger-trino-security
  mountPath: "/etc/trino/ranger-trino-security.xml"
  subPath: ranger-trino-security.xml
- name: ranger-trino-policymgr-ssl 
  mountPath: "/etc/trino/ranger-policymgr-ssl.xml"
  subPath: ranger-policymgr-ssl.xml
- name: access-control-config
  mountPath: "/etc/trino/access-control.properties"
  subPath: access-control.properties
- name: log-config
  mountPath: "/etc/trino/log.properties"
  subPath: log.properties
- name: data
  mountPath: "/data"
- name: var
  mountPath: "/opt/trino/var"
- name: catalog
  mountPath: "/opt/trino/etc/catalog"
{{- end }}
