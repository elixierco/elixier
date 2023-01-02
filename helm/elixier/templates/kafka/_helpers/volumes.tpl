{{ define "elixier.kafka.volumes" }}
- name: {{ include "elixier.fullname" . }}-kafka-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-kafka-config
- name: {{ include "elixier.fullname" . }}-kafka-logdir
  emptyDir: {}
{{- end }}

{{ define "elixier.kafka.volume-mounts" }}
- name: {{ include "elixier.fullname" . }}-kafka-datadir
  mountPath: "/var/lib/kafka"
- name: {{ include "elixier.fullname" . }}-kafka-config
  mountPath: "/etc/kafka/"
- name: {{ include "elixier.fullname" . }}-kafka-logdir
  mountPath: "/opt/apache/kafka/logs/"
{{- end }}

