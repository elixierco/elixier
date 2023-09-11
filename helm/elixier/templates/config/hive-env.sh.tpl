{{- define "hive-env.sh" }}
export HADOOP_CLIENT_OPTS="{{ .Values.global.hadoopClientOpts | default ""}}"
{{- end }}
