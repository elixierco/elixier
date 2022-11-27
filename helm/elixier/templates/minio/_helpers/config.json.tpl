{{- define "mc-config-json" }}
{
    "version": "10",
    "aliases": {
        "local": {
            "url": {{ include "elixier.s3a.endpoint" . | quote }},
            "accessKey": "{{ .Values.minio.root_user }}",
            "secretKey": "{{ .Values.minio.root_password }}",
            "api": "S3v4",
            "path": "auto"
        }
    }
}
{{- end }}
