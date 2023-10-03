{{- define "elixier.waitDeployment" }}
- name: wait-{{ .Container }}
  image: "{{ .Values.global.kubectlImage.repository }}:{{ .Values.global.kubectlImage.tag }}"
  imagePullPolicy: {{ .Values.global.kubectlImage.pullPolicy }}
  args: ["wait", "deployment", '{{ .Release.Name }}-{{ .Container }}', '--for=condition=available', '--timeout={{ .Values.global.containerWaitTimeout }}']
  resources:
    {{- toYaml .Values.global.utilResources | nindent 4 }}
{{- end }}
