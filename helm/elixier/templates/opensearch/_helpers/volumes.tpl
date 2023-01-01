{{ define "elixier.opensearch.volumes" }}
{{- end }}

{{ define "elixier.opensearch.volume-mounts" }}
- name: {{ include "elixier.fullname" . }}-opensearch-datadir
  mountPath: "/usr/share/opensearch/data"
{{- end }}

