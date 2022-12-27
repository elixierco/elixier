{{ define "elixier.superset.volumes" }}
- name: {{ include "elixier.fullname" . }}-superset-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-superset-config
- name: {{ include "elixier.fullname" . }}-superset-datadir
  emptyDir: {}
- name: {{ include "elixier.fullname" . }}-superset-logdir
  emptyDir: {}
{{- end }}

{{ define "elixier.superset.volume-mounts" }}
- name: {{ include "elixier.fullname" . }}-superset-config
  mountPath: "/etc/superset"
- name: {{ include "elixier.fullname" . }}-superset-datadir
  mountPath: "/var/lib/superset"
- name: {{ include "elixier.fullname" . }}-superset-logdir
  mountPath: "/var/log/superset"
{{- end }}

