{{- define "elixier.hive.metastore_db_url" -}}
    {{ .Values.hive.metastore_db_url | default (printf "jdbc:postgresql://%s-db/%s" (include "elixier.fullname" .) .Values.hive.metastore_db_name ) }}
{{- end -}}

{{- define "elixier.hive.metastore_uri" -}}
    {{ .Values.hive.metastore_uri | default (printf "thrift://%s-hms:%d" (include "elixier.fullname" .) (.Values.hive.metastore_port | int)) }}
{{- end -}}

{{- define "elixier.s3a.endpoint" -}}
    {{ .Values.s3a.endpoint | default (printf "http://%s-minio:9000" (include "elixier.fullname" .)) }}
{{- end -}}

{{- define "elixier.gitweb.baseurl" -}}
    {{ .Values.git.gitweb_baseurl | default (printf "http://%s-gitweb/repo" (include "elixier.fullname" .)) }}
{{- end -}}

{{- define "elixier.airflow.dag_git_repository" -}}
    {{ .Values.airflow.dag_git_repository | default (printf "%s/%s" (include "elixier.git.gitweb_baseurl" .) .Values.git.project_name) }}
{{- end -}}

{{- define "elixier.airflow.db_uri" -}}
    {{ .Values.airflow.db_uri | default (printf "postgresql+psycopg2://%s:%s@%s-db/%s" .Values.airflow.db_user .Values.airflow.db_password (include "elixier.fullname" .) .Values.airflow.db_name) }}
{{- end -}}


