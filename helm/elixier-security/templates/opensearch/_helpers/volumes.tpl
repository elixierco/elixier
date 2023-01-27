{{ define "elixier-security.opensearch.volumes" }}
{{- end }}

{{ define "elixier-security.opensearch.volume-mounts" }}
- name: {{ include "elixier-security.fullname" . }}-opensearch-datadir
  mountPath: "/usr/share/opensearch/data"
{{- end }}

