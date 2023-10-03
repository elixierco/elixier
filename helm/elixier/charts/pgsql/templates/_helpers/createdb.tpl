{{- define "pgsql.createDb" }}
- name: createdb-{{ .Args.dbName }}
  image: "{{ .Values.global.kubectlImage.repository }}:{{ .Values.global.kubectlImage.tag }}"
  imagePullPolicy: {{ .Values.global.kubectlImage.pullPolicy }}
  args: ["exec", "-ti", '{{ .Release.Name }}-{{ .Container }}', "--",
         "createdb_with_user.sh", "-d", "{{ .Args.dbName }}", 
         "-u", "{{ .Args.dbUser }}", "-p", "{{ .Args.dbPass }}"]
  resources:
    {{- toYaml .Values.global.utilResources | nindent 4 }}

{{- end }}
