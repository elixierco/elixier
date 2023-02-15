{{- define "elixier.wait-presto-initcatalog" }}
- name: wait-presto-initcatalog
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", 'job', '{{ include "elixier.fullname" . }}-presto-initcatalog', '--for=condition=complete', '--timeout={{ .Values.containerWaitTimeout }}']
{{- end -}}
