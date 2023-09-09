{{- define "elixier.wait-db" }}
- name: wait-db
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", "pod", '{{ include "elixier.fullname" . }}-db-0', '--for=condition=containersready', '--timeout={{ .Values.containerWaitTimeout }}']
{{- end }}
