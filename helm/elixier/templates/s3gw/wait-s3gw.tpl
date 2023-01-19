{{- define "elixier.wait-s3gw" }}
- name: wait-minio
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", "deployment", '{{ include "elixier.fullname" . }}-s3gw', '--for=condition=Available=True', '--timeout={{ .Values.containerWaitTimeout }}']
{{- end }}

