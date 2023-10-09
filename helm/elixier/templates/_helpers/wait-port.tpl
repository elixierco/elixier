{{- define "elixier.waitPort" }}
- name: wait-{{ .Args.name }}
  image: "{{ .Values.global.waitForImage.repository }}:{{ .Values.global.waitForImage.tag }}"
  imagePullPolicy: {{ .Values.global.waitForImage.pullPolicy }}
  args: ["-H", '{{ .Args.host }}', "-p", "{{ .Args.port }}", '--timeout={{ .Values.global.containerWaitTimeout }}']
  resources:
    {{- toYaml .Values.global.utilResources | nindent 4 }}
{{- end }}
