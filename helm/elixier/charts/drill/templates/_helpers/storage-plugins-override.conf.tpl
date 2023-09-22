{{ define "storage-plugins-override.conf" }}
"storage": {
  hive: {
    type: "hive",
    configProps: {
        "hive.metastore.sasl.enabled": "false",
        "hive.metastore.uris": "thrift://{{- .Values.global.metastore.host -}}:{{- .Values.global.metastore.port -}}",
        "hive.metastore.schema.verification": "false",
        "hive.metastore.warehouse.dir": "{{- .Values.global.s3a.warehouseDir -}}",
        "hive.metastore.execute.setugi": "true",
        "fs.s3a.access.key": "{{- .Values.global.s3a.accessKey -}}",
        "fs.s3a.secret.key": "{{- .Values.global.s3a.secretKey -}}",
        "fs.s3a.impl": "org.apache.hadoop.fs.s3a.S3AFileSystem",
        "fs.s3a.endpoint": "{{- .Values.global.s3a.endpoint -}}",
        "fs.s3a.path.style.access": "true"
    },
    enabled: true,
    authMode: "SHARED_USER"
  }
}
{{ end }}
