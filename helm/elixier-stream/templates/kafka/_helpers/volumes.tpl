{{ define "elixier-stream.kafka.volumes" }}
- name: {{ include "elixier-stream.fullname" . }}-kafka-config
  secret:
    secretName: {{ include "elixier-stream.fullname" . }}-kafka-config
- name: {{ include "elixier-stream.fullname" . }}-kafka-logdir
  emptyDir: {}
{{- end }}

{{ define "elixier-stream.kafka.volume-mounts" }}
- name: {{ include "elixier-stream.fullname" . }}-kafka-datadir
  mountPath: "/var/lib/kafka"
- name: {{ include "elixier-stream.fullname" . }}-kafka-config
  mountPath: "/etc/kafka/"
- name: {{ include "elixier-stream.fullname" . }}-kafka-logdir
  mountPath: "/opt/apache/kafka/logs/"
{{- end }}

