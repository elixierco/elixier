{{- define "elixier-security.wait-db" }}
- name: wait-db
  image: "{{ .Values.kubectl_image.repository }}:{{ .Values.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.kubectl_image.pullPolicy }}
  args: ["wait", "pod", '{{ include "elixier-security.fullname" . }}-db-0', '--for=condition=containersready', '--timeout={{ .Values.containerWaitTimeout }}']
  resources:
    {{- toYaml .Values.initContainers.resources | nindent 4 }}

{{- end }}
