{{- define "elixier.airflow.wait-gitsync" }}
- name: wait-gitsync
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", "pod", '{{ include "elixier.fullname" . }}-gitweb-0', '--for=condition=containersready', '--timeout={{ .Values.containerWaitTimeout }}']
{{- end }}

