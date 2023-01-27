{{- define "elixier-security.wait-osearch" }}
- name: wait-osearch
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", 'pod', '{{ include "elixier-security.fullname" . }}-osearch-m-0', '--for=condition=containersready', '--timeout={{ .Values.containerWaitTimeout }}']
{{- end -}}

