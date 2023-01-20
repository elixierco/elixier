{{- define "elixier.hive.metastore_db_url" -}}
    {{ .Values.hive.metastore_db_url | default (printf "jdbc:postgresql://%s-db/%s" (include "elixier.fullname" .) .Values.hive.metastore_db_name ) }}
{{- end -}}

{{- define "elixier.hive.metastore_uri" -}}
    {{ .Values.hive.metastore_uri | default (printf "thrift://%s-hms:%d" (include "elixier.fullname" .) (.Values.hive.metastore_port | int)) }}
{{- end -}}

{{- define "elixier.s3a.endpoint" -}}
    {{ .Values.s3a.endpoint | default (printf "http://%s-minio:9000" (include "elixier.fullname" .)) }}
{{- end -}}

{{- define "elixier.s3a.host" -}}
    {{ .Values.s3a.host | default (printf "%s-minio:9000" (include "elixier.fullname" .)) }}
{{- end -}}

{{- define "elixier.hue.bucket" -}}
    {{ .Values.hue.bucket | default "filesystem" }}
{{- end -}}

{{- define "elixier.gitweb.baseurl" -}}
    {{ .Values.git.gitweb_baseurl | default (printf "http://%s-gitweb/repo" (include "elixier.fullname" .)) }}
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

{{- define "elixier.hue.db_host" -}}
    {{ .Values.hue.db_host | default (printf "%s-db" (include "elixier.fullname" .)) }}
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
