{{ define "elixier.livy.volumes" }}
- name: {{ include "elixier.fullname" . }}-livy-spark-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-livy-spark-config
{{ end }}


{{ define "elixier.livy.volume-mounts" }}
- name: {{ include "elixier.fullname" . }}-livy-spark-config
  mountPath: "/etc/livy-spark/"
{{ end }}
