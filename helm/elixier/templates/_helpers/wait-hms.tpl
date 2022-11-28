{{- define "elixier.wait-hms" }}
- name: wait-hms
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", "pod", '{{ include "elixier.fullname" . }}-hms-0', '--for=condition=containersready', '--timeout=300s']
{{- end }}

