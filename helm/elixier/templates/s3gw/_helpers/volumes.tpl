{{- define "elixier.s3gw.volumes" }}
- name: {{ include "elixier.fullname" . }}-s3-datadir
  persistentVolumeClaim:
    claimName: {{ include "elixier.fullname" . }}-s3-datadir
{{- end }}

{{- define "elixier.s3gw.volume-mounts" }}
- name: {{ include "elixier.fullname" . }}-s3-datadir
  mountPath: "/data"
{{- end }}
