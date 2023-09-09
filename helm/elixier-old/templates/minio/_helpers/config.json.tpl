{{- define "mc-config-json" }}
{
    "version": "10",
    "aliases": {
        "local": {
            "url": {{ include "elixier.s3a.endpoint" . | quote }},
            "accessKey": "{{ .Values.s3a.access_key }}",
            "secretKey": "{{ .Values.s3a.secret_key }}",
            "api": "S3v4",
            "path": "auto"
        }
    }
}
{{- end }}
