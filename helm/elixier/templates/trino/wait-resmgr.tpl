{{- define "elixier.wait-trino-resmgr" }}
- name: wait-trino-resmgr
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", 'deployment', '{{ include "elixier.fullname" . }}-trino-r', '--for=condition=Available=true', '--timeout={{ .Values.containerWaitTimeout }}']
{{- end -}}
