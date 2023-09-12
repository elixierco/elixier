{{ define "elixier.volumes" -}}
- name: keystore
  secret:
    secretName: {{ .Release.Name }}-keystore
{{- end }}

{{ define "elixier.volumeMounts" -}}
- name: keystore
  mountPath: "/etc/keystore/"
{{- end }}
