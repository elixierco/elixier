{{- define "elixier.airflow.wait-scheduler" }}
- name: wait-scheduler
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", "pod", '{{ include "elixier.fullname" . }}-aflow-s-0', '--for=condition=containersready', '--timeout=300s']
{{- end }}

