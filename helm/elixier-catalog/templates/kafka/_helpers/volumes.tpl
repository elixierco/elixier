{{ define "elixier-catalog.kafka.volumes" }}
- name: {{ include "elixier-catalog.fullname" . }}-kafka-config
  secret:
    secretName: {{ include "elixier-catalog.fullname" . }}-kafka-config
- name: {{ include "elixier-catalog.fullname" . }}-kafka-logdir
  emptyDir: {}
{{- end }}

{{ define "elixier-catalog.kafka.volume-mounts" }}
- name: {{ include "elixier-catalog.fullname" . }}-kafka-datadir
  mountPath: "/var/lib/kafka"
- name: {{ include "elixier-catalog.fullname" . }}-kafka-config
  mountPath: "/etc/kafka/"
- name: {{ include "elixier-catalog.fullname" . }}-kafka-logdir
  mountPath: "/opt/apache/kafka/logs/"
{{- end }}

