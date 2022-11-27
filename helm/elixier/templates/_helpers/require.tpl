{{- define "require" -}}
    {{- $deploy_cluster := .Values.spark.deploy_cluster -}}
    {{- $deploy_thrift := .Values.spark.deploy_thrift -}}
    {{- if .Values.ingress.enabled -}}
        {{- with .Values.ingress -}}
            {{- if $deploy_cluster -}}
                {{- $host := .host | required "ingress.host is required" -}}
            {{- end -}}
            {{- if $deploy_thrift -}}
                {{- $host := .thrift_host | required "ingress.thrift_host is required" -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}

    {{- $metastore_db_type := .Values.hive.metastore_db_type | required "hive.metastore_db_type is required" -}}
    {{- $metastore_db_driver := .Values.hive.metastore_db_driver | required "hive.metastore_db_driver is required" -}}
    {{- $metastore_warehouse_dir := .Values.hive.metastore_warehouse_dir | required "hive.metastore_warehouse_dir is required" -}}

    {{- $s3a_access_key := .Values.s3a.access_key | required "s3a.access_key is required" -}}
    {{- $s3a_secret_key := .Values.s3a.secret_key | required "s3a.secret_key is required" -}}
{{- end -}}

