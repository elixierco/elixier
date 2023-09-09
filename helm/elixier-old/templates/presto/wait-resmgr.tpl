{{- define "elixier.wait-presto-resmgr" }}
- name: wait-presto-resmgr
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", 'deployment', '{{ include "elixier.fullname" . }}-presto-r', '--for=condition=Available=true', '--timeout={{ .Values.containerWaitTimeout }}']
{{- end -}}
