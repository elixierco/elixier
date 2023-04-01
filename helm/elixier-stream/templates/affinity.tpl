{{ define "elixier-stream.affinity" }}
- key: app.kubernetes.io/name
  operator: In
  values:
    - {{ include "elixier-stream.name" . }}
- key: app.kubernetes.io/instance
  operator: In
  values:
    - {{ .Release.Name }}
{{- end }}

