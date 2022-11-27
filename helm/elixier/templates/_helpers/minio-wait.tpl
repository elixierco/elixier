{{- define "elixier.minio-wait" }}
- name: db-wait
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", "pod", '{{ include "elixier.fullname" . }}-minio-0', '--for=condition=containersready', '--timeout=300s']
{{- end }}

