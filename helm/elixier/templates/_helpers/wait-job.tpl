{{- define "elixier.waitJob" }}
- name: wait-{{ .Container }}
  image: "{{ .Values.global.kubectlImage.repository }}:{{ .Values.global.kubectlImage.tag }}"
  imagePullPolicy: {{ .Values.global.kubectlImage.pullPolicy }}
  args: ["wait", 'job', '{{ .Release.Name }}-{{ .Container }}', '--for=condition=complete', '--timeout={{ .Values.global.containerWaitTimeout }}']
  resources:
    {{- toYaml .Values.global.utilResources | nindent 4 }}

{{- end -}}
