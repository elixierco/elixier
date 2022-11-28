{{- define "elixier.volumes" }}
- name: {{ include "elixier.fullname" . }}-spark-config
  secret:
    secretName: {{ include "elixier.fullname" . }}-spark-config
- name: {{ include "elixier.fullname" . }}-spark-datadir
  emptyDir: {}
{{- end }}

{{- define "elixier.volume-mounts" }}
- name: {{ include "elixier.fullname" . }}-spark-config
  mountPath: "/etc/spark3/"
# - name: {{ include "elixier.fullname" . }}-spark-config
#   mountPath: "/opt/apache/spark3/conf/"
- name: {{ include "elixier.fullname" . }}-spark-datadir
  mountPath: "/opt/apache/spark3/work-dir"

{{- end }}

