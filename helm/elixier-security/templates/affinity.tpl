{{ define "elixier-security.affinity" }}
- key: app.kubernetes.io/name
  operator: In
  values:
    - {{ include "elixier-security.name" . }}
- key: app.kubernetes.io/instance
  operator: In
  values:
    - {{ .Release.Name }}
{{- end }}

