{{- define "elixier.hive.metastore_db_url" -}}
    {{ .Values.hive.metastore_db_url | default (printf "jdbc:postgresql://%s-db/%s" (include "elixier.fullname" .) .Values.hive.metastore_db_name ) }}
{{- end -}}

{{- define "elixier.hive.metastore_uri" -}}
    {{ .Values.hive.metastore_uri | default (printf "thrift://%s-hms:%d" (include "elixier.fullname" .) (.Values.hive.metastore_port | int)) }}
{{- end -}}

{{- define "elixier.s3a.endpoint" -}}
    {{ .Values.s3a.endpoint | default (printf "%s://%s" (include "elixier.s3a.protocol" .) (include "elixier.s3a.host" .)) }}
{{- end -}}

{{- define "elixier.s3a.endpoint_with_identity" -}}
    {{ .Values.s3a.endpoint_with_identity | default (printf "%s://%s:%s@%s" (include "elixier.s3a.protocol" .) .Values.s3a.access_key .Values.s3a.secret_key (include "elixier.s3a.host" .))}}
{{- end -}}

{{- define "elixier.s3a.host" -}}
    {{ .Values.s3a.host | default (printf "%s-minio:9000" (include "elixier.fullname" .)) }}
{{- end -}}

{{- define "elixier.s3a.protocol" -}}
    {{ .Values.s3a.protocol | default "http" }}
{{- end -}}

{{- define "elixier.gitweb.baseurl" -}}
    {{ .Values.git.gitweb_baseurl | default (printf "http://%s-gitweb/repo" (include "elixier.fullname" .)) }}
{{- end -}}

{{- define "elixier.spark.bucket" -}}
    {{ .Values.spark.bucket | default "warehouse" }}
{{- end -}}

{{- define "elixier.airflow.dag_git_repository" -}}
    {{ .Values.airflow.dag_git_repository | default (printf "%s/%s" (include "elixier.gitweb.baseurl" .) .Values.git.project_name) }}
{{- end -}}

{{- define "elixier.airflow.db_uri" -}}
    {{ .Values.airflow.db_uri | default (printf "postgresql+psycopg2://%s:%s@%s-db/%s" .Values.airflow.db_user .Values.airflow.db_password (include "elixier.fullname" .) .Values.airflow.db_name) }}
{{- end -}}

{{- define "elixier.jupyterhub.db_uri" -}}
    {{ .Values.jupyterhub.db_uri | default (printf "postgresql+psycopg2://%s:%s@%s-db/%s" .Values.jupyterhub.db_user .Values.jupyterhub.db_password (include "elixier.fullname" .) .Values.jupyterhub.db_name) }}
{{- end -}}

{{- define "elixier.jupyterhub.env_keep" -}}
- MC_HOST_objectstore
{{- if .Values.jupyterhub.env_keep }}
{{ toYaml .Values.jupyterhub.env_keep }}
{{- end }}
{{- end -}}

{{- define "elixier.superset.db_uri" -}}
    {{ .Values.superset.db_uri | default (printf "postgresql+psycopg2://%s:%s@%s-db/%s" .Values.superset.db_user .Values.superset.db_password (include "elixier.fullname" .) .Values.superset.db_name) }}
{{- end -}}

{{- define "elixier.minio.console_url" -}}
    {{ .Values.minio.console_url | default (printf "http://minio-console.%s" .Values.ingress.domain) }}
{{- end -}}

{{- define "elixier.s3gw.gw_hostname" -}}
    {{ .Values.s3gw.gw_hostname | default (printf "s3.%s" .Values.ingress.domain) }}
{{- end -}}

{{- define "elixier.keycloak.url" -}}
    {{ .Values.keycloak.url | default (printf "http://keycloak.%s" .Values.ingress.domain) }}
{{- end -}}

{{- define "elixier.keycloak.issuer" -}}
    {{ printf "%s/realms/%s" (include "elixier.keycloak.url" .) .Values.keycloak.realm }}
{{- end -}}

{{- define "elixier.keycloak.api_base_url" -}}
    {{ printf "%s/protocol/openid-connect" (include "elixier.keycloak.issuer" .) }}
{{- end -}}

{{- define "elixier.keycloak.authorization_endpoint" -}}
    {{ printf "%s/auth" (include "elixier.keycloak.api_base_url" .) }}
{{- end -}}

{{- define "elixier.keycloak.token_endpoint" -}}
    {{ printf "%s/token" (include "elixier.keycloak.api_base_url" .) }}
{{- end -}}

{{- define "elixier.keycloak.introspection_endpoint" -}}
    {{ printf "%s/introspect" (include "elixier.keycloak.api_base_url" .) }}
{{- end -}}

{{- define "elixier.keycloak.userinfo_endpoint" -}}
    {{ printf "%s/userinfo" (include "elixier.keycloak.api_base_url" .) }}
{{- end -}}

{{- define "elixier.keycloak.end_session_endpoint" -}}
    {{ printf "%s/logout" (include "elixier.keycloak.api_base_url" .) }}
{{- end -}}

{{- define "elixier.keycloak.server_metadata_url" -}}
    {{ printf "%s/.well-known/openid-configuration" (include "elixier.keycloak.issuer" .) }}
{{- end -}}
