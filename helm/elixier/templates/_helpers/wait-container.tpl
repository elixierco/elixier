{{- define "elixier.waitContainer" }}
- name: wait-{{ .Container }}
  image: "{{ .Values.global.kubectlImage.repository }}:{{ .Values.global.kubectlImage.tag }}"
  imagePullPolicy: {{ .Values.global.kubectlImage.pullPolicy }}
  args: ["wait", "pod", '{{ .Release.Name }}-{{ .Container }}', '--for=condition=containersready', '--timeout={{ .Values.global.containerWaitTimeout }}']
{{- end }}
