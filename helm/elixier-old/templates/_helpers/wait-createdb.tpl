{{- define "elixier.wait-createdb" }}
- name: wait-createdb
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", 'job/{{ include "elixier.fullname" . }}-pgsql-createdb', '--for=condition=complete', '--timeout={{ .Values.containerWaitTimeout }}']
{{- end -}}
