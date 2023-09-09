{{- define "hive-env-script" }}
{{- if .Values.hive.metastore_java_options }}
export HADOOP_CLIENT_OPTS="{{ .Values.hive.metastore_java_options }}"
{{- end }}
{{- end }}
