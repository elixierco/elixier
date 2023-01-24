{{- define "elixier.ranger.db_flavor" -}}
    {{- if eq .Values.ranger.db_type "postgres" -}}
        POSTGRES
    {{- else if eq .Values.ranger.db_type "mysql" -}}
        MYSQL
    {{- else if eq .Values.ranger.db_type "mssql" -}}
        MSSQL
    {{- else if eq .Values.ranger.db_type "oracle" -}}
        ORACLE
    {{- else -}}
        {{ .Values.undef | required "Unknown database type" }}
    {{- end -}}
{{- end -}}

{{- define "elixier.ranger.db_connector_jar" -}}
    {{- if eq .Values.ranger.db_type "postgres" -}}
        /usr/share/java/postgresql.jar
    {{- else if eq .Values.ranger.db_type "mysql" -}}
        /usr/share/java/mysql-connector-java.jar
    {{- else if eq .Values.ranger.db_type "mssql" -}}
        /usr/share/java/sqljdbc4.jar
    {{- else if eq .Values.ranger.db_type "oracle" -}}
        /usr/share/java/ojdbc6.jar
    {{- else -}}
        {{ .Values.undef | required "Unknown database type" }}
    {{- end -}}
{{- end -}}

{{- define "elixier.ranger.opensearch_urls" -}}
    {{ .Values.ranger.opensearch_urls | default (printf "%s-opensearch" (include "elixier.fullname" .)) }}
{{- end -}}

{{- define "elixier.ranger.db_host" -}}
    {{ .Values.ranger.db_host | default (printf "%s-db" (include "elixier.fullname" .)) }}
{{- end -}}
