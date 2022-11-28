{{- define "elixier.hive.metastore_db_url" -}}
    {{ .Values.hive.metastore_db_url | default (printf "jdbc:postgresql://%s-db/%s" (include "elixier.fullname" .) .Values.hive.metastore_db_name ) }}
{{- end -}}

{{- define "elixier.hive.metastore_uri" -}}
    {{ .Values.hive.metastore_uri | default (printf "thrift://%s-hms:%d" (include "elixier.fullname" .) (.Values.hive.metastore_port | int)) }}
{{- end -}}

{{- define "elixier.s3a.endpoint" -}}
    {{ .Values.s3a.endpoint | default (printf "http://%s-minio:9000" (include "elixier.fullname" .)) }}
{{- end -}}

