{{ define "kafka.volumes" }}
- name: {{ include "kafka.fullname" . }}-config
  configMap:
    name: {{ include "kafka.fullname" . }}-config
- name: {{ include "kafka.fullname" . }}-logdir
  emptyDir: {}
{{- end }}

{{ define "kafka.volumeMounts" }}
- name: {{ include "kafka.fullname" . }}-datadir
  mountPath: "/var/lib/kafka"
- name: {{ include "kafka.fullname" . }}-config
  mountPath: "/etc/kafka"
- name: {{ include "kafka.fullname" . }}-logdir
  mountPath: "/opt/apache/kafka/logs/"
{{- end }}

