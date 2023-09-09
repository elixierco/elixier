{{- define "elixier.gitweb.volumeMounts" -}}
- name: {{ include "elixier.fullname" . }}-datadir
  mountPath: /srv/git
{{- end }}

{{- define "elixier.gitweb.volumes" -}}
- name: {{ include "elixier.fullname" . }}-datadir
  persistentVolumeClaim:
    claimName: {{ include "elixier.fullname" . }}-git
{{- end }}

{{- define "elixier.gitweb.env" -}}
{{- if .Values.git.ssh_public_keys }}
- name: GIT_SSH_PUBKEYS
  valueFrom:
    secretKeyRef:
      name: {{ include "elixier.fullname" . }}-gitsecret
      key: ssh_public_keys
{{- end }}
- name: PROJECT_NAME
  value: {{ .Values.git.project_name }}
- name: GITWEB_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "elixier.fullname" . }}-gitsecret
      key: gitweb_user
- name: GITWEB_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "elixier.fullname" . }}-gitsecret
      key: gitweb_password
- name: BASE_URL
  valueFrom:
    secretKeyRef:
      name: {{ include "elixier.fullname" . }}-gitsecret
      key: gitweb_baseurl
{{- end }}

