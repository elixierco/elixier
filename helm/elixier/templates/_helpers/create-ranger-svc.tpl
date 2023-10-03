{{- define "elixier.createRangerSvc" }}
- name: create-ranger-service-{{ .Args.service }}
  image: "{{ .Values.global.rangerClientImage.repository }}:{{ .Values.global.rangerClientImage.tag }}"
  imagePullPolicy: {{ .Values.global.rangerClientImage.pullPolicy }}
  args: ["create-service", "-n", "{{ .Args.service }}", "-t", "{{ .Args.type }}", "-d", '{{ .Args.description | default "" }}', 
         "-c", '{{ .Args.config | toJson }}', '-u', '{{ .Values.global.ranger.adminUser | default "admin" }}', "-p", "{{ .Values.global.ranger.adminPass }}", 
         "-s", '{{ .Values.global.ranger.url | default (printf "http://%s-ranger:6080" .Release.Name) }}', '-i']
  resources:
    {{- toYaml .Values.global.utilResources | nindent 4 }}
{{- end }}
