{{ define "elixier.superset.env" }}
- name: DEFAULT_ADMIN
  valueFrom:
    secretKeyRef:
      name: {{ include "elixier.fullname" . }}-superset-secrets
      key: admin-username

- name: DEFAULT_ADMIN_PASSWORD
  valueFrom:  
    secretKeyRef:
      name: {{ include "elixier.fullname" . }}-superset-secrets
      key: admin-password

- name: DEFAULT_ADMIN_EMAIL
  valueFrom:  
    secretKeyRef:
      name: {{ include "elixier.fullname" . }}-superset-secrets
      key: admin-email


{{- end }}
