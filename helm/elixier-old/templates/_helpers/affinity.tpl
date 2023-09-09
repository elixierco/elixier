{{ define "elixier.affinity" }}
- key: app.kubernetes.io/name
  operator: In
  values:
    - {{ include "elixier.name" . }}
- key: app.kubernetes.io/instance
  operator: In
  values:
    - {{ .Release.Name }}
{{- end }}

