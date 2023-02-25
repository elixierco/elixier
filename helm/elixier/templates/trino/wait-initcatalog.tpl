{{- define "elixier.wait-trino-initcatalog" }}
- name: wait-trino-initcatalog
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", 'job', '{{ include "elixier.fullname" . }}-trino-initcatalog', '--for=condition=complete', '--timeout={{ .Values.containerWaitTimeout }}']
{{- end -}}
