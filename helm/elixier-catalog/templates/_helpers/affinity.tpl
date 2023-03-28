{{ define "elixier-catalog.affinity" }}
- key: app.kubernetes.io/name
  operator: In
  values:
    - {{ include "elixier-catalog.name" . }}
- key: app.kubernetes.io/instance
  operator: In
  values:
    - {{ .Release.Name }}
{{- end }}

