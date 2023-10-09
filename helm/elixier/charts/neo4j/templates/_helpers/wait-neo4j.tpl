{{- define "elixier-catalog.wait-neo4j" }}
- name: wait-neo4j
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", "pod", '{{ include "elixier-catalog.fullname" . }}-neo4j-0', '--for=condition=containersready', '--timeout={{ .Values.containerWaitTimeout }}']
{{- end }}

