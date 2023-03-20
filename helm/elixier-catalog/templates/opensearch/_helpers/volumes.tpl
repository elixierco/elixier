{{ define "elixier-catalog.opensearch.volumes" }}
{{- end }}

{{ define "elixier-catalog.opensearch.volume-mounts" }}
- name: {{ include "elixier-catalog.fullname" . }}-opensearch-datadir
  mountPath: "/usr/share/opensearch/data"
{{- end }}

