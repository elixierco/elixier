{{- define "elixier.wait-minio" }}
- name: wait-minio
  image: "{{ .Values.global.kubectl_image.repository }}:{{ .Values.global.kubectl_image.tag }}"
  imagePullPolicy: {{ .Values.global.kubectl_image.pullPolicy }}
  args: ["wait", "pod", '{{ include "elixier.fullname" . }}-{{ .Values.minio.nameOverride }}-0', '--for=condition=containersready', '--timeout={{ .Values.global.containerWaitTimeout }}']
{{- end }}

