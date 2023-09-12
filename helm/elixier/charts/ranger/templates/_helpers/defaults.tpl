{{- define "ranger.dbFlavor" -}}
    {{- if eq .Values.dbType "postgres" -}}
        POSTGRES
    {{- else if eq .Values.dbType "mysql" -}}
        MYSQL
    {{- else if eq .Values.ranger.dbType "mssql" -}}
        MSSQL
    {{- else if eq .Values.ranger.dbType "oracle" -}}
        ORACLE
    {{- else -}}
        {{ .Values.undef | required "Unknown database type" }}
    {{- end -}}
{{- end -}}

{{- define "ranger.dbConnectorJar" -}}
    {{- if eq .Values.dbType "postgres" -}}
        /usr/share/java/postgresql.jar
    {{- else if eq .Values.dbType "mysql" -}}
        /usr/share/java/mysql-connector-java.jar
    {{- else if eq .Values.dbType "mssql" -}}
        /usr/share/java/sqljdbc4.jar
    {{- else if eq .Values.dbType "oracle" -}}
        /usr/share/java/ojdbc6.jar
    {{- else -}}
        {{ .Values.undef | required "Unknown database type" }}
    {{- end -}}
{{- end -}}


