{{ define "opensearch.volumes" }}
{{- end }}

{{ define "opensearch.volumeMounts" }}
- name: {{ include "opensearch.fullname" . }}-datadir
  mountPath: "/usr/share/opensearch/data"
{{- end }}

