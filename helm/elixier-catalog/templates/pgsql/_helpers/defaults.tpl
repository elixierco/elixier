{{- define "elixier-catalog.pgsql.volume_path" -}}
    {{ .Values.pgsql.volume_path | default "/var/lib/pgsql" }}
{{- end -}}
